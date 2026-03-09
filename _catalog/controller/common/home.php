<?php
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

		if (isset($this->request->get['route'])) {
			$this->document->addLink($this->config->get('config_url'), 'canonical');
		}

		$this->load->model('catalog/product');
		$this->load->model('catalog/category');
		$this->load->model('design/banner');
		$this->load->model('tool/image');

		$data['featureds'] = [];
		$featureds = $this->db->query("SELECT * FROM " . DB_PREFIX . "module WHERE code = 'featured' ORDER BY `name`")->rows;
		foreach ($featureds as $featured) {
			$setting = json_decode($featured['setting'], 1);

			if ($setting['status']) {
				$featured_item = [
					'name' => $setting['name'], 
					'products' => []
				];

				foreach ($setting['product'] as $product_id) {
					$product_info = $this->model_catalog_product->getProduct($product_id);

					if ($product_info) {
						if ($product_info['image']) {
							$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
						} else {
							$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
						}

						if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
							$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						} else {
							$price = false;
						}

						if ((float)$product_info['special']) {
							$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						} else {
							$special = false;
						}

						if ($this->config->get('config_tax')) {
							$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
						} else {
							$tax = false;
						}

						if ($this->config->get('config_review_status')) {
							$rating = $product_info['rating'];
						} else {
							$rating = false;
						}

						$featured_item['products'][] = array(
							'product_id'  => $product_info['product_id'],
							'thumb'       => $image,
							'name'        => $product_info['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('theme_' . $this->config->get('config_theme') . '_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
							'tax'         => $tax,
							'rating'      => $rating,
							'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
						);
					}
				}

				$data['featureds'][] = $featured_item;
			}
		}

		// Slider banners
		$data['banners_slider'] = array();
		$results = $this->model_design_banner->getBanner(defined('BANNER_SLIDER_ID') ? BANNER_SLIDER_ID : 1);
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners_slider'][] = array(
					'image' => $this->model_tool_image->resize($result['image'], 1185, 590),
					'href'  => $result['link'],
					'name'  => html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'),
				);
			}
		}

		// Right side banners
		$data['banners_right'] = array();
		$results = $this->model_design_banner->getBanner(defined('BANNER_RIGHT_ID') ? BANNER_RIGHT_ID : 2);
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners_right'][] = array(
					'image' => $this->model_tool_image->resize($result['image'], 381, 277),
					'href'  => $result['link'],
					'name'  => html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'),
				);
			}
		}

		// Left sidebar banner
		$data['banners_left'] = array();
		$results = $this->model_design_banner->getBanner(defined('BANNER_LEFT_ID') ? BANNER_LEFT_ID : 3);
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners_left'][] = array(
					'image' => $this->model_tool_image->resize($result['image'], 270, 460),
					'href'  => $result['link'],
					'name'  => html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'),
				);
			}
		}

		// Bottom banners (2-column inside tabs area)
		$data['banners_bottom'] = array();
		$results = $this->model_design_banner->getBanner(defined('BANNER_BOTTOM_ID') ? BANNER_BOTTOM_ID : 4);
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners_bottom'][] = array(
					'image' => $this->model_tool_image->resize($result['image'], 555, 260),
					'href'  => $result['link'],
					'name'  => html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'),
				);
			}
		}

		// Sub banners (2-column)
		$data['banners_sub'] = array();
		$results = $this->model_design_banner->getBanner(defined('BANNER_SUB_ID') ? BANNER_SUB_ID : 5);
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners_sub'][] = array(
					'image' => $this->model_tool_image->resize($result['image'], 555, 260),
					'href'  => $result['link'],
					'name'  => html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'),
				);
			}
		}

		// Latest products
		$data['latest'] = array();
		$latest_results = $this->model_catalog_product->getProducts(array(
			'sort'  => 'date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => 5,
		));
		foreach ($latest_results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], 300, 348);
			} else {
				$image = $this->model_tool_image->resize('placeholder.png', 300, 348);
			}

			if ($result['image2']) {
				$image2 = $this->model_tool_image->resize($result['image2'], 300, 348);
			} else {
				$image2 = false;
			}

			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$price = false;
			}

			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$special = false;
			}

			if ($this->config->get('config_tax')) {
				$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
			} else {
				$tax = false;
			}

			$data['latest'][] = array(
				'product_id'  => $result['product_id'],
				'thumb'       => $image,
				'thumb2'      => $image2,
				'name'        => $result['name'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
				'price'       => $price,
				'special'     => $special,
				'tax'         => $tax,
				'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);
		}

		// Hot categories (top-level categories with images and children)
		$data['categories_featured'] = array();
		$top_categories = $this->model_catalog_category->getCategories(0);
		foreach ($top_categories as $cat) {
			if ($cat['image']) {
				$cat_children = $this->model_catalog_category->getCategories($cat['category_id']);
				$children = array();
				foreach ($cat_children as $child) {
					$children[] = array(
						'name' => $child['name'],
						'href' => $this->url->link('product/category', 'path=' . $cat['category_id'] . '_' . $child['category_id']),
					);
				}
				$data['categories_featured'][] = array(
					'name'     => $cat['name'],
					'image'    => $this->model_tool_image->resize($cat['image'], 160, 220),
					'href'     => $this->url->link('product/category', 'path=' . $cat['category_id']),
					'children' => $children,
				);
			}
		}

		$data['look'] = array();

		$results = $this->model_design_banner->getBanner(9);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$product_info = $this->model_catalog_product->getProduct($result['link']);

				if ($product_info) {
					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					$data['look'][] = array(
						'big_image' => $this->model_tool_image->resize($result['image'], 486, 814),
						'small_image' => $this->model_tool_image->resize($product_info['image'], 164, 164),

						'name'        => $product_info['name'],
						'price'       => $price,
						'special'     => $special,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),

						// 'title' => $result['title'],
						// 'link'  => $result['link'],
					);
				}
			}
		}

		$data['banners_2items'] = array();
		$results = $this->model_design_banner->getBanner(10);
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners_2items'][] = array(
					'image' => $this->model_tool_image->resize($result['image'], 1488, 1416),
					'name'  => html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'),
					'text'  => html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8'),
					'href'  => $result['link'],
				);
			}
		}

		$data['banners_6items'] = array();
		$results = $this->model_design_banner->getBanner(11);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners_6items'][] = array(
					'image' => $this->model_tool_image->resize($result['image'], 1280, 1028),
					'name'  => html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'),
					'text'  => html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8'),
					'href'  => $result['link'],
				);
			}
		}

		// print_r($data['banners_2items']);

		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/home', $data));
	}
}
