				<footer>
					<div class="footer-top">
						<aside id="footer-top">
							<div class="container">
								<div class="row">
									<div class="html-content">
										<div class="box-content">
											<div id="aecmsservices">
												<div class="aecmsserviceoffer">
													<div class="aeservice-content">
														<div class="offer-title">Получите скидку 45% на первый заказ</div>
													</div>
													<div class="button"><a href="/catalog/">В каталог</a></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</aside>
					</div>
					<div class="footer-container">
						<div class="container">
							<div class="row">
								<div class="footer-column footer-left-cms col-sm-3">
									<aside id="footer-left">
										<div class="html-content">
											<div class="box-content">
												<div id="aecmsfooter" class="col-md-3 links">
													<h3 class="title_block">О магазине</h3>
													<div id="aefooter">
														<div class="aefooter-desc">Обслуживание автоматических <br/>парковочных систем</div>
													</div>
												</div>
											</div>
										</div>
									</aside>
								</div>
								<div class="col-sm-3 footer-column footer-extras">
									<h5>Интернет-магазин</h5>
									<ul class="list-unstyled">
										<li><a href="/catalog/">Каталог</a></li>
										<li><a href="#">Акции</a></li>
										<li><a href="#">Бренды</a></li>
										<li><a href="#">Услуги</a></li>
									</ul>
								</div>
								<div class="col-sm-3 footer-column footer-my-account">
									<h5>Компания</h5>
									<ul class="list-unstyled">
										<li><a href="#">О компании</a></li>
										<li><a href="#">Отзывы</a></li>
										<li><a href="#">Документы</a></li>
									</ul>
								</div>
								<div class="footer-column footer-right-cms col-sm-3">
									<aside id="footer-right">
										<div class="html-content">
											<div class="box-content">
												<div id="contact-us">
													<div class="contact-us">
														<h5>Контакты</h5>
														<ul style="display: block;" class="list-unstyled">
															<li class="contact-detail">
																<div class="data address">
																	<i class="material-icons">location_on</i>
																	<div class="contact-address">г. Санкт-Петербург</div>
																</div>
															</li>
															<li class="block">
																<div class="data">
																	<div class="icon"><i class="material-icons">local_phone</i></div>
																	<span><a href="tel:<?php echo preg_replace('/[^\d\+]/', '', $telephone); ?>"><?php echo $telephone; ?></a></span>
																</div>
															</li>
															<?php if ($email) { ?>
															<li class="block">
																<div class="data">
																	<div class="icon"><i class="material-icons">email</i></div>
																	<span><a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></span>
																</div>
															</li>
															<?php } ?>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</aside>
								</div>
							</div>
						</div>
					</div>
					<div class="footer-bottom">
						<div class="container">
							<div class="footer-bottom-link col-sm-6">
								<div>
									&copy; <?php print date('Y'); ?> Обслуживание автоматических парковочных систем
									<a href="#" style="margin-left:30px">Конфиденциальность</a>
									<a href="#" style="margin-left:30px">Оферта</a>
								</div>
							</div>
						</div>
					</div>
				</footer>
			</div><!-- /#page -->
			<script><!--
				var ae_live_search = {
					selector: '#header-search input[name=\'search\']',
					text_no_matches: '',
					height: '50px'
				}

				$(document).ready(function() {
					var html = '';
					html += '<div class="live-search">';
					html += '	<ul>';
					html += '	</ul>';
					html += '<div class="result-text"></div>';
					html += '</div>';

					$(ae_live_search.selector).after(html);

					$(ae_live_search.selector).autocomplete({
						'source': function(request, response) {
							var filter_name = $(ae_live_search.selector).val();
							var cat_id = 0;
							var module_ae_live_search_min_length = '1';
							if (filter_name.length < module_ae_live_search_min_length) {
								$('.live-search').css('display','none');
								$('body').removeClass('search-open');
							}
							else{
								var html = '';
								html += '<li style="text-align: center;height:10px;">';
								html +=	'<img class="loading" src="image/catalog/demo/banners/loading.gif" />';
								html +=	'</li>';
								$('.live-search ul').html(html);
								$('.live-search').css('display','block');
								$('body').addClass('search-open');

								$.ajax({
									url: 'index.php?route=extension/module/ae_live_search&filter_name=' + encodeURIComponent(filter_name),
									dataType: 'json',
									success: function(result) {
										var products = result.products;
										$('.live-search ul li').remove();
										$('.result-text').html('');
										if (!$.isEmptyObject(products)) {
											var show_image = 1;
											var show_price = 1;
											var show_description = 0;
											$('.result-text').html('<a href="/index.php?route=product/search&amp;search='+filter_name+'" class="view-all-results"> View all results  ('+result.total+')</a>');

											$.each(products, function(index,product) {
												var html = '';

												html += '<li>';
												html += '<a href="' + product.url + '" title="' + product.name + '">';
												if(product.image && show_image){
													html += '	<div class="product-image col-sm-3 col-xs-4"><img alt="' + product.name + '" src="' + product.image + '"></div>';
												}
												html += '<div class="search-description col-sm-9 col-xs-8">';
												html += '	<div class="product-name">' + product.name;
												if(show_description){
													html += '<p>' + product.extra_info + '</p>';
												}
												html += '</div>';
												if(show_price){
													if (product.special) {
														html += '	<div class="product-price"><span class="price">' + product.special + '</span><span class="special">' + product.price + '</span></div>';
													} else {
														html += '	<div class="product-price"><span class="price">' + product.price + '</span></div>';
													}
												}
												html += '</div>';
												html += '<span style="clear:both"></span>';
												html += '</a>';
												html += '</li>';
												$('.live-search ul').append(html);
											});
										} else {
											var html = '';
											html += '<li style="text-align: center;height:10px;">';
											html +=	ae_live_search.text_no_matches;
											html +=	'</li>';

											$('.live-search ul').html(html);
										}
										$('.live-search').css('display','block');
										$('body').addClass('search-open');
										return false;
									}
								});
							}
						},
						'select': function(product) {
							$(ae_live_search.selector).val(product.name);
						}
					});

					$(document).bind("mouseup touchend", function(e){
						var container = $('.live-search');
						if (!container.is(e.target) && container.has(e.target).length === 0) {
							container.hide();
						}
					});
				});
				//-->
			</script>
			<?php foreach ($scripts as $script) { ?>
			<script src="<?php echo $script; ?>" type="text/javascript"></script>
			<?php } ?>
			<?php print $inline_scripts; ?>
		</body>
	</html>
