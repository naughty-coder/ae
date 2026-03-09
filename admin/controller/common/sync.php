<?php
/**
 * Ozon → OpenCart 3.0.x Sync Controller
 * Путь:  catalog/controller/common/sync.php
 *
 * Обычный запуск:  /index.php?route=common/sync&token=YOUR_SECRET_TOKEN
 * Полная очистка:  /index.php?route=common/sync&token=YOUR_SECRET_TOKEN&clean=1
 *
 * Эндпоинты:
 *   POST /v3/product/list                     — список product_id
 *   POST /v3/product/info/list                — детали + sku/qty из stocks.stocks[]
 *   POST /v4/product/info/attributes          — атрибуты товаров (cursor)
 *   POST /v1/description-category/attribute   — словарь названий атрибутов по category
 *   POST /v2/product/pictures/info            — картинки
 *   POST /v1/description-category/tree        — название категории (роль «Контент»)
 */

class ControllerCommonSync extends Controller {

    // ─── Настройки ────────────────────────────────────────────────────────────
    private $clientId = '852906';
    private $apiKey   = '94869c49-5d5c-4d27-9db4-0c53e990d528';
    private $base     = 'https://api-seller.ozon.ru';
    private $token    = 'YOUR_SECRET_TOKEN';
    private $langId   = 1;
    private $storeId  = 0;

    // Атрибуты Ozon, которые идут в физические поля oc_product (не в характеристики)
    // ozon_attr_id => поле oc_product
    // 9048 = Название, 9049 = Аннотация (описание), 8229 = Тип
    // физические: у каждой категории могут быть свои ID → фильтруем по ключу params
    private $physicalParamKeys = array('height','depth','width','weight');

    // ─── Состояние ────────────────────────────────────────────────────────────
    private $products        = array(); // ozon_id => data
    private $categoryMap     = array(); // ozon_cat_id => oc_category_id
    private $attrNameCache   = array(); // ozon_attr_id => human name
    private $typeIdCache     = array(); // description_category_id => type_id
    private $catAttrLoaded   = array(); // 'cat_ID_typeID' => true
    private $attrGroupId     = 0;
    private $catalogRootId  = 1;   // oc_category_id корневой категории «Каталог»
    private $ocAttrIdCache   = array(); // human_name => oc_attribute_id
    private $imageDir;
    private $logFile;

    // ─────────────────────────────────────────────────────────────────────────

    public function index() {
        @set_time_limit(0);
        @ini_set('memory_limit', '512M');

        $this->imageDir = DIR_IMAGE;
        $this->logFile  = DIR_LOGS . 'ozon_sync_' . date('Y-m-d') . '.log';

        $token = isset($this->request->get['token']) ? $this->request->get['token'] : '';
        if ($token !== $this->token) {
            die('Access denied.');
        }

        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
            header('X-Accel-Buffering: no');
        }

        $this->log('=== Ozon Sync started ' . date('Y-m-d H:i:s') . ' ===');

        try {
            if (!empty($this->request->get['clean'])) {
                $this->cleanAll();
            }
            $this->ensureAttrGroup();
            $this->ensureCatalogRoot();
            $this->fetchAllProducts();
            $this->syncProducts();
        } catch (Exception $e) {
            $this->log('FATAL: ' . $e->getMessage());
        }

        $this->log('=== Ozon Sync finished ' . date('Y-m-d H:i:s') . ' ===');
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  OZON API
    // ═════════════════════════════════════════════════════════════════════════

    private function ozonRequest($url, $data) {
        $ch = curl_init($this->base . $url);
        curl_setopt_array($ch, array(
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST           => true,
            CURLOPT_TIMEOUT        => 30,
            CURLOPT_HTTPHEADER     => array(
                'Client-Id: '    . $this->clientId,
                'Api-Key: '      . $this->apiKey,
                'Content-Type: application/json',
            ),
            CURLOPT_POSTFIELDS => json_encode($data),
        ));

        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $err      = curl_error($ch);
        curl_close($ch);

        if ($err) throw new Exception("cURL [{$url}]: {$err}");
        if ($httpCode >= 400) {
            $this->log("  HTTP {$httpCode} [{$url}]: " . substr($response, 0, 400));
            throw new Exception("HTTP {$httpCode} [{$url}]");
        }

        $decoded = json_decode($response, true);
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("JSON [{$url}]: " . substr($response, 0, 200));
        }
        if (!empty($decoded['code']) && $decoded['code'] !== 0) {
            throw new Exception("Ozon [{$url}]: " . ($decoded['message'] ?? ''));
        }

        return $decoded;
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ШАГ 1 — product_id list  (/v3/product/list)
    // ═════════════════════════════════════════════════════════════════════════

