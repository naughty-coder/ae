<?php 
  if (!function_exists('plural')) { 
    function plural($number, $titles){
        $cases = array (2, 0, 1, 1, 1, 2);
        return $titles[ ($number%100>4 && $number%100<20)? 2 : $cases[min($number%10, 5)] ];
    }
  }
?>
<div class="canvas-wrapper">
    <div class="canvas-header">
        <h3 class="title fw-normal text-uppercase">Корзина</h3>
        <span class="icon-close link icon-close-popup" data-bs-dismiss="offcanvas"></span>
    </div>
    <div class="wrap list-file-delete">
        <div class="tf-mini-cart-threshold">
            <?php /*
            <h6 class="text fw-normal text-uppercase">Spend <span class="fw-medium">$100</span> more to get
                <span class="fw-medium">Free
                    Shipping</span>
            </h6>
            <div class="tf-progress-bar tf-progress-ship">
                <div class="value" style="width: 0%;" data-progress="75">
                    <i class="icon icon-delivery"></i>
                </div>
            </div>
            */ ?>
            <div class="tf-number-count">
                <p class="text-uppercase"><span class="prd-count"><?php print $count_products; ?></span> <?php print plural($count_products, ['товар', 'товара', 'товаров']); ?></p>

                <?php if ($count_products > 0) { ?>
                  <a data-clear-cart class="tf-btn-line style-line-2 clear-file-delete">
                      <span class="text-body">
                          Очистить корзину
                      </span>
                  </a>
                <?php } ?>
            </div>
        </div>
        <div class="tf-mini-cart-wrap">
            <div class="tf-mini-cart-main">
                <div class="tf-mini-cart-sroll">
                    <ul class="tf-mini-cart-items">
                        <?php if (sizeof($products) > 0) { ?>
                            <?php foreach ($products as $product) { ?>
                                <li class="tf-mini-cart-item file-delete">
                                    <div class="tf-mini-cart-image">
                                        <img src="<?php echo $product['thumb']; ?>" width="100" height="100" alt="">
                                    </div>
                                    <div class="tf-mini-cart-info">
                                        <a href="<?php echo $product['href']; ?>" class="prd-name link">
                                            <?php print $product['name']; ?>
                                        </a>

                                        <?php if ($product['option']) { ?>
                                            <?php foreach ($product['option'] as $option) { ?>
                                                <p class="type-select text-main-4"><?php echo $option['name']; ?>: <?php echo $option['value']; ?></p>
                                            <?php } ?>
                                        <?php } ?>

                                        <div class="prd-quantity">
                                            <p class="text-caption">
                                                Количество:
                                            </p>
                                            <div class="wg-quantity style-2">
                                                <button class="btn-quantity minus-quantity" data-decrement-value="#input-qty-<?php print $product['cart_id']; ?>"><i class="icon-minus"></i></button>
                                                <input id="input-qty-<?php print $product['cart_id']; ?>" class="quantity-product" type="text" name="number" value="<?php echo $product['quantity']; ?>" data-update-cart="<?php print $product['cart_id']; ?>">
                                                <button class="btn-quantity plus-quantity" data-increment-value="#input-qty-<?php print $product['cart_id']; ?>"><i class="icon-plus"></i></button>
                                            </div>
                                        </div>
                                        <a data-delete-from-cart="<?php print $product['cart_id']; ?>" class="tf-btn-line style-line-2 remove">
                                            <span class="text-caption">
                                                Удалить
                                            </span>
                                        </a>
                                    </div>
                                    <p class="tf-mini-card-price h6 fw-normal">
                                        <?php echo $product['price']; ?>
                                    </p>
                                </li>
                            <?php } ?>                            
                        <?php } else { ?>                            
                            В корзине пока пусто
                        <?php } ?>
                    </ul>
                </div>
            </div>
            <?php if ($count_products > 0) { ?>
                <div class="tf-mini-cart-bottom">
                    <div class="tf-mini-cart-bottom-wrap">
                        <?php foreach ($totals as $total) { ?>
                          <?php if ($total['code'] == 'sub_total') { ?>
                            <div class="tf-cart-totals-discounts">
                                <h6 class="tf-cart-total-text fw-normal text-uppercase"><?php print $total['title']; ?>:</h6>
                                <div class="tf-totals-total-value h6 fw-normal"><?php print $total['text']; ?></div>
                            </div>
                          <?php } ?>
                        <?php } ?>
                        <div class="tf-mini-cart-view-checkout">
                            <?php /*
                            <a href="/cart/" class="tf-btn w-100 style-2">
                                <span class="fw-medium">
                                    В корзину
                                </span>
                            </a>
                            */ ?>
                            <a href="/checkout/" class="tf-btn btn-fill animate-btn w-100">
                                <span class="fw-medium">
                                    Оформить заказ
                                </span>
                            </a>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>
</div>