<?php print $header; ?>
				<div class="header-content-title"></div>
				<script><!--
					$(document).ready(function() {
						var max_link = 4;
						var moretext = "More";
						var items = $('#aetoplink_block ul li');
						var surplus = items.slice(max_link, items.length);
						surplus.wrapAll('<li class="more_menu aetoplink"><ul class="top-link clearfix">');
						$('.more_menu').prepend('<a href="#" class="level-top">'+moretext+'</a>');
						$('.more_menu').mouseover(function(){ $(this).children('ul').addClass('shown-link'); });
						$('.more_menu').mouseout(function(){ $(this).children('ul').removeClass('shown-link'); });
					});
					-->
				</script>
				<div class="fullbg">
					<div class="container main-bg">
						<div class="content-top">
							<div class="offer-slider">
								<div class="row">
									<!-- Main Slider -->
									<div class="slideshow-panel col-sm-9">
										<div class="ttloading-bg" style="display: none;"></div>
										<div class="swiper-viewport">
											<div id="slideshow0" class="slideshow-main swiper-container">
												<div class="swiper-wrapper">
													<?php if (sizeof($banners_slider) > 0) { ?>
													<?php foreach ($banners_slider as $banner) { ?>
													<div class="swiper-slide text-center">
														<a href="<?php echo $banner['href']; ?>">
														<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['name']; ?>" class="img-responsive" />
														</a>
													</div>
													<?php } ?>
													<?php } else { ?>
													<div class="swiper-slide text-center">
														<img src="/image/catalog/demo/banners/slider-01-1185x590.jpg" alt="slider" class="img-responsive" />
													</div>
													<?php } ?>
												</div>
												<div class="swiper-pagination slideshow0"></div>
												<div class="swiper-pager">
													<div class="swiper-button-prev"></div>
													<div class="swiper-button-next"></div>
												</div>
											</div>
										</div>
									</div>
									<!-- Right Banners -->
									<div id="aecmsrightbanner" class="col-xs-3">
										<div class="aerightbannerblock">
											<div class="aerightbanner-left">
												<?php foreach ($banners_right as $bi => $banner) { ?>
												<div class="aerightbanner<?php echo $bi + 1; ?> aerightbanner">
													<div class="aerightbanner-img"><a href="<?php echo $banner['href']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['name']; ?>"></a></div>
												</div>
												<?php } ?>
											</div>
										</div>
									</div>
								</div>
							</div>
							<script><!--
								$('#slideshow0').swiper({
									mode: 'horizontal',
									slidesPerView: 1,
									pagination: '.slideshow0',
									paginationClickable: true,
									nextButton: '.swiper-button-next',
								    prevButton: '.swiper-button-prev',
								    spaceBetween: 0,
									effect: 'fade',
									autoplay: 2500,
								    autoplayDisableOnInteraction: true,
									loop: true
								});
								-->
							</script>
							<div class="html-content">
								<div class="box-content"></div>
							</div>
						</div>
						<div class="content-bottom">
							<!-- Left Banner Sidebar -->
							<aside id="column-left" class="col-sm-2 hidden-xs">
								<div class="left-right-inner">
									<div class="swiper-viewport">
										<div id="banner0" class="swiper-container">
											<div class="swiper-wrapper">
												<?php if (sizeof($banners_left) > 0) { ?>
												<?php foreach ($banners_left as $banner) { ?>
												<div class="swiper-slide"><a href="<?php echo $banner['href']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['name']; ?>" class="img-responsive" /></a></div>
												<?php } ?>
												<?php } else { ?>
												<div class="swiper-slide"><img src="/image/catalog/demo/banners/left-banner-270x460.jpg" alt="Left-Banner" class="img-responsive" /></div>
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
										-->
									</script>
								</div>
							</aside>
							<!-- Main Content -->
							<div id="content" class="col-sm-10">
								<div class="aecat-main">
									<!-- Product Tabs -->
									<?php if (sizeof($featureds) > 0) { ?>
									<div class="aeProduct-Tab ae-cat-carousel products-list">
										<div class="ae-titletab">
											<div class="box-heading aehometab-title">
												<h3>Каталог товаров</h3>
											</div>
											<div id="aeCTab-" class="tab-box-heading">
												<ul class="nav nav-tabs">
													<?php foreach ($featureds as $fi => $featured) { ?>
													<li<?php if ($fi == 0) { ?> class="active"<?php } ?>><a href="#tab-<?php echo $fi + 1; ?>" data-toggle="tab"><?php echo $featured['name']; ?></a></li>
													<?php } ?>
												</ul>
											</div>
										</div>
										<div class="tab-content">
											<?php foreach ($featureds as $fi => $featured) { ?>
											<div class="tab-pane fade<?php if ($fi == 0) { ?> active in<?php } ?> row" id="tab-<?php echo $fi + 1; ?>">
												<div class="aecategory-tab products-carousel">
													<?php $chunks = array_chunk($featured['products'], 2); ?>
													<?php foreach ($chunks as $chunk) { ?>
													<div class="single-column">
														<?php foreach ($chunk as $product) { ?>
														<div class="product-layouts">
															<div class="product-thumb transition">
																<div class="image col-sm-12 col-xs-12">
																	<a href="<?php echo $product['href']; ?>">
																	<img class="image_thumb" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
																	<?php if (!empty($product['thumb2'])) { ?>
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
																<div class="thumb-description col-sm-12 col-xs-12">
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
														<?php } ?>
													</div>
													<?php } ?>
												</div>
											</div>
											<?php } ?>
										</div>
									</div>
									<?php } ?>

									<!-- Bottom Banners -->
									<?php if (sizeof($banners_bottom) > 0) { ?>
									<div class="html-content">
										<div class="box-content">
											<div class="bottombanner-container">
												<div class="row">
													<?php foreach ($banners_bottom as $bi => $banner) { ?>
													<div class="bottombanner col-xs-6 bottombanner-<?php echo $bi + 1; ?>">
														<a href="<?php echo $banner['href']; ?>">
														<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['name']; ?>">
														</a>
													</div>
													<?php } ?>
												</div>
											</div>
										</div>
									</div>
									<?php } ?>

									<!-- Latest Products -->
									<?php if (sizeof($latest) > 0) { ?>
									<div class="ae-latest-product col-sm-4">
										<div class="aelatest-products-innner">
											<div class="latest-carousel list-products">
												<div class="box-heading">
													<h3>Новые товары</h3>
												</div>
												<div class="latest-items products-carousel row">
													<?php foreach ($latest as $product) { ?>
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
																	<p class="description"><?php echo $product['description']; ?></p>
																	<div class="price">
																		<?php if ($product['special']) { ?>
																		<span class="price-new"><?php echo $product['special']; ?></span>
																		<span class="price-old"><?php echo $product['price']; ?></span>
																		<?php } else { ?>
																		<?php echo $product['price']; ?>
																		<?php if ($product['tax']) { ?><span class="price-tax">Без НДС: <?php echo $product['tax']; ?></span><?php } ?>
																		<?php } ?>
																	</div>
																</div>
															</div>
														</div>
													</div>
													<?php } ?>
												</div>
											</div>
										</div>
									</div>
									<?php } ?>

									<!-- Sub Banners -->
									<?php if (sizeof($banners_sub) > 0) { ?>
									<div class="html-content">
										<div class="box-content">
											<div class="subbanner-container">
												<div class="row">
													<?php foreach ($banners_sub as $bi => $banner) { ?>
													<div class="subbanner col-xs-6 subbanner-<?php echo $bi + 1; ?>">
														<a href="<?php echo $banner['href']; ?>">
														<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['name']; ?>">
														</a>
													</div>
													<?php } ?>
												</div>
											</div>
										</div>
									</div>
									<?php } ?>

									<!-- Hot Categories -->
									<?php if (sizeof($categories_featured) > 0) { ?>
									<div class="ae-category-featured">
										<div class="box-heading">
											<h3>Горячие категории</h3>
										</div>
										<div class="aefcat-items">
											<div class="row">
												<div class="category-feature ae-carousel">
													<?php foreach ($categories_featured as $cat) { ?>
													<div class="item">
														<div class="content">
															<div class="image col-xs-6 col-sm-6">
																<a href="<?php echo $cat['href']; ?>">
																<img src="<?php echo $cat['image']; ?>" alt="<?php echo $cat['name']; ?>" title="<?php echo $cat['name']; ?>" class="img-responsive" />
																</a>
															</div>
															<div class="caption col-xs-6 col-sm-6">
																<div class="cat-title">
																	<h4><a href="<?php echo $cat['href']; ?>"><?php echo $cat['name']; ?></a></h4>
																</div>
																<?php if (sizeof($cat['children']) > 0) { ?>
																<div class="cat-sub">
																	<ul>
																		<?php foreach ($cat['children'] as $child) { ?>
																		<li><a href="<?php echo $child['href']; ?>" class="list-group-item"><?php echo $child['name']; ?></a></li>
																		<?php } ?>
																	</ul>
																</div>
																<?php } ?>
															</div>
														</div>
													</div>
													<?php } ?>
												</div>
											</div>
										</div>
									</div>
									<?php } ?>

									<!-- Featured Products Carousel -->
									<?php if (sizeof($featureds) > 0 && sizeof($featureds[0]['products']) > 0) { ?>
									<div class="featured-carousel products-list">
										<div class="box-heading">
											<h3><?php echo $featureds[0]['name']; ?></h3>
										</div>
										<div class="featured-items products-carousel row">
											<?php foreach ($featureds[0]['products'] as $product) { ?>
											<div class="product-layouts">
												<div class="product-thumb transition">
													<div class="image">
														<a href="<?php echo $product['href']; ?>">
														<img class="image_thumb" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
														<?php if (!empty($product['thumb2'])) { ?>
														<img class="image_thumb_swap" src="<?php echo $product['thumb2']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
														<?php } ?>
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
											<?php } ?>
										</div>
									</div>
									<?php } ?>

								</div><!-- /.aecat-main -->
							</div><!-- /#content -->
						</div><!-- /.content-bottom -->
					</div><!-- /.container.main-bg -->
				</div><!-- /.fullbg -->
<?php print $footer; ?>