    private function fetchProductIds() {
        $ids = array(); $lastId = null;
        $this->log('Step 1: /v3/product/list ...');
        do {
            $payload = array('filter' => array('visibility' => 'ALL'), 'limit' => 1000);
            if ($lastId !== null) $payload['last_id'] = $lastId;

            $res   = $this->ozonRequest('/v3/product/list', $payload);
            $items = isset($res['result']['items']) ? $res['result']['items'] : array();
            if (empty($items)) break;

            foreach ($items as $it) $ids[] = (int)$it['product_id'];
            $lastId = isset($res['result']['last_id']) ? $res['result']['last_id'] : null;
            $this->log('  batch=' . count($items) . ' total=' . count($ids));
            if (count($items) < 1000) break;
        } while (true);

        $this->log('Total IDs: ' . count($ids));
        return $ids;
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ШАГ 2 — детали  (/v3/product/info/list)
    //  SKU и qty — из stocks.stocks[]: sku=последний, qty=сумма present
    // ═════════════════════════════════════════════════════════════════════════

    private function fetchDetails(array $allIds) {
        $this->log('Step 2: /v3/product/info/list ...');

        foreach (array_chunk($allIds, 100) as $chunk) {
            $res   = $this->ozonRequest('/v3/product/info/list', array('product_id' => $chunk));
            $items = isset($res['items']) ? $res['items']
                   : (isset($res['result']['items']) ? $res['result']['items'] : array());

            foreach ($items as $item) {
                $ozonId = (int)$item['id'];

                // SKU + qty
                $sku = false;
                $qty = 0;
                if (!empty($item['stocks']['stocks']) && is_array($item['stocks']['stocks'])) {
                    foreach ($item['stocks']['stocks'] as $stock) {
                        $sku  = $stock['sku'];
                        $qty += (int)$stock['present'];
                    }
                } else {
                  $sku = $item['sku'];
                }

                // primary_image: строка или массив
                $primaryImage = '';
                if (!empty($item['primary_image'])) {
                    $primaryImage = is_array($item['primary_image'])
                        ? (string)reset($item['primary_image'])
                        : (string)$item['primary_image'];
                }

                $this->products[$ozonId] = array(
                    'id'            => $ozonId,
                    'offer_id'      => isset($item['offer_id'])  ? $item['offer_id']  : '',
                    'sku'           => $sku,
                    'name'          => isset($item['name'])      ? $item['name']      : '',
                    'description'   => isset($item['description']) ? $item['description'] : '',
                    'primary_image' => $primaryImage,
                    'images'        => isset($item['images'])    ? $item['images']    : array(),
                    'images360'     => isset($item['images360']) ? $item['images360'] : array(),
                    'qty'           => $qty,
                    // Цены заполняются в fetchPrices() из /v5/product/info/prices
                    'price'         => 0,
                    'old_price'     => 0,
                    'barcode'       => isset($item['barcode'])   ? $item['barcode']   : '',
                    'brand'         => isset($item['brand'])     ? $item['brand']     : '',
                    // description_category_id уточним из /v4/product/info/attributes
                    'description_category_id' => isset($item['description_category_id'])
                                                ? (int)$item['description_category_id'] : 0,
                    // физические поля (заполним из /v4/attributes)
                    'weight' => 0, 'length' => 0, 'width' => 0, 'height' => 0,
                    'type_id'    => 0,            // заполним из /v4/attributes
                    // атрибуты: [ human_name => value, ... ]
                    'attributes' => array(),
                );
            }
            usleep(200000);
        }
        $this->log('Details: ' . count($this->products));
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ШАГ 3 — атрибуты  (/v4/product/info/attributes)
    //
    //  Возвращает: attributes[].id (числовой) + values[].value
    //  Названия атрибутов получаем через /v1/description-category/attribute
    //  и кешируем в $attrNameCache.
    //
    //  Физические поля (height/depth/width/weight) → поля oc_product, не в атрибуты.
    // ═════════════════════════════════════════════════════════════════════════

    private function fetchAttributes(array $allIds) {
        $this->log('Step 3: /v4/product/info/attributes ...');
        $cursor = ''; $total = 0;

        do {
            $res = $this->ozonRequest('/v4/product/info/attributes', array(
                'filter'   => array('product_id' => $allIds, 'visibility' => 'ALL'),
                'limit'    => 1000,
                'cursor'   => $cursor,
                'sort_dir' => 'ASC',
            ));

            foreach (isset($res['result']) ? $res['result'] : array() as $item) {
                $id = (int)$item['id'];
                if (!isset($this->products[$id])) continue;

                $p   = &$this->products[$id];
                $catId  = isset($item['description_category_id']) ? (int)$item['description_category_id'] : 0;
                $typeId = isset($item['type_id'])                 ? (int)$item['type_id']                 : 0;
                if ($catId)  $p['description_category_id'] = $catId;
                if ($typeId) $p['type_id'] = $typeId;  // нужен для загрузки названий атрибутов

                // Физические параметры из корня item
                foreach (array('height','depth','width','weight','dimension_unit','weight_unit') as $k) {
                    if (isset($item[$k]) && $item[$k] !== '' && $item[$k] !== null) {
                        $p['_params'][$k] = $item[$k];
                    }
                }

                // Конвертация физических полей
                $dimUnit = isset($p['_params']['dimension_unit']) ? strtolower($p['_params']['dimension_unit']) : 'mm';
                $wUnit   = isset($p['_params']['weight_unit'])    ? strtolower($p['_params']['weight_unit'])    : 'g';
                if (isset($p['_params']['weight'])) {
                    $w = (float)$p['_params']['weight'];
                    $p['weight'] = ($wUnit === 'kg') ? $w : round($w / 1000, 3);
                }
                foreach (array('depth' => 'length', 'width' => 'width', 'height' => 'height') as $ok => $ock) {
                    if (isset($p['_params'][$ok])) {
                        $val = (float)$p['_params'][$ok];
                        $p[$ock] = ($dimUnit === 'mm') ? round($val / 10, 2) : $val;
                    }
                }

                // Атрибуты: числовой ID → human name
                // Служебные атрибуты, которые НЕ дублируем в characteristics:
                static $skipNames = array(
                    'название', 'наименование', 'name', 'title',        // → product.name
                    'аннотация', 'описание', 'annotation', 'description', // → product_description.description
                    'бренд', 'brand', 'торговая марка', 'производитель', // → manufacturer
                    'высота', 'глубина', 'ширина', 'длина', 'вес',       // → физические поля
                    'height', 'depth', 'width', 'length', 'weight',
                );
                foreach ($item['attributes'] as $attr) {
                    $attrId  = (int)$attr['id'];
                    $values  = array();
                    foreach ($attr['values'] as $v) {
                        if (isset($v['value']) && $v['value'] !== '') $values[] = $v['value'];
                    }
                    if (empty($values)) continue;

                    $humanName = $this->getAttrName($attrId, $catId, $typeId);
                    if (!$humanName) continue;

                    $lname = mb_strtolower($humanName);

                    // Аннотация → description (html_entity_decode потом при выводе, encode при сохранении)
                    if (in_array($lname, array('аннотация', 'annotation'))) {
                        if (empty($p['description'])) {
                            $p['description'] = htmlspecialchars(implode(' ', $values), ENT_QUOTES, 'UTF-8');
                        }
                        continue;
                    }

                    // Название — уже есть в name, не дублируем
                    if (in_array($lname, array('название', 'наименование', 'name', 'title'))) continue;

                    // Бренд — уже идёт в manufacturer
                    if (in_array($lname, array('бренд', 'brand', 'торговая марка', 'производитель'))) {
                        if (empty($p['brand'])) $p['brand'] = $values[0];
                        continue;
                    }

                    // Физические поля — уже в product
                    if (in_array($lname, array('высота', 'глубина', 'ширина', 'длина', 'вес',
                                               'height', 'depth', 'width', 'length', 'weight'))) continue;

                    $p['attributes'][$humanName] = implode(', ', $values);
                }

                $total++;
                unset($p);
            }

            // cursor может быть в корне или внутри result
            $cursor = '';
            if (!empty($res['cursor']))          $cursor = $res['cursor'];
            elseif (!empty($res['result']['cursor'])) $cursor = $res['result']['cursor'];

        } while ($cursor);

        $this->log('Attributes loaded for ' . $total . ' products.');
    }

    // ─── Получить название атрибута по его ID ─────────────────────────────────
    // Получить человекочитаемое название атрибута Ozon по его числовому ID.
    //
    // Схема:
    //   1. /v1/description-category/tree(description_category_id) → type_id
    //   2. /v1/description-category/attribute(description_category_id, type_id) → [{id, name}]
    //
    // type_id живёт в листе дерева (поле type_id у типов товара).
    // description_category_id — это ID подкатегории (родителя типа).
    private function getAttrName($attrId, $catId = 0, $typeId = 0) {
        if (isset($this->attrNameCache[$attrId])) {
            return $this->attrNameCache[$attrId];
        }

        if (!$catId || !$typeId) return '';

        // Загрузить атрибуты для пары (catId, typeId) — один раз
        $cacheKey = $catId . '_' . $typeId;
        if (!isset($this->catAttrLoaded[$cacheKey])) {
            $this->catAttrLoaded[$cacheKey] = true;
            try {
                $res = $this->ozonRequest('/v1/description-category/attribute', array(
                    'description_category_id' => (int)$catId,
                    'type_id'                 => (int)$typeId,
                    'language'                => 'RU',
                ));
                foreach (isset($res['result']) ? $res['result'] : array() as $a) {
                    if (!empty($a['id']) && !empty($a['name'])) {
                        $this->attrNameCache[(int)$a['id']] = $a['name'];
                    }
                }
                $this->log("  Loaded " . count($res['result'] ?? array()) . " attr names for cat={$catId} type={$typeId}");
            } catch (Exception $e) {
                $this->log("  WARN attr names cat={$catId} type={$typeId}: " . $e->getMessage());
            }
        }

        return isset($this->attrNameCache[$attrId]) ? $this->attrNameCache[$attrId] : '';
    }

    // Получить type_id для description_category_id через дерево категорий.
    // Дерево: category → subcategory → type (листья).
    // description_category_id может быть ID подкатегории; type_id — у листьев.
    private function getTypeId($catId) {
        if (isset($this->typeIdCache[$catId])) {
            return $this->typeIdCache[$catId];
        }

        try {
            $res = $this->ozonRequest('/v1/description-category/tree', array(
                'description_category_id' => (int)$catId,
                'language'                => 'RU',
            ));
            // Рекурсивно ищем type_id в дереве
            $typeId = $this->extractTypeIdFromTree(isset($res['result']) ? $res['result'] : array());
            $this->typeIdCache[$catId] = $typeId;
            return $typeId;
        } catch (Exception $e) {
            $this->log("  WARN getTypeId cat={$catId}: " . $e->getMessage());
            $this->typeIdCache[$catId] = 0;
            return 0;
        }
    }

    private function extractTypeIdFromTree(array $nodes) {
        foreach ($nodes as $node) {
            // Листовой узел типа товара содержит type_id
            if (!empty($node['type_id'])) {
                return (int)$node['type_id'];
            }
            // Рекурсивно в детях
            if (!empty($node['children'])) {
                $found = $this->extractTypeIdFromTree($node['children']);
                if ($found) return $found;
            }
        }
        return 0;
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ШАГ 4 — картинки  (/v2/product/pictures/info)
    // ═════════════════════════════════════════════════════════════════════════

    private function fetchPictures(array $allIds) {
        $this->log('Step 4: /v2/product/pictures/info ...');

        foreach (array_chunk($allIds, 100) as $chunk) {
            try {
                $res = $this->ozonRequest('/v2/product/pictures/info', array('product_id' => $chunk));
                foreach (isset($res['pictures']) ? $res['pictures'] : array() as $pic) {
                    $pid = isset($pic['product_id']) ? (int)$pic['product_id'] : 0;
                    if (!$pid || empty($pic['url'])) continue;
                    if (!isset($this->products[$pid])) continue;

                    if (!empty($pic['is_main'])) {
                        $this->products[$pid]['primary_image'] = $pic['url'];
                    } elseif (!in_array($pic['url'], $this->products[$pid]['images'])) {
                        $this->products[$pid]['images'][] = $pic['url'];
                    }
                }
            } catch (Exception $e) {
                $this->log('  WARN pictures: ' . $e->getMessage());
            }
            usleep(200000);
        }
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ШАГ 2б — цены  (/v5/product/info/prices, cursor-пагинация)
    //
    //  Актуальные поля price.* (ноябрь 2025):
    //    price                  — цена продавца (базовая)
    //    old_price              — зачёркнутая «до скидки» (0 если нет)
    //    marketing_seller_price — цена продавца в акции (0 если не участвует)
    //    min_price              — минимальная цена (ограничение продавца)
    //
    //  Примечание: marketing_price (скидка самого Ozon) удалён из API в ноябре 2025.
    //  Итоговую «цену покупателя» Ozon больше не отдаёт — используем цену продавца.
    //
    //  Логика:
    //    salePrice  = marketing_seller_price если > 0, иначе price
    //    crossPrice = old_price если строго > salePrice, иначе 0
    //
    //  В OpenCart:
    //    product.price         = crossPrice (зачёркнутая) если > 0, иначе salePrice
    //    product_special.price = salePrice  (скидочная, только если crossPrice > 0)
    // ═════════════════════════════════════════════════════════════════════════

    private function fetchPrices(array $allIds) {
        $this->log('Step 2b: /v5/product/info/prices ...');
        $cursor = ''; $count = 0;

        do {
            $res = $this->ozonRequest('/v5/product/info/prices', array(
                'filter' => array('product_id' => $allIds, 'visibility' => 'ALL'),
                'limit'  => 1000,
                'cursor' => $cursor,
            ));

            foreach (isset($res['items']) ? $res['items'] : array() as $item) {
                $pid = (int)$item['product_id'];
                if (!isset($this->products[$pid])) continue;

                $pr = isset($item['price']) ? $item['price'] : array();

                $priceRaw        = isset($pr['price'])                  ? (float)$pr['price']                  : 0;
                $oldPriceRaw     = isset($pr['old_price'])              ? (float)$pr['old_price']              : 0;
                $marketingSeller = isset($pr['marketing_seller_price']) ? (float)$pr['marketing_seller_price'] : 0;

                // Цена продажи: акционная продавца если задана, иначе базовая
                $salePrice  = ($marketingSeller > 0) ? $marketingSeller : $priceRaw;
                // Зачёркнутая: только если строго больше цены продажи
                $crossPrice = ($oldPriceRaw > $salePrice) ? $oldPriceRaw : 0;

                $this->products[$pid]['price']    = $salePrice;
                $this->products[$pid]['old_price'] = $crossPrice;
                $count++;
            }

            $cursor = isset($res['cursor']) ? (string)$res['cursor'] : '';

        } while ($cursor);

        $this->log("Prices loaded: {$count}");
    }

    private function fetchAllProducts() {
        $allIds = $this->fetchProductIds();
        if (empty($allIds)) { $this->log('No products found.'); return; }

        $this->fetchDetails($allIds);
        $this->fetchPrices($allIds);
        $this->fetchAttributes($allIds);
        $this->fetchPictures($allIds);
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  СИНХРОНИЗАЦИЯ ТОВАРОВ
    // ═════════════════════════════════════════════════════════════════════════

    private function syncProducts() {
        $this->log('--- Syncing ' . count($this->products) . ' products ---');
        $created = $updated = $errors = 0;

        foreach ($this->products as $p) {
            try {
                $r = $this->syncProduct($p);
                if ($r === 'created') $created++;
                elseif ($r === 'updated') $updated++;
            } catch (Exception $e) {
                $errors++;
                $this->log('  ERROR [' . $p['id'] . ']: ' . $e->getMessage());
            }
        }
        $this->log("Done — created:{$created} updated:{$updated} errors:{$errors}");
    }

    private function syncProduct(array $p) {
        $ozonId  = $p['id'];
        $offerId = $p['offer_id'];
        if (!$ozonId) return 'skip';

        $name        = $p['name'] ?: ($offerId ?: ('Ozon #' . $ozonId));
        $description = $p['description'];
        $salePrice   = $p['price'];      // итоговая цена покупателя
        $crossPrice  = $p['old_price'];  // зачёркнутая (0 = нет скидки)
        $sku         = $p['sku'] ? (string)$p['sku'] : $offerId;
        $model       = $sku ?: ('ozon-' . $ozonId);
        $qty         = (int)$p['qty'];
        $barcode     = $p['barcode'];
        $brand       = $p['brand'];
        $weight      = (float)$p['weight'];
        $length      = (float)$p['length'];
        $width       = (float)$p['width'];
        $height      = (float)$p['height'];

        // Категория — строго из description_category_id
        $ozonCatId = $p['description_category_id'];
        $ocCatId   = $this->ensureCategory($ozonCatId);

        $manufacturerId = $brand ? $this->ensureManufacturer($brand) : 0;

        // Поиск существующего
        $productId = null;
        if ($sku) {
            $q = $this->db->query(
                "SELECT product_id FROM `" . DB_PREFIX . "product`
                 WHERE sku = '" . $this->db->escape($sku) . "' LIMIT 1"
            );
            if ($q->num_rows) $productId = (int)$q->row['product_id'];
        }
        if (!$productId && $offerId) {
            $q = $this->db->query(
                "SELECT product_id FROM `" . DB_PREFIX . "product`
                 WHERE sku = '" . $this->db->escape($offerId) . "' LIMIT 1"
            );
            if ($q->num_rows) $productId = (int)$q->row['product_id'];
        }

        if ($productId) {
            $this->db->query(
                "UPDATE `" . DB_PREFIX . "product` SET
                     model           = '" . $this->db->escape($model) . "',
                     sku             = '" . $this->db->escape($sku) . "',
                     price           = '" . ($crossPrice > 0 ? (float)$crossPrice : (float)$salePrice) . "',
                     quantity        = '{$qty}',
                     weight          = '{$weight}',
                     length          = '{$length}',
                     width           = '{$width}',
                     height          = '{$height}',
                     manufacturer_id = '{$manufacturerId}',
                     status          = 1,
                     date_modified   = NOW()
                 WHERE product_id = '{$productId}'"
            );
            $qd = $this->db->query(
                "SELECT product_id FROM `" . DB_PREFIX . "product_description`
                 WHERE product_id = '{$productId}' AND language_id = '" . (int)$this->langId . "'"
            );
            if ($qd->num_rows) {
                $this->db->query(
                    "UPDATE `" . DB_PREFIX . "product_description` SET
                         name        = '" . $this->db->escape($name) . "',
                         description = '" . $this->db->escape($description) . "',
                         meta_title  = '" . $this->db->escape($name) . "'
                     WHERE product_id = '{$productId}' AND language_id = '" . (int)$this->langId . "'"
                );
            } else {
                $this->insertDescription($productId, $name, $description);
            }
            $action = 'updated';
        } else {
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "product`
                 (model, sku, upc, ean, jan, isbn, mpn, location,
                  quantity, stock_status_id, image,
                  manufacturer_id, shipping, price, points, tax_class_id,
                  date_available, weight, weight_class_id,
                  length, width, height, length_class_id,
                  subtract, minimum, sort_order, status,
                  date_added, date_modified, viewed)
                 VALUES (
                     '" . $this->db->escape($model) . "',
                     '" . $this->db->escape($sku) . "',
                     '', '" . $this->db->escape($barcode) . "',
                     '', '', '', '',
                     '{$qty}', 7, '',
                     '{$manufacturerId}', 1,
                     '" . ($crossPrice > 0 ? (float)$crossPrice : (float)$salePrice) . "', 0, 0,
                     NOW(),
                     '{$weight}', 1,
                     '{$length}', '{$width}', '{$height}', 3,
                     1, 1, 0, 1,
                     NOW(), NOW(), 0
                 )"
            );
            $productId = (int)$this->db->getLastId();
            $this->insertDescription($productId, $name, $description);
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "product_to_store`
                 (product_id, store_id) VALUES ('{$productId}', '" . (int)$this->storeId . "')"
            );
            $action = 'created';
        }

        // Скидка: product.price=зачёркнутая, special.price=цена продажи
        if ($crossPrice > 0) {
            $this->upsertSpecialPrice($productId, $salePrice);
        } else {
            $this->db->query(
                "DELETE FROM `" . DB_PREFIX . "product_special`
                 WHERE product_id = '{$productId}' AND customer_group_id = 1"
            );
        }

        // Категория
        if ($ocCatId) {
            $this->db->query(
                "DELETE FROM `" . DB_PREFIX . "product_to_category` WHERE product_id = '{$productId}'"
            );
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "product_to_category`
                 (product_id, category_id) VALUES ('{$productId}', '{$ocCatId}')"
            );
        }

        // ЧПУ товара — OpenCart 3.0.x: таблица seo_url
        $this->upsertSeoUrl(
            'product_id=' . $productId,
            $this->makeSlug($name) . '-' . $productId,
            (int)$this->langId
        );

        // Картинки
        $this->syncImages($p, $productId);

        // Атрибуты
        $this->syncAttributes($productId, $p['attributes']);

        $this->log("  [{$action}] #{$productId} sku={$sku} \"{$name}\" sale={$salePrice} cross={$crossPrice} qty={$qty}");
        return $action;
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ЧПУ — OpenCart 3.0.x использует таблицу seo_url (не url_alias)
    // ═════════════════════════════════════════════════════════════════════════

    private function upsertSeoUrl($query, $keyword, $langId = 1) {
        // Гарантируем уникальность keyword
        $base = $keyword;
        for ($i = 0; $i <= 99; $i++) {
            $kw = $i === 0 ? $base : $base . '-' . $i;
            $q  = $this->db->query(
                "SELECT query FROM `" . DB_PREFIX . "seo_url`
                 WHERE keyword  = '" . $this->db->escape($kw) . "'
                   AND store_id = '" . (int)$this->storeId . "'
                   AND language_id = '{$langId}'
                 LIMIT 1"
            );
            if (!$q->num_rows || $q->row['query'] === $query) {
                $keyword = $kw; break;
            }
        }

        $exists = $this->db->query(
            "SELECT seo_url_id FROM `" . DB_PREFIX . "seo_url`
             WHERE query       = '" . $this->db->escape($query) . "'
               AND store_id   = '" . (int)$this->storeId . "'
               AND language_id = '{$langId}'
             LIMIT 1"
        );
        if ($exists->num_rows) {
            $this->db->query(
                "UPDATE `" . DB_PREFIX . "seo_url`
                 SET keyword = '" . $this->db->escape($keyword) . "'
                 WHERE seo_url_id = '" . $exists->row['seo_url_id'] . "'"
            );
        } else {
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "seo_url`
                 (store_id, language_id, query, keyword)
                 VALUES (
                     '" . (int)$this->storeId . "',
                     '{$langId}',
                     '" . $this->db->escape($query) . "',
                     '" . $this->db->escape($keyword) . "'
                 )"
            );
        }
    }

    private function makeSlug($text) {
        $map = array(
            'а'=>'a','б'=>'b','в'=>'v','г'=>'g','д'=>'d','е'=>'e','ё'=>'yo',
            'ж'=>'zh','з'=>'z','и'=>'i','й'=>'j','к'=>'k','л'=>'l','м'=>'m',
            'н'=>'n','о'=>'o','п'=>'p','р'=>'r','с'=>'s','т'=>'t','у'=>'u',
            'ф'=>'f','х'=>'h','ц'=>'ts','ч'=>'ch','ш'=>'sh','щ'=>'shch',
            'ъ'=>'','ы'=>'y','ь'=>'','э'=>'e','ю'=>'yu','я'=>'ya',
            'А'=>'A','Б'=>'B','В'=>'V','Г'=>'G','Д'=>'D','Е'=>'E','Ё'=>'Yo',
            'Ж'=>'Zh','З'=>'Z','И'=>'I','Й'=>'J','К'=>'K','Л'=>'L','М'=>'M',
            'Н'=>'N','О'=>'O','П'=>'P','Р'=>'R','С'=>'S','Т'=>'T','У'=>'U',
            'Ф'=>'F','Х'=>'H','Ц'=>'Ts','Ч'=>'Ch','Ш'=>'Sh','Щ'=>'Shch',
            'Ъ'=>'','Ы'=>'Y','Ь'=>'','Э'=>'E','Ю'=>'Yu','Я'=>'Ya',
        );
        $text = strtr($text, $map);
        $text = strtolower($text);
        $text = preg_replace('/[^a-z0-9\-]+/', '-', $text);
        $text = trim(preg_replace('/-{2,}/', '-', $text), '-');
        return substr($text, 0, 100) ?: 'product';
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  КАТЕГОРИИ
    //
    //  description_category_id из Ozon НЕ совпадает с деревом сайта.
    //  Название берём через /v1/description-category/tree (нужна роль «Контент»).
    //  При 403 — создаём с именем "Ozon Cat ID", потом переименуете вручную.
    // ═════════════════════════════════════════════════════════════════════════

    // ─────────────────────────────────────────────────────────────────────────
    //  КАТЕГОРИИ
    //
    //  Структура Ozon:
    //    ВерхнийУровень (description_category_id + category_name)
    //      └─ Подкатегория (description_category_id + category_name)
    //           └─ ТипТовара (type_id + type_name)   ← у типов НЕТ description_category_id
    //
    //  Товар хранит description_category_id — это ID подкатегории (не типа).
    //  Мы строим иерархию: загружаем всё дерево один раз, строим карту
    //  description_category_id → {name, parent_description_category_id}.
    // ─────────────────────────────────────────────────────────────────────────

    // Полная карта Ozon-дерева: cat_id => ['name'=>..., 'parent'=>...]
    private $ozonCatTree  = null;   // null = не загружено
    private $ozonCatParent = array(); // cat_id => parent_cat_id (0 = корень)
    private $ozonCatName   = array(); // cat_id => name

    // Гарантируем что категория «Каталог» с id=1 существует.
    // Все Ozon-категории верхнего уровня будут внутри неё.
    private function ensureCatalogRoot() {
        $q = $this->db->query(
            "SELECT category_id FROM `" . DB_PREFIX . "category`
             WHERE category_id = '1' LIMIT 1"
        );
        if ($q->num_rows) {
            // Убеждаемся что описание есть
            $qd = $this->db->query(
                "SELECT category_id FROM `" . DB_PREFIX . "category_description`
                 WHERE category_id = '1' AND language_id = '" . (int)$this->langId . "' LIMIT 1"
            );
            if (!$qd->num_rows) {
                $this->db->query(
                    "INSERT INTO `" . DB_PREFIX . "category_description`
                     (category_id, language_id, name, description, meta_title, meta_description, meta_keyword)
                     VALUES (1, '" . (int)$this->langId . "', 'Каталог', '', 'Каталог', '', '')"
                );
            }
            $this->catalogRootId = 1;
            $this->log('  Catalog root: existing category id=1');
            return;
        }

        // Создаём с явным AUTO_INCREMENT = 1
        $this->db->query("ALTER TABLE `" . DB_PREFIX . "category` AUTO_INCREMENT = 1");
        $this->db->query(
            "INSERT INTO `" . DB_PREFIX . "category`
             (parent_id, top, `column`, sort_order, status, date_added, date_modified)
             VALUES (0, 1, 1, 0, 1, NOW(), NOW())"
        );
        $this->catalogRootId = (int)$this->db->getLastId();

        $this->db->query(
            "INSERT INTO `" . DB_PREFIX . "category_description`
             (category_id, language_id, name, description, meta_title, meta_description, meta_keyword)
             VALUES (
                 '{$this->catalogRootId}', '" . (int)$this->langId . "',
                 'Каталог', '', 'Каталог', '', ''
             )"
        );
        $this->db->query(
            "INSERT INTO `" . DB_PREFIX . "category_to_store`
             (category_id, store_id) VALUES ('{$this->catalogRootId}', '" . (int)$this->storeId . "')"
        );
        $this->upsertSeoUrl('category_id=' . $this->catalogRootId, 'catalog', (int)$this->langId);
        $this->log('  Catalog root created with id=' . $this->catalogRootId);
    }

    private function loadOzonCategoryTree() {
        if ($this->ozonCatTree !== null) return;
        $this->ozonCatTree = array();
        try {
            $res = $this->ozonRequest('/v1/description-category/tree', array('language' => 'RU'));
            $this->indexCategoryTree(isset($res['result']) ? $res['result'] : array(), 0);
            $this->log("  Category tree loaded: " . count($this->ozonCatName) . " nodes");
        } catch (Exception $e) {
            $this->log("  WARN category tree: " . $e->getMessage());
        }
    }

    private function indexCategoryTree(array $nodes, $parentCatId) {
        foreach ($nodes as $node) {
            // Узлы с description_category_id — категории/подкатегории
            if (!empty($node['description_category_id'])) {
                $cid = (int)$node['description_category_id'];
                $this->ozonCatName[$cid]   = $node['category_name'] ?? ('Cat ' . $cid);
                $this->ozonCatParent[$cid] = $parentCatId;
                if (!empty($node['children'])) {
                    $this->indexCategoryTree($node['children'], $cid);
                }
            }
            // Листья с type_id — типы товаров (пропускаем, они не нужны как категории ОС)
        }
    }

    private function ensureCategory($ozonCatId, $parentOcId = -1) {
        if (!$ozonCatId) return 0;
        if (isset($this->categoryMap[$ozonCatId])) return $this->categoryMap[$ozonCatId];

        // Загружаем дерево один раз
        $this->loadOzonCategoryTree();

        // Определяем родителя — рекурсивно создаём цепочку
        if ($parentOcId === -1) {
            $ozonParentId = isset($this->ozonCatParent[$ozonCatId]) ? $this->ozonCatParent[$ozonCatId] : 0;
            // Корневые Ozon-категории (parentId=0) помещаем внутрь «Каталог» (id=1)
            $parentOcId   = $ozonParentId
                          ? $this->ensureCategory($ozonParentId)
                          : $this->catalogRootId;
        }

        // Ищем уже созданную в OC по маркеру
        $q = $this->db->query(
            "SELECT category_id FROM `" . DB_PREFIX . "category_description`
             WHERE description = 'ozon_cat_{$ozonCatId}'
               AND language_id = '" . (int)$this->langId . "'
             LIMIT 1"
        );
        if ($q->num_rows) {
            $id = (int)$q->row['category_id'];
            // Обновляем parent если нужно
            $this->db->query(
                "UPDATE `" . DB_PREFIX . "category` SET parent_id = '" . (int)$parentOcId . "'
                 WHERE category_id = '{$id}'"
            );
            $this->categoryMap[$ozonCatId] = $id;
            return $id;
        }

        // Название: берём из кеша дерева или фоллбек
        $name = isset($this->ozonCatName[$ozonCatId])
            ? $this->ozonCatName[$ozonCatId]
            : ('Ozon Cat ' . $ozonCatId);

        // Создаём
        $this->db->query(
            "INSERT INTO `" . DB_PREFIX . "category`
             (parent_id, top, `column`, sort_order, status, date_added, date_modified)
             VALUES ('" . (int)$parentOcId . "', 0, 1, 0, 1, NOW(), NOW())"
        );
        $id = (int)$this->db->getLastId();

        $this->db->query(
            "INSERT INTO `" . DB_PREFIX . "category_description`
             (category_id, language_id, name, description, meta_title, meta_description, meta_keyword)
             VALUES (
                 '{$id}', '" . (int)$this->langId . "',
                 '" . $this->db->escape($name) . "',
                 'ozon_cat_{$ozonCatId}',
                 '" . $this->db->escape($name) . "',
                 '', ''
             )"
        );
        $this->db->query(
            "INSERT INTO `" . DB_PREFIX . "category_to_store`
             (category_id, store_id) VALUES ('{$id}', '" . (int)$this->storeId . "')"
        );

        // ЧПУ
        $this->upsertSeoUrl(
            'category_id=' . $id,
            $this->makeSlug($name) . '-cat' . $id,
            (int)$this->langId
        );

        $this->categoryMap[$ozonCatId] = $id;
        $this->log("  + Cat [{$id}] parent=[{$parentOcId}] \"{$name}\" (ozon={$ozonCatId})");
        return $id;
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  АТРИБУТЫ OpenCart
    // ═════════════════════════════════════════════════════════════════════════

    private function ensureAttrGroup() {
        $q = $this->db->query(
            "SELECT ag.attribute_group_id
             FROM `" . DB_PREFIX . "attribute_group` ag
             JOIN `" . DB_PREFIX . "attribute_group_description` agd
               ON ag.attribute_group_id = agd.attribute_group_id
             WHERE agd.name = 'Ozon' AND agd.language_id = '" . (int)$this->langId . "'
             LIMIT 1"
        );
        if ($q->num_rows) {
            $this->attrGroupId = (int)$q->row['attribute_group_id'];
        } else {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "attribute_group` (sort_order) VALUES (10)");
            $this->attrGroupId = (int)$this->db->getLastId();
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "attribute_group_description`
                 (attribute_group_id, language_id, name)
                 VALUES ('{$this->attrGroupId}', '" . (int)$this->langId . "', 'Ozon')"
            );
        }
    }

    private function ensureOcAttribute($name) {
        if (isset($this->ocAttrIdCache[$name])) return $this->ocAttrIdCache[$name];

        $q = $this->db->query(
            "SELECT a.attribute_id
             FROM `" . DB_PREFIX . "attribute` a
             JOIN `" . DB_PREFIX . "attribute_description` ad ON a.attribute_id = ad.attribute_id
             WHERE ad.name = '" . $this->db->escape($name) . "'
               AND ad.language_id = '" . (int)$this->langId . "'
             LIMIT 1"
        );
        if ($q->num_rows) {
            $id = (int)$q->row['attribute_id'];
        } else {
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "attribute` (attribute_group_id, sort_order)
                 VALUES ('{$this->attrGroupId}', 0)"
            );
            $id = (int)$this->db->getLastId();
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "attribute_description`
                 (attribute_id, language_id, name)
                 VALUES ('{$id}', '" . (int)$this->langId . "', '" . $this->db->escape($name) . "')"
            );
        }

        $this->ocAttrIdCache[$name] = $id;
        return $id;
    }

