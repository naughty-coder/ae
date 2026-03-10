<?php print $header; ?>

<div class="header-content-title">
</div>

<div id="product-product" class="container product-product">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row">
  	<aside id="column-left" class="col-sm-2 hidden-xs">
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

    <?php if (!empty($featureds_sidebar) && !empty($featureds_sidebar[0]['products'])) { ?>
    <div class="featured-carousel products-list">
<div class="box-heading"><h3><?php echo $featureds_sidebar[0]['name']; ?></h3></div>
<div class="featured-items products-carousel row">
   <?php foreach ($featureds_sidebar[0]['products'] as $product) { ?>
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

	<h1 class="page-title"><?php echo $heading_title; ?></h1>
	  <!-- Product row START -->
      <div class="row">
	                	  	<div class="product-block">
        <div class="col-sm-5 product-images">
				  <!-- Product Image thumbnails START -->
          <div class="thumbnails">
            <?php if (!empty($images)) { ?>
            <div class="product-image">
			  <a class="thumbnail" title="<?php echo $heading_title; ?>">
			  <img src="<?php echo $images[0]['large']; ?>" title="<?php echo $heading_title; ?>" data-zoom-image="<?php echo $images[0]['popup']; ?>" alt="<?php echo $heading_title; ?>" />
			  </a>
			</div>
            		  <div class="additional-images-container">
            			<div class="additional-images">
			<?php foreach ($images as $image) { ?>
			<div class="image-additional">
			  <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" data-image="<?php echo $image['large']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" alt="<?php echo $heading_title; ?>" />
			</div>
			<?php } ?>
            			</div>
            		  </div>
            <?php } ?>
		  <!-- Product Image thumbnails END -->
		  </div>
                </div>
<script>

	  	var ttadditionalcontent = $('.additional-images').owlCarousel({
				items : 3,
				nav : true,
				dots : false,
				loop: false,
				autoplay:false,
				rtl:false,
				responsive: {
					0:{
						items:2
					},
					481:{
						items:3
					},
					768:{
						items:2
					},
					992:{
						items:2
					},
					1200:{
						items:3
					}
				}
		});

$(".additional-next").click(function(){
	$(".additional-images").trigger('owl.next');
})
$(".additional-prev").click(function(){
	$(".additional-images").trigger('owl.prev');
})
$(".additional-images-container .customNavigation").addClass('owl-navigation');

</script>
		                        <div class="col-sm-7 product-details">
		<h1 class="product-name"><?php echo $heading_title; ?></h1>
		  <!-- Product Rating START -->
          		  <div class="rating">
          <div class="product-rating">
            <?php for ($i = 1; $i <= 5; $i++) { ?>
            <span class="fa fa-stack"><i class="material-icons <?php echo ($i <= $rating) ? 'star_on' : 'star_off'; ?>"><?php echo ($i <= $rating) ? 'star' : 'star_border'; ?></i></span>
            <?php } ?>
		  </div>
		  <a class="product-total-review" href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;">
		  <i class='material-icons mode-comment'>mode_comment</i><?php echo $reviews; ?></a>
			<a class="product-write-review" href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;">
			<i class="material-icons mode-edit">edit</i>Write a review</a>
		  </div>
          		  <!-- Product Rating END -->

		<table class="product-info">
          <?php if ($manufacturer) { ?>
          <tr><td>Brand:</td><td class="product-info-value"><a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></td></tr>
          <?php } ?>
          <?php if ($model) { ?>
          <tr><td>Product Code:</td><td class="product-info-value"><?php echo $model; ?></td></tr>
          <?php } ?>
          <?php if ($reward) { ?>
          <tr><td>Reward Points:</td><td class="product-info-value"><?php echo $reward; ?></td></tr>
          <?php } ?>
          <tr><td>Availability:</td><td class="product-info-value"><?php echo $stock; ?></td></tr>
          </table>

                    <ul class="list-unstyled product-price">
                        <?php if ($special) { ?>
                        <li><h2><?php echo $special; ?></h2></li>
                        <li class="product-tax"><span style="text-decoration:line-through;"><?php echo $price; ?></span></li>
                        <?php } else { ?>
                        <li><h2><?php echo $price; ?></h2></li>
                        <?php } ?>
                        <?php if ($tax) { ?><li class="product-tax">Ex Tax: <?php echo $tax; ?></li><?php } ?>
                      </ul>

		  <!-- Product Options START -->
          <div id="product" class="product-options">
		    <?php if ($options) { ?>
		    <h3>Available Options</h3>
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div class="form-group required">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                <option value=""> --- Please Select --- </option>
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?> (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<?php } ?></option>
                <?php } ?>
              </select>
            </div>
            <?php } elseif ($option['type'] == 'radio') { ?>
            <div class="form-group required">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <?php foreach ($option['product_option_value'] as $option_value) { ?>
              <div class="radio">
                <label><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" /><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?> (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<?php } ?></label>
              </div>
              <?php } ?>
            </div>
            <?php } elseif ($option['type'] == 'checkbox') { ?>
            <div class="form-group required">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <?php foreach ($option['product_option_value'] as $option_value) { ?>
              <div class="checkbox">
                <label><input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" /><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?> (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<?php } ?></label>
              </div>
              <?php } ?>
            </div>
            <?php } elseif ($option['type'] == 'text') { ?>
            <div class="form-group required">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
            </div>
            <?php } elseif ($option['type'] == 'textarea') { ?>
            <div class="form-group required">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" rows="5" class="form-control"><?php echo $option['value']; ?></textarea>
            </div>
            <?php } elseif ($option['type'] == 'file') { ?>
            <div class="form-group required">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
              <button type="button" onclick="$('#input-option<?php echo $option['product_option_id']; ?>').trigger('click');" class="btn btn-default"><i class="material-icons">file_upload</i> Upload</button>
            </div>
            <?php } elseif ($option['type'] == 'date') { ?>
            <div class="form-group required">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control date" />
            </div>
            <?php } elseif ($option['type'] == 'datetime') { ?>
            <div class="form-group required">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="YYYY-MM-DD HH:MM" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control datetime" />
            </div>
            <?php } elseif ($option['type'] == 'time') { ?>
            <div class="form-group required">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="HH:MM" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control time" />
            </div>
            <?php } ?>
            <?php } ?>
		    <?php } ?>

            <div class="form-group product-quantity">
              <label class="control-label" for="input-quantity">Qty</label>
              <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <button type="button" id="button-cart" title="Add to Cart" data-loading-text="Loading..." class="btn btn-primary btn-lg btn-block">
			  Add to Cart </button>
            </div>
            			</div>
		  <!-- Product Options END -->

		  <!-- Product Wishlist Compare START -->
          <div class="btn-group">
            <button class="btn btn-default product-btn-wishlist" type="button" title="Add to Wish List" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class='material-icons favorite'>favorite_border</i>
			Add to Wish List
			</button>
            <button class="btn btn-default product-btn-compare" type="button" title="Add to compare" onclick="compare.add('<?php echo $product_id; ?>');"><i class="material-icons compare-arrows">compare_arrows</i>
			Add to compare
			</button>
          </div>
		  <!-- Product Wishlist Compare END -->

		 </div>
		 <!-- Product option details END -->
		 </div>
		  </div>  <!-- Product row END -->
		 <!-- Product nav Tabs START -->
		  <div class="col-sm-12 product-tabs">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-description" data-toggle="tab">Description</a></li>
            <?php if ($review_status) { ?>
            <li class="li-tab-review"><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
            <?php } ?>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
            <?php if ($review_status) { ?>
            <div class="tab-pane" id="tab-review">
              <form class="form-horizontal" id="form-review">
                <div id="review"></div>
                <h2>Write a review</h2>
                <?php if ($review_guest) { ?>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-name">Name</label>
                    <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-review">Your Review</label>
                    <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                    <div class="help-block"><span class="text-danger">Note:</span> HTML is not translated!</div>
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label">Rating</label>
                    &nbsp;&nbsp;&nbsp; Bad&nbsp;
                    <input type="radio" name="rating" value="1" />
                    &nbsp;
                    <input type="radio" name="rating" value="2" />
                    &nbsp;
                    <input type="radio" name="rating" value="3" />
                    &nbsp;
                    <input type="radio" name="rating" value="4" />
                    &nbsp;
                    <input type="radio" name="rating" value="5" />
                    &nbsp;Good
				  </div>
                </div>
                <?php if ($captcha) { ?>
                <fieldset>
                  <legend>Captcha</legend>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-captcha">Enter the code in the box below</label>
                    <div class="col-sm-10">
                      <input type="text" name="captcha" id="input-captcha" class="form-control" />
                      <img src="index.php?route=extension/captcha/basic/captcha" alt="" />
                    </div>
                  </div>
                </fieldset>
                <?php } ?>
                <div class="buttons clearfix">
                  <div class="pull-right">
                    <button type="button" id="button-review" data-loading-text="Loading..." class="btn btn-primary">Continue</button>
                  </div>
                </div>
                <?php } else { ?>
                <p><?php echo $text_login; ?></p>
                <?php } ?>
              </form>
            </div>
            <?php } ?>
            			</div>
	      </div>
		  <!-- Product tab END -->
		   <!-- Related products START -->
		  <?php if ($products) { ?>
		  <div class="related-carousel products-list">
		  <div class="box-heading"><h3>Related Products</h3></div>
		  <div class="related-items products-carousel row">
		  <?php foreach ($products as $product) { ?>
								<div class="product-layouts">
			  <div class="product-thumb transition">
			  <div class="ttimge-bg"></div>
		        <div class="image">
					   <a href="<?php echo $product['href']; ?>"> <img class="image_thumb" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /> <?php if ($product['thumb2']) { ?><img class="image_thumb_swap" src="<?php echo $product['thumb2']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /><?php } ?> </a>

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
					  <?php if ($product['description']) { ?>
					    <p class="description"><?php echo $product['description']; ?></p>
					  <?php } ?>
                                    <div class="price">
                                      <?php if ($product['special']) { ?><span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span><?php } else { ?><?php echo $product['price']; ?><?php } ?>
                                      <?php if ($product['tax']) { ?><span class="price-tax">Ex Tax: <?php echo $product['tax']; ?></span><?php } ?>
                                    </div>
                  							</div>
				</div>

				</div>
			</div>
		  <?php } ?>
		  </div>
		  </div>
		  <?php } ?>
		  <!-- Related products END -->

	  </div>

	</div>
</div>

<?php print $footer; ?>
