<?php
class ControllerCheckoutCheckout extends Controller {
	private function checkCaptcha() {
		return true;
		if (!isset($this->request->post['g-recaptcha-response'])) return false;

        $url = 'https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode(GOOGLE_CAPTCHA_PRIVATE) .  '&response=' . urlencode($this->request->post['g-recaptcha-response']);

        $response = file_get_contents($url);
        $responseKeys = json_decode($response,true);

        return $responseKeys["success"];
	}

	public function index() {
		// if (!$this->cart->canCheckout()) {
		// 	$this->response->redirect($this->url->link('checkout/cart', '', true)); 
		// }

		$this->document->setTitle('Оформление заказа');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => 'Оформление заказа',
			'href' => $this->url->link('checkout/checkout', '', true)
		);

		$data['heading_title'] = 'Оформление заказа';

		$data['products'] = array();

		$products = $this->cart->getProducts();

		if (sizeof($products) == 0) {
			$this->document->setTitle('Корзина пуста');

			$data['text_error'] = $this->language->get('text_error');

			$data['continue'] = $this->url->link('common/home');

			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/empty_cart', $data));
		} else { 
			foreach ($products as $product) {
				$product_total = 0;

				foreach ($products as $product_2) {
					if ($product_2['product_id'] == $product['product_id']) {
						$product_total += $product_2['quantity'];
					}
				}

				if ($product['minimum'] > $product_total) {
					$data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
				}

				if ($product['image']) {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get('theme_' . $this->config->get('config_theme') . '_image_cart_width'), $this->config->get('theme_' . $this->config->get('config_theme') . '_image_cart_height'));
				} else {
					$image = '';
				}

				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);
				}

				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$unit_price = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
					
					$price = $this->currency->format($unit_price, $this->session->data['currency']);
					$total = $this->currency->format($unit_price * $product['quantity'], $this->session->data['currency']);
				} else {
					$price = false;
					$total = false;
				}

				$recurring = '';

				if ($product['recurring']) {
					$frequencies = array(
						'day'        => $this->language->get('text_day'),
						'week'       => $this->language->get('text_week'),
						'semi_month' => $this->language->get('text_semi_month'),
						'month'      => $this->language->get('text_month'),
						'year'       => $this->language->get('text_year')
					);

					if ($product['recurring']['trial']) {
						$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
					}

					if ($product['recurring']['duration']) {
						$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					} else {
						$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					}
				}

				$data['products'][] = array(
					'cart_id'   => $product['cart_id'],
					'thumb'     => $image,
					'name'      => $product['name'],
					'model'     => $product['model'],
					'option'    => $option_data,
					'recurring' => $recurring,
					'quantity'  => $product['quantity'],
					'stock'     => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
					'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
					'price'     => $price,
					'total'     => $total,
					'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
				);
			}

			// Gift Voucher
			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $this->session->data['currency']),
						'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)
					);
				}
			}

			// Totals
			$this->load->model('setting/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;
			
			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);
			
			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_setting_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get('total_' . $value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get('total_' . $result['code'] . '_status')) {
						$this->load->model('extension/total/' . $result['code']);
						
						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$data['totals'] = array();

			foreach ($totals as $total) {
				$data['totals'][] = array(
					'code' => $total['code'],
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('checkout/checkout', $data));
		}
	}

	public function checkout() {
		define('CHECKOUT_PROCESSING', true);
		
        $totals = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        $total_data = array(
            'totals' => &$totals,
            'taxes'  => &$taxes,
            'total'  => &$total
        );

        // Totals
		$this->load->model('setting/extension');

		$totals = array();
		$taxes = $this->cart->getTaxes();
		$total = 0;

		// Because __call can not keep var references so we put them into an array.
		$total_data = array(
			'totals' => &$totals,
			'taxes'  => &$taxes,
			'total'  => &$total
		);

		// Display prices
		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
			$sort_order = array();

			$results = $this->model_setting_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get('total_' . $value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);

			foreach ($results as $result) {
				if ($this->config->get('total_' . $result['code'] . '_status')) {
					$this->load->model('extension/total/' . $result['code']);
					
					// We have to put the totals in an array so that they pass by reference.
					$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
				}
			}

			$sort_order = array();

			foreach ($totals as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $totals);
		}

		$customer_group_id = 1;

		// проверка
		$json = array('ok' => 0, 'errors' => array());

		if (!$this->checkCaptcha()) {
			$json['errors'][] = array(
				'code' => 'captcha',
				'value' => 'Пожалуйста, пройдите проверку на робота',
			);
		}
		
		// if (!$this->cart->canCheckout()) {
		// 	$json['errors'][] = array(
		// 		'code' => 'cart',
		// 		'value' => 'Заказ менее 5000 руб.',
		// 	);
		// }

		if (!$this->cart->hasProducts()) {
			$json['errors'][] = array(
				'code' => 'cart',
				'value' => 'Нет товаров в корзине',
			);
		}

		if ((!isset($customer_group_id)) || (!in_array($customer_group_id, array(1,2)))) {
			$json['errors'][] = array(
				'code' => 'customer_group_id',
				'value' => 'Не указана группа клиентов',
			);
		} else {
			// юрлицо
			// if ((!isset($this->request->post['company_name'])) || (mb_strlen(trim($this->request->post['company_name'])) < 2)) {
			// 	$json['errors'][] = array(
			// 		'code' => 'company_name',
			// 		'value' => 'Не указано / неправильно указано название организиции',
			// 	);
			// }

			// if ((!isset($this->request->post['company_inn'])) || (!preg_match('/^[\d+]{10,12}$/si', $this->request->post['company_inn']))) {
			// 	$json['errors'][] = array(
			// 		'code' => 'company_inn',
			// 		'value' => 'Не указан / неправильно указан ИНН',
			// 	);
			// }

			// if ((!isset($this->request->post['company_kpp'])) || (!preg_match('/^[\d+]{9}$/si', $this->request->post['company_kpp']))) {
			// 	$json['errors'][] = array(
			// 		'code' => 'company_kpp',
			// 		'value' => 'Не указан / неправильно указан КПП',
			// 	);
			// }
		}

		if ((!isset($this->request->post['firstname'])) || (mb_strlen(trim($this->request->post['firstname'])) < 2)) {
			$json['errors'][] = array(
				'code' => 'firstname',
				'value' => 'Не указано / неправильно указано имя',
			);
		}

		// if ((!isset($this->request->post['address_1'])) || (mb_strlen(trim($this->request->post['address_1'])) < 2)) {
		// 	$json['errors'][] = array(
		// 		'code' => 'address_1',
		// 		'value' => 'Не указан / неправильно указан адрес',
		// 	);
		// }

		if ((!isset($this->request->post['shipping_method'])) || (mb_strlen(trim($this->request->post['shipping_method'])) < 2)) {
			$json['errors'][] = array(
				'code' => 'shipping_method',
				'value' => 'Не указан / неправильно тип доставки',
			);
		}

		if ((!isset($this->request->post['payment_method'])) || (mb_strlen(trim($this->request->post['payment_method'])) < 2)) {
			$json['errors'][] = array(
				'code' => 'payment_method',
				'value' => 'Не указан / неправильно тип оплаты',
			);
		}

		if ((!isset($this->request->post['telephone'])) || (!preg_match('/\+\d \d\d\d \d\d\d-\d\d-\d\d/sim', $this->request->post['telephone']))) {
			$json['errors'][] = array(
				'code' => 'telephone',
				'value' => 'Не указан / неправильно указан телефон',
			);
		}

		if ((!isset($this->request->post['email'])) || (!filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL))) {
			$json['errors'][] = array(
				'code' => 'email',
				'value' => 'Не указан / неправильно указан email',
			);
		}

		// if (!isset($this->request->post['selfcare'])) {
		// 	if ((!isset($this->request->post['address_1'])) || (mb_strlen(trim($this->request->post['address_1'])) < 10)) {
		// 		$json['errors'][] = array(
		// 			'code' => 'address_1',
		// 			'value' => 'Не указано / неправильно указан адрес',
		// 		);
		// 	}
		// }
		
		// if (!isset($this->request->post['agree'])) {
		// 	$json['errors'][] = array(
		// 		'code' => 'agree',
		// 		'value' => 'Нужно согласиться с Политикой и Соглашением',
		// 	);
		// }
		
		if ($json['errors']) {
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		} else {
	        $data = array();

	        $data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
	        $data['store_id'] = $this->config->get('config_store_id');
	        $data['store_name'] = $this->config->get('config_name');

	        if ($data['store_id']) {
	            $data['store_url'] = $this->config->get('config_url');
	        } else {
	            $data['store_url'] = HTTP_SERVER;
	        }

	        if ($this->customer->isLogged()) {
				$this->load->model('account/customer');

				$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

				$data['customer_id'] = $this->customer->getId();
				$data['customer_group_id'] = $customer_info['customer_group_id'];
			} else {
				$customer_info = array(
					'firstname' => '',
					'lastname' => '',
					'email' => 'no@localhost',
					'telephone' => '',
				);

				$data['customer_id'] = 0;
				$data['customer_group_id'] = (int)$customer_group_id;
			}

			// $this->load->model('localisation/country');
			// $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);

	        $data['firstname']              = !empty($this->request->post['firstname']) ? $this->request->post['firstname'] : $customer_info['firstname'];
	        $data['lastname']               = !empty($this->request->post['lastname']) ? $this->request->post['lastname'] : $customer_info['lastname'];
	        $data['email']                  = !empty($this->request->post['email']) ? $this->request->post['email'] : $customer_info['email'];
	        $data['telephone']              = !empty($this->request->post['telephone']) ? $this->request->post['telephone'] : $customer_info['telephone'];
	        $data['fax']                    = !empty($customer_info['fax']) ? $customer_info['fax'] : '';
	        // $data['custom_field']           = array();
	        // $data['custom_field'][1]        = !empty($this->request->post['source']) ? $this->request->post['source'] : '';
	        // $data['custom_field'][2]        = !empty($this->request->post['company_inn']) ? $this->request->post['company_inn'] : '';
	        // $data['custom_field'][3]        = !empty($this->request->post['company_kpp']) ? $this->request->post['company_kpp'] : '';
	        // $data['custom_field'][4]        = !empty($this->request->post['type']) ? $this->request->post['type'] : '';

	        $data['payment_firstname']      = $data['firstname'];
	        $data['payment_lastname']       = $data['lastname'];
	        $data['payment_company']        = !empty($this->request->post['company_name']) ? $this->request->post['company_name'] : '';
	        $data['payment_address_1']        = !empty($this->request->post['address_1']) ? $this->request->post['address_1'] : '';
	        $data['payment_address_2']      = '';
	        $data['payment_city']           = ''; //isset($country_info['city']) ? $country_info['city'] : ''; // $this->request->post['city'];
	        $data['payment_postcode']       = '';
	        $data['payment_zone']           = '';
	        $data['payment_zone_id']        = '';
	        $data['payment_country']        = ''; //isset($country_info['name']) ? $country_info['name'] : '';
	        $data['payment_country_id']     = ''; //isset($payment_address['country_id']) ? $payment_address['country_id'] : '';
	        $data['payment_address_format'] = ''; //$this->request->post['city'] . ', ' . $this->request->post['address_1'];
	        $data['payment_company_id']     = isset($payment_address['company_id']) ? $payment_address['company_id'] : '';
	        $data['payment_tax_id']         = isset($payment_address['tax_id']) ? $payment_address['tax_id'] : '';
	        $data['payment_custom_field']   = isset($payment_address['custom_field']) ? $payment_address['custom_field'] : array();

            $data['payment_method'] = $this->request->post['payment_method'];
	        $data['payment_code'] = 'cod';

	        if ($this->cart->hasShipping()) {
	            $data['shipping_firstname']      = $data['firstname'];
	            $data['shipping_lastname']       = $data['lastname'];
	            $data['shipping_company']        = !empty($this->request->post['company_name']) ? $this->request->post['company_name'] : '';
		        $data['shipping_address_1']      = !empty($this->request->post['address_1']) ? $this->request->post['address_1'] : '';
	            $data['shipping_address_2']      = '';
	            $data['shipping_city']           = ''; //$this->request->post['city'];
	            $data['shipping_postcode']       = '';
	            $data['shipping_zone']           = '';
	            $data['shipping_zone_id']        = '';
	            $data['shipping_country']        = ''; //isset($country_info['name']) ? $country_info['name'] : '';
	            $data['shipping_country_id']     = ''; //$this->request->post['country_id'];
	            $data['shipping_address_format'] = ''; //$this->request->post['city'] . ', ' . $this->request->post['address_1'];
	            $data['shipping_custom_field']   = isset($shipping_address['custom_field']) ? $shipping_address['custom_field'] : array();

                $data['shipping_method'] = $this->request->post['shipping_method'];
                $data['shipping_code'] = 'free.free';
	        } else {
	            $data['shipping_firstname']      = '';
	            $data['shipping_lastname']       = '';
	            $data['shipping_company']        = '';
	            $data['shipping_address_1']      = '';
	            $data['shipping_address_2']      = '';
	            $data['shipping_city']           = '';
	            $data['shipping_postcode']       = '';
	            $data['shipping_zone']           = '';
	            $data['shipping_zone_id']        = '';
	            $data['shipping_country']        = '';
	            $data['shipping_country_id']     = '';
	            $data['shipping_address_format'] = '';
	            $data['shipping_method']         = '';
	            $data['shipping_code']           = '';
	            $data['shipping_custom_field']   = array();
	        }

	        // $data['payment_address_format'] = ''; //$this->simplecheckout->getAddressFormat($data, 'payment');
	        // $data['shipping_address_format'] = ''; //$this->simplecheckout->getAddressFormat($data, 'shipping');

	        $product_data = array();

	        foreach ($this->cart->getProducts(true) as $product) {
	            $option_data = array();

	            foreach ($product['option'] as $option) {
	                $value = $option['value'];

	                $option_data[] = array(
	                    'product_option_id'       => $option['product_option_id'],
	                    'product_option_value_id' => $option['product_option_value_id'],
	                    'option_id'               => $option['option_id'],
	                    'option_value_id'         => $option['option_value_id'],
	                    'name'                    => $option['name'],
	                    'value'                   => $value,
	                    'type'                    => $option['type']
	                );
	            }

	            $product_data[] = array(
	                'product_id' => $product['product_id'],
	                'name'       => $product['name'],
	                'model'      => $product['model'],
	                'option'     => $option_data,
	                'download'   => $product['download'],
	                'quantity'   => $product['quantity'],
	                'subtract'   => $product['subtract'],
	                'price'      => $product['price'],
	                'total'      => $product['total'],
	                'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
	                'reward'     => $product['reward']
	            );
	        }

	        // Gift Voucher
	        $voucher_data = array();

	        // if (!empty($this->session->data['vouchers'])) {
	        //     foreach ($this->session->data['vouchers'] as $voucher) {
	        //         $voucher_data[] = array(
	        //             'description'      => $voucher['description'],
	        //             'code'             => substr(md5(rand()), 0, 10),
	        //             'to_name'          => $voucher['to_name'],
	        //             'to_email'         => $voucher['to_email'],
	        //             'from_name'        => $voucher['from_name'],
	        //             'from_email'       => $voucher['from_email'],
	        //             'voucher_theme_id' => $voucher['voucher_theme_id'],
	        //             'message'          => $voucher['message'],
	        //             'amount'           => $voucher['amount']

	        //         );
	        //     }
	        // }

	        $data['products'] = $product_data;
	        $data['vouchers'] = $voucher_data;
	        $data['totals'] = $totals;
	        $data['comment'] = !empty($this->request->post['comment']) ? $this->request->post['comment'] : '';
	        $data['total'] = $total;


	        if (isset($this->request->cookie['tracking'])) {
	            $data['tracking'] = $this->request->cookie['tracking'];

	            if ($version < 300) {
	                $this->load->model('affiliate/affiliate');
	                
	                $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);
	            } else {
	                $this->load->model('account/customer');

	                $affiliate_info = $this->model_account_customer->getAffiliateByTracking($this->request->cookie['tracking']);
	            }

	            $subtotal = $this->cart->getSubTotal();

	            if ($affiliate_info) {
	                $data['affiliate_id'] = $version < 300 ? $affiliate_info['affiliate_id'] : $affiliate_info['customer_id'];
	                $data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
	            } else {
	                $data['affiliate_id'] = 0;
	                $data['commission'] = 0;
	            }

	            if ($version >= 200) {
	                $this->load->model('checkout/marketing');

	                $marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);

	                if ($marketing_info) {
	                    $data['marketing_id'] = $marketing_info['marketing_id'];
	                } else {
	                    $data['marketing_id'] = 0;
	                }
	            }
	        } else {
	            $data['affiliate_id'] = 0;
	            $data['commission'] = 0;
	            $data['marketing_id'] = 0;
	            $data['tracking'] = '';
	        }

	        $data['language_id']    = $this->config->get('config_language_id');

	        $data['currency_id']    = $this->currency->getId($this->session->data['currency']);
	        $data['currency_code']  = $this->session->data['currency'];
	        $data['currency_value'] = $this->currency->getValue($this->session->data['currency']);

	        $data['ip'] = $this->request->server['REMOTE_ADDR'];

	        if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
	            $data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
	        } elseif(!empty($this->request->server['HTTP_CLIENT_IP'])) {
	            $data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
	        } else {
	            $data['forwarded_ip'] = '';
	        }

	        if (isset($this->request->server['HTTP_USER_AGENT'])) {
	            $data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
	        } else {
	            $data['user_agent'] = '';
	        }

	        if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
	            $data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
	        } else {
	            $data['accept_language'] = '';
	        }
	        
	        $this->load->model('checkout/order');

	        $order_id = $this->model_checkout_order->addOrder($data);
			$this->model_checkout_order->addOrderHistory($order_id, $this->config->get('config_order_status_id'));

	        $this->session->data['order_id'] = $order_id;

	        $redirect = html_entity_decode($this->url->link('checkout/success', 'order_id=' . $order_id . '&sign=' . md5(md5($order_id) . SIGN_SALT), true) , ENT_QUOTES, 'UTF-8');
	        $json = array('ok' => 1, 'redirect' => $redirect);

	        // $this->cart->clear();

	        $this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
	    }
    }
}