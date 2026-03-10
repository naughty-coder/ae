<?php echo $header; ?>
<div id="content">
	<div class="container">
		<!-- Breadcrumbs -->
		<ul class="breadcrumb">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
			<?php } ?>
		</ul>

		<div class="row">
			<!-- Product Images -->
			<div class="col-sm-5 product-images">
				<div class="thumbnails">
					<ul id="image-additional" class="product-additional-images">
						<?php foreach ($images as $image) { ?>
						<li>
							<a href="<?php echo $image['popup']; ?>" data-lightbox="product" title="<?php echo $heading_title; ?>">
							<img src="<?php echo $image['popup']; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" />
							</a>
						</li>
						<?php } ?>
					</ul>
				</div>
			</div>

			<!-- Product Info -->
			<div class="col-sm-7 product-info">
				<h1 class="product-name"><?php echo $heading_title; ?></h1>

				<!-- Rating -->
				<?php if ($review_status) { ?>
				<div class="product-rating">
					<?php for ($i = 1; $i <= 5; $i++) { ?>
					<i class="material-icons <?php echo ($i <= $rating) ? 'star_on' : 'star_off'; ?>"><?php echo ($i <= $rating) ? 'star' : 'star_border'; ?></i>
					<?php } ?>
					<span class="reviews-count"><?php echo $reviews; ?></span>
				</div>
				<?php } ?>

				<!-- Product Table Info -->
				<table class="product-info table">
					<tbody>
						<?php if ($model) { ?>
						<tr>
							<td>Артикул:</td>
							<td><?php echo $model; ?></td>
						</tr>
						<?php } ?>
						<?php if ($manufacturer) { ?>
						<tr>
							<td>Производитель:</td>
							<td><a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></td>
						</tr>
						<?php } ?>
						<tr>
							<td>Наличие:</td>
							<td><?php echo $stock; ?></td>
						</tr>
						<?php if ($reward) { ?>
						<tr>
							<td>Бонусные баллы:</td>
							<td><?php echo $reward; ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>

				<!-- Price -->
				<ul class="list-unstyled product-price">
					<?php if ($price !== false) { ?>
					<?php if ($special) { ?>
					<li>
						<h2>
							<span class="price-new"><?php echo $special; ?></span>
							<span class="price-old"><?php echo $price; ?></span>
						</h2>
					</li>
					<?php if ($tax) { ?>
					<li><span class="price-tax">Без НДС: <?php echo $tax; ?></span></li>
					<?php } ?>
					<?php } else { ?>
					<li>
						<h2><span class="price-new"><?php echo $price; ?></span></h2>
					</li>
					<?php if ($tax) { ?>
					<li><span class="price-tax">Без НДС: <?php echo $tax; ?></span></li>
					<?php } ?>
					<?php } ?>
					<?php } ?>
					<?php if ($discounts) { ?>
					<?php foreach ($discounts as $discount) { ?>
					<li>При заказе от <?php echo $discount['quantity']; ?> шт.: <b><?php echo $discount['price']; ?></b></li>
					<?php } ?>
					<?php } ?>
				</ul>

				<!-- Product Options Form -->
				<div id="product" class="product-options">
					<form class="form-horizontal" id="product-form">
						<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />

						<!-- Material/Metal Pairs (custom attribute) -->
						<?php if ($pairs) { ?>
						<?php list($mdl, $mtl) = explode('_', $model, 2); ?>
						<div class="form-group variant-picker-item">
							<label class="col-sm-3 control-label">Материал:</label>
							<div class="col-sm-9">
								<div class="variant-picker-values">
									<?php foreach ($pairs as $metall => $pair) { ?>
									<?php if ($metall == $mtl) { ?>
									<span class="btn btn-default active"><?php echo $metall == 'Z' ? 'Золото' : 'Серебро'; ?></span>
									<?php } else { ?>
									<a href="<?php echo $pair['href']; ?>" class="btn btn-default"><?php echo $metall == 'Z' ? 'Золото' : 'Серебро'; ?></a>
									<?php } ?>
									<?php } ?>
								</div>
							</div>
						</div>
						<?php } ?>

						<!-- Product Options -->
						<?php foreach ($options as $option) { ?>
						<div class="form-group<?php if ($option['required']) { ?> required<?php } ?>">
							<label class="col-sm-3 control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
							<div class="col-sm-9">
								<?php if ($option['type'] == 'select') { ?>
								<select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
									<option value="">-- Выберите <?php echo $option['name']; ?> --</option>
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
									<option value="<?php echo $option_value['product_option_value_id']; ?>"<?php if ($option['value'] == $option_value['product_option_value_id']) { ?> selected="selected"<?php } ?>>
										<?php echo $option_value['name']; ?>
										<?php if ($option_value['price']) { ?>(<?php echo $option_value['price_prefix'] . $option_value['price']; ?>)<?php } ?>
									</option>
									<?php } ?>
								</select>
								<?php } elseif ($option['type'] == 'radio') { ?>
								<div>
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
									<div class="radio">
										<label>
											<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>"<?php if ($option['value'] == $option_value['product_option_value_id']) { ?> checked="checked"<?php } ?> />
											<?php echo $option_value['name']; ?>
											<?php if ($option_value['price']) { ?>(<?php echo $option_value['price_prefix'] . $option_value['price']; ?>)<?php } ?>
										</label>
									</div>
									<?php } ?>
								</div>
								<?php } elseif ($option['type'] == 'checkbox') { ?>
								<div>
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
									<div class="checkbox">
										<label>
											<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>"<?php if (in_array($option_value['product_option_value_id'], (array)$option['value'])) { ?> checked="checked"<?php } ?> />
											<?php echo $option_value['name']; ?>
											<?php if ($option_value['price']) { ?>(<?php echo $option_value['price_prefix'] . $option_value['price']; ?>)<?php } ?>
										</label>
									</div>
									<?php } ?>
								</div>
								<?php } elseif ($option['type'] == 'text') { ?>
								<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" class="form-control" />
								<?php } elseif ($option['type'] == 'textarea') { ?>
								<textarea name="option[<?php echo $option['product_option_id']; ?>]" class="form-control" rows="3"><?php echo $option['value']; ?></textarea>
								<?php } elseif ($option['type'] == 'file') { ?>
								<input type="file" name="option[<?php echo $option['product_option_id']; ?>]" class="form-control" />
								<?php } elseif ($option['type'] == 'date') { ?>
								<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" class="form-control date" />
								<?php } elseif ($option['type'] == 'time') { ?>
								<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" class="form-control time" />
								<?php } elseif ($option['type'] == 'datetime') { ?>
								<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" class="form-control datetime" />
								<?php } ?>
							</div>
						</div>
						<?php } ?>

						<!-- Quantity -->
						<div class="form-group">
							<label class="col-sm-3 control-label">Количество:</label>
							<div class="col-sm-9">
								<div class="input-group quantity-control">
									<span class="input-group-btn">
										<button type="button" class="btn btn-default btn-quantity btn-minus" onclick="this.parentNode.nextElementSibling.value = Math.max(<?php echo $minimum; ?>, (parseInt(this.parentNode.nextElementSibling.value) || <?php echo $minimum; ?>) - 1);">-</button>
									</span>
									<input type="text" name="quantity" value="<?php echo $minimum; ?>" class="form-control" />
									<span class="input-group-btn">
										<button type="button" class="btn btn-default btn-quantity btn-plus" onclick="this.parentNode.previousElementSibling.value = (parseInt(this.parentNode.previousElementSibling.value) || <?php echo $minimum; ?>) + 1;">+</button>
									</span>
								</div>
							</div>
						</div>

						<!-- Action Buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<div class="product-action-buttons">
									<button type="button" id="button-cart" onclick="cart.add('<?php echo $product_id; ?>', jQuery('input[name=quantity]').val(), jQuery('#product-form').serialize());" class="btn btn-primary btn-lg btn-cart">
									<i class="material-icons">shopping_cart</i> Добавить в корзину
									</button>
									<button type="button" onclick="wishlist.add('<?php echo $product_id; ?>');" class="btn btn-default btn-wishlist" title="Добавить в избранное">
									<i class="material-icons">favorite_border</i>
									</button>
									<button type="button" onclick="compare.add('<?php echo $product_id; ?>');" class="btn btn-default btn-compare" title="Добавить к сравнению">
									<i class="material-icons">sync</i>
									</button>
								</div>
							</div>
						</div>
					</form>
				</div>

				<!-- Tags -->
				<?php if ($tags) { ?>
				<div class="product-tags">
					<strong>Теги:</strong>
					<?php foreach ($tags as $tag) { ?>
					<a href="<?php echo $tag['href']; ?>" class="label label-default"><?php echo $tag['tag']; ?></a>
					<?php } ?>
				</div>
				<?php } ?>
			</div>
		</div>

		<!-- Product Tabs: Description, Attributes, Reviews -->
		<div class="row product-tabs-section">
			<div class="col-sm-12">
				<ul class="nav nav-tabs product-info-tabs">
					<li class="active"><a href="#tab-description" data-toggle="tab">Описание</a></li>
					<?php if ($attribute_groups) { ?>
					<li><a href="#tab-attribute" data-toggle="tab">Характеристики</a></li>
					<?php } ?>
					<?php if ($review_status) { ?>
					<li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
					<?php } ?>
				</ul>
				<div class="tab-content">
					<!-- Description Tab -->
					<div id="tab-description" class="tab-pane active">
						<?php echo $description; ?>
					</div>

					<!-- Attributes Tab -->
					<?php if ($attribute_groups) { ?>
					<div id="tab-attribute" class="tab-pane">
						<?php foreach ($attribute_groups as $attribute_group) { ?>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th colspan="2"><?php echo $attribute_group['name']; ?></th>
								</tr>
							</thead>
							<tbody>
								<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
								<tr>
									<td><?php echo $attribute['name']; ?></td>
									<td><?php echo $attribute['text']; ?></td>
								</tr>
								<?php } ?>
							</tbody>
						</table>
						<?php } ?>
					</div>
					<?php } ?>

					<!-- Reviews Tab -->
					<?php if ($review_status) { ?>
					<div id="tab-review" class="tab-pane">
						<div id="review">
							<?php if ($review_guest || $this->customer->isLogged()) { ?>
							<h3>Написать отзыв</h3>
							<form class="form-horizontal">
								<div class="form-group">
									<label class="col-sm-3 control-label">Ваше имя:</label>
									<div class="col-sm-9">
										<input type="text" name="name" value="<?php echo $customer_name; ?>" class="form-control" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">Ваш отзыв:</label>
									<div class="col-sm-9">
										<textarea name="text" class="form-control" rows="5"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">Рейтинг:</label>
									<div class="col-sm-9">
										<div class="rating-stars">
											<?php for ($i = 1; $i <= 5; $i++) { ?>
											<label><input type="radio" name="rating" value="<?php echo $i; ?>" /> <?php echo $i; ?> <i class="material-icons">star</i></label>
											<?php } ?>
										</div>
									</div>
								</div>
								<?php if ($captcha) { ?>
								<div class="form-group">
									<label class="col-sm-3 control-label">Капча:</label>
									<div class="col-sm-9"><?php echo $captcha; ?></div>
								</div>
								<?php } ?>
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-9">
										<button type="button" id="button-review" class="btn btn-primary">Отправить отзыв</button>
									</div>
								</div>
							</form>
							<?php } ?>
						</div>
					</div>
					<?php } ?>
				</div>
			</div>
		</div>

		<!-- Related Products -->
		<?php if ($products) { ?>
		<div class="related-products">
			<h3>Похожие товары</h3>
			<div class="related-carousel ae-carousel">
				<?php foreach ($products as $product) { ?>
				<div class="item">
					<div class="product-layouts">
						<div class="product-thumb transition">
							<div class="image">
								<a href="<?php echo $product['href']; ?>">
								<img class="image_thumb" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
								</a>
								<div class="button-group">
									<button class="btn-cart" type="button" title="Добавить в корзину" onclick="cart.add('<?php echo $product['product_id']; ?>')">
									<i class="material-icons">shopping_cart</i>
									<span class="loading"><i class="material-icons">cached</i></span>
									</button>
									<button class="btn-wishlist" title="Добавить в избранное" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
									<i class="material-icons icon-wishlist">favorite_border</i>
									<span class="loading"><i class="material-icons">cached</i></span>
									</button>
									<button class="btn-compare" title="Добавить к сравнению" onclick="compare.add('<?php echo $product['product_id']; ?>');">
									<i class="material-icons icon-exchange">sync</i>
									<span class="loading"><i class="material-icons">cached</i></span>
									</button>
									<button class="btn-quickview" type="button" title="Быстрый просмотр" onclick="ae_quickview.ajaxView('<?php echo $product['href']; ?>')">
									<i class="material-icons quick_view_icon">visibility</i>
									<span class="loading"><i class="material-icons">cached</i></span>
									</button>
								</div>
							</div>
							<div class="thumb-description">
								<div class="caption">
									<h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
									<div class="price">
										<?php if ($product['special']) { ?>
										<span class="price-new"><?php echo $product['special']; ?></span>
										<span class="price-old"><?php echo $product['price']; ?></span>
										<?php } else { ?>
										<?php echo $product['price']; ?>
										<?php } ?>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<?php } ?>
			</div>
		</div>
		<script><!--
			$('.related-carousel.ae-carousel').owlCarousel({
				items: 4,
				nav: true,
				dots: false,
				responsive: {
					0: { items: 1 },
					480: { items: 2 },
					768: { items: 3 },
					1200: { items: 4 }
				}
			});
			-->
		</script>
		<?php } ?>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$('#button-cart').bind('click', function() {
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: $('#product-form').serialize(),
			dataType: 'json',
			success: function(json) {
				if (json['redirect']) {
					location = json['redirect'];
				}
				if (json['success']) {
					$('#cart-total').html(json['total']);
				}
			}
		});
	});

	$('#button-review').bind('click', function() {
		$.ajax({
			url: 'index.php?route=product/product/review',
			type: 'post',
			data: {
				product_id: '<?php echo $product_id; ?>',
				name: $('input[name=name]').val(),
				text: $('textarea[name=text]').val(),
				rating: $('input[name=rating]:checked').val()
			},
			dataType: 'json',
			success: function(json) {
				if (json['success']) {
					alert(json['success']);
				}
			}
		});
	});
});
</script>
<?php echo $footer; ?>
