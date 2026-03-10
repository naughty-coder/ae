<?php print $header; ?>
<div id="content">
	<div class="container">
		<!-- Breadcrumbs -->
		<ul class="breadcrumb">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
			<?php } ?>
		</ul>

		<?php if ($thumb) { ?>
		<div class="category-image">
			<img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" />
		</div>
		<?php } ?>

		<h1 class="product-title"><?php echo $heading_title; ?></h1>

		<?php if ($description) { ?>
		<div class="category-description"><?php echo $description; ?></div>
		<?php } ?>

		<!-- Subcategories -->
		<?php if (sizeof($categories) > 0) { ?>
		<div class="row" id="subcategory-products">
			<?php foreach ($categories as $category) { ?>
			<div class="col-md-3 col-sm-4 col-xs-6">
				<div class="subcategory-block">
					<a href="<?php echo $category['href']; ?>">
					<img src="<?php echo $category['image']; ?>" alt="<?php echo $category['name']; ?>" class="img-responsive" />
					<div class="subcategory-name"><?php echo $category['name']; ?></div>
					</a>
				</div>
			</div>
			<?php } ?>
		</div>
		<?php } ?>

		<!-- Filter and Sort Controls -->
		<div class="row">
			<div class="col-sm-12">
				<div id="grid-view-controls" class="btn-group pull-right">
					<div class="aecat-sort-limit btn-group pull-right">
						<select id="input-sort" class="form-control">
							<?php foreach ($sorts as $sort_item) { ?>
							<option value="<?php echo $sort_item['href']; ?>"<?php if ($sort_item['value'] == $sort . '-' . $order) { ?> selected="selected"<?php } ?>><?php echo $sort_item['text']; ?></option>
							<?php } ?>
						</select>
						<select id="input-limit" class="form-control">
							<?php foreach ($limits as $limit_item) { ?>
							<option value="<?php echo $limit_item['href']; ?>"<?php if ($limit_item['value'] == $limit) { ?> selected="selected"<?php } ?>><?php echo $limit_item['text']; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
				<div class="pull-left">
					<span class="results-count"><?php echo $product_total; ?> товаров</span>
				</div>
			</div>
		</div>

		<script>
			$('#input-sort').bind('change', function() { location = $(this).val(); });
			$('#input-limit').bind('change', function() { location = $(this).val(); });
		</script>

		<!-- Products + Filter -->
		<div class="row">
			<!-- Left filter column -->
			<?php if ($column_left) { ?>
			<div class="col-sm-3" id="column-left">
				<?php echo $column_left; ?>
			</div>
			<div class="col-sm-9">
			<?php } else { ?>
			<div class="col-sm-12">
			<?php } ?>
				<!-- Product List -->
				<?php if (sizeof($products) > 0) { ?>
				<div class="products-list">
					<?php foreach ($products as $product) { ?>
					<div class="product-layout product-list col-xs-12">
						<div class="product-thumb row">
							<div class="image col-sm-3 col-xs-12">
								<a href="<?php echo $product['href']; ?>">
								<img class="image_thumb" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
								<?php if ($product['thumb2']) { ?>
								<img class="image_thumb_swap" src="<?php echo $product['thumb2']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
								<?php } ?>
								</a>
								<div class="ttproducthover">
									<div class="button-group">
										<button class="btn-cart" type="button" title="Добавить в корзину" onclick="cart.add('<?php echo $product['product_id']; ?>')">
										<i class="material-icons">shopping_cart</i>
										<span class="hidden-xs hidden-sm hidden-md">В корзину</span>
										<span class="loading"><i class="material-icons">cached</i></span>
										</button>
										<button class="btn-wishlist" title="Добавить в избранное" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
										<i class="material-icons icon-wishlist">favorite_border</i>
										<span>В избранное</span>
										<span class="loading"><i class="material-icons">cached</i></span>
										</button>
										<button class="btn-compare" title="Добавить к сравнению" onclick="compare.add('<?php echo $product['product_id']; ?>');">
										<i class="material-icons icon-exchange">sync</i>
										<span>Сравнить</span>
										<span class="loading"><i class="material-icons">cached</i></span>
										</button>
										<button class="btn-quickview" type="button" title="Быстрый просмотр" onclick="ae_quickview.ajaxView('<?php echo $product['href']; ?>')">
										<i class="material-icons quick_view_icon">visibility</i>
										<span>Быстрый просмотр</span>
										<span class="loading"><i class="material-icons">cached</i></span>
										</button>
									</div>
								</div>
							</div>
							<div class="thumb-description col-sm-9 col-xs-12">
								<div class="caption">
									<div class="product-description">
										<h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
										<?php if ($product['description']) { ?>
										<p class="description"><?php echo $product['description']; ?></p>
										<?php } ?>
									</div>
									<div class="product-price-and-shipping">
										<div class="price">
											<?php if ($product['special']) { ?>
											<span class="price-new"><?php echo $product['special']; ?></span>
											<span class="price-old"><?php echo $product['price']; ?></span>
											<?php } else { ?>
											<?php echo $product['price']; ?>
											<?php } ?>
											<?php if ($product['tax']) { ?><span class="price-tax">Ex Tax: <?php echo $product['tax']; ?></span><?php } ?>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<?php } ?>
				</div>

				<!-- Pagination -->
				<?php if ($pagination) { ?>
				<div class="row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
				</div>
				<?php } ?>

				<?php } else { ?>
				<div class="col-sm-12">
					<p>В категории пусто</p>
				</div>
				<?php } ?>
			</div>
		</div>
	</div>
</div>
<?php print $footer; ?>
