<?php print $header; ?>

<div class="header-content-title">
</div>

<div id="product-category" class="container product-category">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><aside id="column-left" class="col-sm-2 hidden-xs">
  <div class="left-right-inner">

    <div class="swiper-viewport">
  <div id="banner0" class="swiper-container">
    <div class="swiper-wrapper">
      <?php if (defined('USE_DEMO_BANNERS') && USE_DEMO_BANNERS) { ?>
      <div class="swiper-slide"><a href="#"><img src="catalog/view/theme/default/image/demo/banners/left-banner-270x460.jpg" alt="Left-Banner" class="img-responsive" /></a></div>
      <?php } else { ?>
      <?php foreach ($banners_left as $banner) { ?>
      <div class="swiper-slide"><a href="<?php echo $banner['href']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['name']; ?>" class="img-responsive" /></a></div>
      <?php } ?>
      <?php } ?>
    </div>
  </div>
</div>
<script><!--
$('#banner0').swiper({
	effect: 'fade',
	autoplay: 2500,
    autoplayDisableOnInteraction: false
});
--></script>

    <?php if (!empty($featureds) && !empty($featureds[0]['products'])) { ?>
    <div class="featured-carousel products-list">
<div class="box-heading"><h3><?php echo $featureds[0]['name']; ?></h3></div>
<div class="featured-items products-carousel row">
   <?php foreach ($featureds[0]['products'] as $product) { ?>
   <div class="product-layouts">
    <div class="product-thumb transition">
      <div class="image">
					<a href="<?php echo $product['href']; ?>">
				<img class="image_thumb" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				<?php if ($product['thumb2']) { ?>
				<img class="image_thumb_swap" src="<?php echo $product['thumb2']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				<?php } ?>
			</a>
			  <div class="button-group">
				<button class="btn-cart " type="button" title="Add to Cart" onclick="cart.add('<?php echo $product['product_id']; ?>')">
					<i class="material-icons">shopping_cart</i> <span class="hidden-xs hidden-sm hidden-md">Add to Cart</span>
				<span class="loading"><i class="material-icons">cached</i></span>
		</button>
			  	<button class="btn-wishlist" title="Add to Wish List" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
				<i class="material-icons icon-wishlist">favorite_border</i>
				<span title="Add to Wish List">Add to Wish List</span>
				<span class="loading"><i class="material-icons">cached</i></span>
				</button>
				<button class="btn-compare" title="Add to compare" onclick="compare.add('<?php echo $product['product_id']; ?>');">
				<i class="material-icons icon-exchange">sync</i>
				<span title="Add to compare">Add to compare</span>
				<span class="loading"><i class="material-icons">cached</i></span>
				</button>
				<button class="btn-quickview" type="button" title="Quick View" onclick="tt_quickview.ajaxView('<?php echo $product['href']; ?>')">
				<i class="material-icons quick_view_icon">visibility</i>
				<span title="Quick View">Quick View</span>
				<span class="loading"><i class="material-icons">cached</i></span>
				</button>
      </div>

	  </div>
	  <div class="thumb-description">
      <div class="caption">
        <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                <div class="price">
                    <?php if ($product['special']) { ?><span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span><?php } else { ?><?php echo $product['price']; ?><?php } ?>
              </div>
              </div>
	 </div>
    </div>
  </div>
   <?php } ?>
</div>
</div>
    <?php } ?>

  </div>
</aside>

                <div id="content" class="col-sm-10">

	  <!-- Category Description START -->
      <h1 class="category-name"><?php echo $heading_title; ?></h1>

      <?php if ($description) { ?>
	  <div class="category-description">
      <div class="row">
	    <?php echo $description; ?>
		</div>
		</div>
      <?php } ?>

	  <!-- Category Description END -->

	  <!-- Category filter START -->
	  <div class="category-filter">
	    <!-- Grid-List Buttons -->
        <div class="col-md-2 filter-grid-list">
          <div class="btn-group">
            <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="Grid"><i class="material-icons grid-on">grid_on</i></button>
            <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="List"><i class="material-icons list-on">format_list_bulleted</i></button>
            <button type="button" id="short-view" class="btn btn-default" data-toggle="tooltip" title="Short"><i class='material-icons'>dehaze</i></button>
          </div>
        </div>

		<!-- Show Products Selection -->
		<div class="filter-show">
          <div class="col-md-4 text-right filter-text">
            <label class="input-group-addon control-label" for="input-limit">Show:</label>
		  </div>
		  <div class="col-md-8 text-right filter-selection">
            <select id="input-limit" class="form-control" onchange="location = this.value;">
              <?php foreach ($limits as $limit_item) { ?>
              <option value="<?php echo $limit_item['href']; ?>"<?php if ($limit_item['value'] == $limit) { ?> selected="selected"<?php } ?>><?php echo $limit_item['text']; ?></option>
              <?php } ?>
            </select>
          </div>
        </div>

		<!-- Sort By Selection -->
		<div class="filter-sort-by">
		  <div class="col-md-3 text-right filter-text">
            <label class="input-group-addon control-label" for="input-sort">Sort By:</label>
		  </div>
          <div class="col-md-9 text-right filter-selection">
            <select id="input-sort" class="form-control" onchange="location = this.value;">
              <?php foreach ($sorts as $sort_item) { ?>
              <option value="<?php echo $sort_item['href']; ?>"<?php if ($sort_item['value'] == $sort . '-' . $order) { ?> selected="selected"<?php } ?>><?php echo $sort_item['text']; ?></option>
              <?php } ?>
            </select>
          </div>
        </div>
      </div>
	  <!-- Category filter END -->

	  <!-- Category products START -->
	  <div class="category-products">
      <div class="row">
	    <?php if (sizeof($products) > 0) { ?>
	    <?php foreach ($products as $product) { ?>
          <div class="product-layout product-list col-xs-12">
          <div class="product-thumb row">
            <div class="image">
								<a href="<?php echo $product['href']; ?>">
						<img class="image_thumb" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
						<?php if ($product['thumb2']) { ?>
						<img class="image_thumb_swap" src="<?php echo $product['thumb2']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
						<?php } ?>
					</a>
					<?php if ($product['rating']) { ?>
					<div class="rating">
					<?php for ($i = 1; $i <= 5; $i++) { ?>
					<span class="fa-stack"><i class="material-icons <?php echo ($i <= $product['rating']) ? 'star_on' : 'star_off'; ?>"><?php echo ($i <= $product['rating']) ? 'star' : 'star_border'; ?></i></span>
					<?php } ?>
					</div>
					<?php } ?>
							<div class="ttproducthover">
			  <div class="button-group">
			  <div class="tt-button-container">
					<button class="btn-cart " type="button" title="Add to Cart" onclick="cart.add('<?php echo $product['product_id']; ?>')">
						<i class="material-icons">shopping_cart</i> <span class="hidden-xs hidden-sm hidden-md">Add to Cart</span>
					</button>
				</div>
			  	<button class="btn-wishlist" title="Add to Wish List" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
				<i class="material-icons icon-wishlist">favorite_border</i>
				<span title="Add to Wish List">Add to Wish List</span>
				<span class="loading"><i class="material-icons">cached</i></span>
				</button>
				<button class="btn-compare" title="Add to compare" onclick="compare.add('<?php echo $product['product_id']; ?>');">
				<i class="material-icons icon-exchange">sync</i>
				<span title="Add to compare">Add to compare</span>
				<span class="loading"><i class="material-icons">cached</i></span>
				</button>
				<button class="btn-quickview" type="button" title="Quick View" onclick="tt_quickview.ajaxView('<?php echo $product['href']; ?>')">
				<i class="material-icons quick_view_icon">visibility</i>
				<span title="Quick View">Quick View</span>
				<span class="loading"><i class="material-icons">cached</i></span>
				</button>
			  </div>
			   </div>

		  </div>
            <div class="thumb-description">
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
                      <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
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
	    <?php } else { ?>
        <div class="col-sm-12"><p>В категории пусто</p></div>
	    <?php } ?>
        	  </div>
	  </div>
	  <!-- Category products END -->
	  <!-- Category pagination START -->
      <div class="category-pagination">
        <div class="col-xs-6 text-left"><?php echo $results; ?></div>
        <div class="col-xs-6 text-right"><?php echo $pagination; ?></div>
      </div>
	  <!-- Category pagination END -->

	  </div>

	</div>
</div>

<?php print $footer; ?>