    private function syncAttributes($productId, array $attrs) {
        if (empty($attrs)) return;
        $this->db->query(
            "DELETE FROM `" . DB_PREFIX . "product_attribute` WHERE product_id = '{$productId}'"
        );
        foreach ($attrs as $name => $value) {
            if ((string)$value === '') continue;
            $attrId = $this->ensureOcAttribute($name);
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "product_attribute`
                 (product_id, attribute_id, language_id, text)
                 VALUES (
                     '{$productId}', '{$attrId}',
                     '" . (int)$this->langId . "',
                     '" . $this->db->escape((string)$value) . "'
                 )"
            );
        }
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ИЗОБРАЖЕНИЯ
    // ═════════════════════════════════════════════════════════════════════════

    private function syncImages(array $p, $productId) {
        $primaryUrl = $p['primary_image'];
        $extraUrls  = array();

        foreach ($p['images'] as $url) {
            if ($url && $url !== $primaryUrl) $extraUrls[] = $url;
        }
        foreach ($p['images360'] as $url) {
            if ($url && $url !== $primaryUrl) $extraUrls[] = $url;
        }

        if (!$primaryUrl && empty($extraUrls)) return;

        $this->db->query(
            "DELETE FROM `" . DB_PREFIX . "product_image` WHERE product_id = '{$productId}'"
        );

        if ($primaryUrl) {
            $local = $this->downloadImage($primaryUrl);
            if ($local) {
                $rel = ltrim(str_replace(rtrim($this->imageDir, '/'), '', $local), '/');
                $this->db->query(
                    "UPDATE `" . DB_PREFIX . "product`
                     SET image = '" . $this->db->escape($rel) . "'
                     WHERE product_id = '{$productId}'"
                );
            }
        }

        foreach ($extraUrls as $sort => $url) {
            $local = $this->downloadImage($url);
            if (!$local) continue;
            $rel = ltrim(str_replace(rtrim($this->imageDir, '/'), '', $local), '/');
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "product_image`
                 (product_id, image, sort_order)
                 VALUES ('{$productId}', '" . $this->db->escape($rel) . "', '" . (int)($sort + 1) . "')"
            );
        }
    }

    private function downloadImage($url) {
        if (empty($url)) return false;

        $dir = rtrim($this->imageDir, '/') . '/catalog/ozon/';
        if (!is_dir($dir)) mkdir($dir, 0755, true);

        $filename = basename(parse_url($url, PHP_URL_PATH));
        $filename = preg_replace('/[^a-zA-Z0-9._\-]/', '_', $filename);
        if (!preg_match('/\.(jpe?g|png|webp|gif)$/i', $filename)) $filename .= '.jpg';

        $path = $dir . $filename;

        if (file_exists($path) && filesize($path) > 0) {
            $this->log("  IMG exists: {$filename}");
            return $path;
        }

        $this->log("  IMG download: {$url}");
        $ch = curl_init($url);
        curl_setopt_array($ch, array(
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_TIMEOUT        => 20,
            CURLOPT_USERAGENT      => 'Mozilla/5.0',
        ));
        $data = curl_exec($ch);
        $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $err  = curl_error($ch);
        curl_close($ch);

        if ($err)          { $this->log("  IMG ERR curl: {$err}");          return false; }
        if ($code !== 200) { $this->log("  IMG ERR HTTP {$code}: {$url}");  return false; }
        if (empty($data))  { $this->log("  IMG ERR empty: {$url}");         return false; }

        file_put_contents($path, $data);

        if (!file_exists($path) || filesize($path) === 0) {
            @unlink($path);
            $this->log("  IMG ERR wrote empty: {$url}");
            return false;
        }

        $this->log("  IMG saved: {$filename} (" . filesize($path) . "b)");
        return $path;
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ВСПОМОГАТЕЛЬНЫЕ
    // ═════════════════════════════════════════════════════════════════════════

    private function insertDescription($productId, $name, $description) {
        $this->db->query(
            "INSERT INTO `" . DB_PREFIX . "product_description`
             (product_id, language_id, name, description,
              meta_title, meta_description, meta_keyword, tag)
             VALUES (
                 '{$productId}', '" . (int)$this->langId . "',
                 '" . $this->db->escape($name) . "',
                 '" . $this->db->escape($description) . "',
                 '" . $this->db->escape($name) . "',
                 '', '', ''
             )"
        );
    }

    private function upsertSpecialPrice($productId, $price) {
        $q = $this->db->query(
            "SELECT product_special_id FROM `" . DB_PREFIX . "product_special`
             WHERE product_id = '{$productId}' AND customer_group_id = 1 LIMIT 1"
        );
        if ($q->num_rows) {
            $this->db->query(
                "UPDATE `" . DB_PREFIX . "product_special` SET price = '" . (float)$price . "'
                 WHERE product_special_id = '" . $q->row['product_special_id'] . "'"
            );
        } else {
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "product_special`
                 (product_id, customer_group_id, priority, price, date_start, date_end)
                 VALUES ('{$productId}', 1, 1, '" . (float)$price . "', '0000-00-00', '0000-00-00')"
            );
        }
    }

    private function ensureManufacturer($name) {
        static $cache = array();
        if (isset($cache[$name])) return $cache[$name];

        $q = $this->db->query(
            "SELECT manufacturer_id FROM `" . DB_PREFIX . "manufacturer`
             WHERE name = '" . $this->db->escape($name) . "' LIMIT 1"
        );
        if ($q->num_rows) {
            $id = (int)$q->row['manufacturer_id'];
        } else {
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "manufacturer` (name, sort_order)
                 VALUES ('" . $this->db->escape($name) . "', 0)"
            );
            $id = (int)$this->db->getLastId();
            $this->db->query(
                "INSERT INTO `" . DB_PREFIX . "manufacturer_to_store`
                 (manufacturer_id, store_id) VALUES ('{$id}', '" . (int)$this->storeId . "')"
            );
        }
        $cache[$name] = $id;
        return $id;
    }

    // ═════════════════════════════════════════════════════════════════════════
    //  ОЧИСТКА — ?clean=1
    //  Сайт пустой → TRUNCATE быстрее DELETE
    // ═════════════════════════════════════════════════════════════════════════

    private function cleanAll() {
        $this->log('--- cleanAll (TRUNCATE) started ---');

        // Товары
        $productTables = array(
            'product', 'product_description', 'product_to_category',
            'product_to_store', 'product_image', 'product_attribute',
            'product_special', 'product_option', 'product_option_value',
            'product_reward', 'product_related', 'review',
        );
        foreach ($productTables as $tbl) {
            $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "{$tbl}`");
        }
        $this->log('  Products truncated.');

        // Категории
        $catTables = array(
            'category', 'category_description',
            'category_to_store', 'category_path', 'category_filter',
        );
        foreach ($catTables as $tbl) {
            $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "{$tbl}`");
        }
        $this->log('  Categories truncated.');

        // Атрибуты группы Ozon
        $q = $this->db->query(
            "SELECT ag.attribute_group_id
             FROM `" . DB_PREFIX . "attribute_group` ag
             JOIN `" . DB_PREFIX . "attribute_group_description` agd
               ON ag.attribute_group_id = agd.attribute_group_id
             WHERE agd.name = 'Ozon' AND agd.language_id = '" . (int)$this->langId . "'"
        );
        if ($q->num_rows) {
            $gid = (int)$q->row['attribute_group_id'];
            $qa = $this->db->query(
                "SELECT attribute_id FROM `" . DB_PREFIX . "attribute` WHERE attribute_group_id = '{$gid}'"
            );
            $aIds = array();
            foreach ($qa->rows as $row) $aIds[] = (int)$row['attribute_id'];
            if ($aIds) {
                $ids = implode(',', $aIds);
                $this->db->query("DELETE FROM `" . DB_PREFIX . "attribute` WHERE attribute_id IN ({$ids})");
                $this->db->query("DELETE FROM `" . DB_PREFIX . "attribute_description` WHERE attribute_id IN ({$ids})");
            }
            $this->db->query("DELETE FROM `" . DB_PREFIX . "attribute_group` WHERE attribute_group_id = '{$gid}'");
            $this->db->query("DELETE FROM `" . DB_PREFIX . "attribute_group_description` WHERE attribute_group_id = '{$gid}'");
        }
        $this->log('  Attributes cleaned.');

        // SEO urls — OpenCart 3.0.x
        $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "seo_url`");
        $this->log('  SEO URLs truncated.');

        // Производители (опционально — раскомментируйте если нужно)
        // $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "manufacturer`");
        // $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "manufacturer_to_store`");

        $this->log('--- cleanAll finished ---');
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  ЛОГ
    // ─────────────────────────────────────────────────────────────────────────

    private function log($message) {
        $line = '[' . date('H:i:s') . '] ' . $message . PHP_EOL;
        file_put_contents($this->logFile, $line, FILE_APPEND | LOCK_EX);
        echo $line;
        if (ob_get_level()) ob_flush();
        flush();
    }
}