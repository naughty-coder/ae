<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', true);
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['tracking'] = $this->url->link('information/tracking');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', true);
		$data['affiliate'] = $this->url->link('affiliate/login', '', true);
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);

		$data['telephone'] = $this->config->get('config_telephone');
		$data['email'] = $this->config->get('config_email');

		$data['url'] = $this->url;

		$data['categories'] = array();

		$this->load->model('catalog/category');
		$categories = $this->model_catalog_category->getTopCategories(2612);

		foreach ($categories as $category) {
			// Level 2
			$children_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			foreach ($children as $child) {
				// $filter_data = array(
				// 	'filter_category_id'  => $child['category_id'],
				// 	'filter_sub_category' => true
				// );

				// $total = $this->model_catalog_product->getTotalProducts($filter_data);

				// if ($total > 0) {
					$children_data[] = array(
						'name'  => $child['name'],
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				// }
			}

			// Level 1
			$data['categories'][] = array(
				'name'     => $category['name'],
				'children' => $children_data,
				'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
			);
		}

		$data['scripts'] = $this->document->getScripts('footer');
		$data['inline_scripts'] = $this->document->getInlineScripts();

		$data['popup_cart'] = $this->load->controller('common/popup_cart');
		
		return $this->load->view('common/footer', $data);
	}
}
