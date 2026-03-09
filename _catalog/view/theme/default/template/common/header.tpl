<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="ltr" lang="en" class="ie8">
	<![endif]-->
	<!--[if IE 9 ]>
	<html dir="ltr" lang="en" class="ie9">
		<![endif]-->
		<!--[if (gt IE 9)|!(IE)]><!-->
		<html dir="ltr" lang="en">
			<!--<![endif]-->
			<head>
				<meta charset="UTF-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title><?php echo $title; ?></title>
				<?php if ($description) { ?>
				<meta name="description" content="<?php echo $description; ?>" />
				<?php } ?>
				<?php if ($keywords) { ?>
				<meta name="keywords" content="<?php echo $keywords; ?>" />
				<?php } ?>
				<?php foreach ($links as $link) { ?>
				<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
				<?php } ?>
				<script src="/assets/js/jquery/jquery-2.1.1.min.js"></script>
				<script src="/assets/js/bootstrap/js/bootstrap.min.js"></script>
				<link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap" rel="stylesheet">
				<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
				<link href="/assets/js/jquery/owl-carousel/owl.carousel.min.css" rel="stylesheet" media="screen" />
				<link href="/assets/js/jquery/owl-carousel/owl.theme.default.min.css" rel="stylesheet" media="screen" />
				<link href="/assets/css/bootstrap.min.css" rel="stylesheet" media="screen" />
				<link href="/assets/css/stylesheet.css" rel="stylesheet">
				<link href="/assets/css/aeblogstyle.css" rel="stylesheet" type="text/css" />
				<link href="/assets/css/aecountdown.css" rel="stylesheet" type="text/css" />
				<link href="/assets/css/category-feature.css" rel="stylesheet" type="text/css" />
				<link href="/assets/css/animate.css" rel="stylesheet" type="text/css" />
				<link href="/assets/css/newsletter.css" rel="stylesheet" type="text/css" />
				<link href="/assets/css/menu.css" rel="stylesheet" type="text/css" />
				<link href="/assets/css/lightbox.css" rel="stylesheet" type="text/css" />
				<link href="/assets/js/jquery/swiper/css/swiper.min.css" type="text/css" rel="stylesheet" media="screen" />
				<link href="/assets/js/jquery/swiper/css/opencart.css" type="text/css" rel="stylesheet" media="screen" />
				<script src="/assets/js/common.js"></script>
				<script src="/assets/js/addonScript.js"></script>
				<script src="/assets/js/lightbox-2.6.min.js"></script>
				<script src="/assets/js/waypoints.min.js"></script>
				<script src="/assets/js/ae_quickview.js"></script>
				<script src="/assets/js/menu.js"></script>
				<script src="/assets/js/theia-sticky-sidebar.min.js"></script>
				<script src="/assets/js/ResizeSensor.min.js"></script>
				<script src="/assets/js/bootstrap-notify.min.js"></script>
				<script src="/assets/js/aecountdown.js"></script>
				<script src="/assets/js/jquery/owl-carousel/owl.carousel.min.js"></script>
				<?php if ($logo) { ?>
				<link href="<?php echo $logo; ?>" rel="icon" />
				<?php } ?>
				<script src="/assets/js/jquery/swiper/js/swiper.jquery.js"></script>
				<script src="/assets/js/jquery/swiper/js/swiper.min.js"></script>
				<script src="/assets/js/jquery.bpopup.min.js"></script>
				<script src="/assets/js/jquery.cookie.js"></script>
				<?php foreach ($styles as $style) { ?>
				<link rel="<?php echo $style['rel']; ?>" href="<?php echo $style['href']; ?>" type="<?php echo $style['type']; ?>" media="<?php echo $style['media']; ?>" />
				<?php } ?>
				<?php foreach ($scripts as $script) { ?>
				<script src="<?php echo $script; ?>" type="text/javascript"></script>
				<?php } ?>
			</head>
			<body class="<?php echo isset($is_main) && $is_main ? 'common-home' : 'inner-page'; ?>">
				<div id="page">
					<header>
						<div class="header">
							<nav id="top">
								<div class="container">
									<div class="header-top-left col-sm-4">
										<div class="header-left-cms">
											<aside id="header-left">
												<div class="html-content">
													<div class="box-content">
														<div id="aecmsheaderservice">
															<div class="header-service">
																<a href="">
																	<div class="aeheader-service">Самая быстрая доставка</div>
																</a>
															</div>
														</div>
													</div>
												</div>
											</aside>
										</div>
									</div>
									<div class="header-top-right">
										<div id="top-links" class="nav pull-right">
											<ul class="list-inline">
												<li class="header-mail">
													<a href="tel:<?php echo preg_replace('/[^\d\+]/', '', $telephone); ?>"><i class="fa fa-phone"></i></a>
													<span class="hidden-xs hidden-sm hidden-md"><?php echo $telephone; ?></span>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</nav>
							<div class="full-header">
								<div class="container">
									<div class="header-left">
										<div id="logo">
											<a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
										</div>
									</div>
									<div class="search col-sm-8">
										<div id="header-search" class="input-group">
											<select name="category_id" class="form-control innner-search">
												<option value="0">Категории</option>
												<?php foreach ($categories as $category) { ?>
												<option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
												<?php foreach ($category['children'] as $child) { ?>
												<option value="<?php echo $child['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $child['name']; ?></option>
												<?php foreach ($child['children'] as $grandchild) { ?>
												<option value="<?php echo $grandchild['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $grandchild['name']; ?></option>
												<?php } ?>
												<?php } ?>
												<?php } ?>
											</select>
											<input type="text" name="search" value="" placeholder="Поиск по каталогу" class="form-control input-lg" />
											<span class="input-group-btn">
											<button type="button" class="btn btn-default btn-lg header-search-btn"><i class="material-icons icon-search">search</i>
											<span>Поиск</span>
											</button>
											</span>
										</div>
										<script>
											$('#header-search button.header-search-btn').bind('click', function() {
												url = 'index.php?route=product/search';
												var search = $('#header-search input[name=\'search\']').prop('value');
												if (search) { url += '&search=' + encodeURIComponent(search); }
												var category_id = $('#header-search select[name=\'category_id\']').prop('value');
												if (category_id > 0) { url += '&category_id=' + encodeURIComponent(category_id); }
												url += '&sub_category=true';
												url += '&description=true';
												location = url;
											});
											$('#header-search input[name=\'search\']').bind('keydown', function(e) {
												if (e.keyCode == 13) { $('#header-search button.header-search-btn').trigger('click'); }
											});
										</script>
									</div>
									<div class="header-right">
										<div class="cart">
											<div id="cart" class="btn-group">
												<button type="button" data-toggle="dropdown" data-loading-text="Loading..." class="btn btn-inverse btn-block btn-lg dropdown-toggle"><i class="material-icons shopping-cart">shopping_cart</i>
												<span class="cart-heading">Корзина</span>
												<span id="cart-total"><?php echo $count_products; ?></span></button>
												<ul class="dropdown-menu pull-right header-cart-toggle">
													<li>
														<p class="text-center">Your shopping cart is empty!</p>
													</li>
												</ul>
											</div>
										</div>
										<div class="user-info">
											<div class="dropdown">
												<?php if ($logged) { ?>
												<a href="<?php echo $account; ?>" title="Личный кабинет" class="dropdown-toggle" data-toggle="dropdown"><i class="material-icons user">perm_identity</i>
												<span class="aeuserheading">Кабинет</span><i class="material-icons expand-more">expand_more</i></a>
												<ul class="dropdown-menu dropdown-menu-right account-link-toggle">
													<li><a href="<?php echo $order; ?>"><i class="material-icons">list_alt</i> Заказы</a></li>
													<li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="material-icons favorite">favorite_border</i> <?php echo $text_wishlist; ?></a></li>
													<li><a href="<?php echo $logout; ?>"><i class="material-icons">exit_to_app</i> Выйти</a></li>
												</ul>
												<?php } else { ?>
												<a href="<?php echo $login; ?>" title="Войти" class="dropdown-toggle" data-toggle="dropdown"><i class="material-icons user">perm_identity</i>
												<span class="aeuserheading">Войти</span><i class="material-icons expand-more">expand_more</i></a>
												<ul class="dropdown-menu dropdown-menu-right account-link-toggle">
													<li><a href="<?php echo $login; ?>"><i class="material-icons">lock_outline</i> Войти</a></li>
													<li><a href="<?php echo $register; ?>"><i class='material-icons reg-person'>perm_identity</i> Регистрация</a></li>
													<li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="material-icons favorite">favorite_border</i> <span class="hidden-sm hidden-md"><?php echo $text_wishlist; ?></span></a></li>
												</ul>
												<?php } ?>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="header-bottom-block">
								<div class="container">
									<div class="header-bottom">
										<aside id="header-bottom">
											<div class="main-category-list col-sm-2 left-menu">
												<div class="cat-menu">
													<div class="ae-panel-heading" title="Каталог">
														<i class='material-icons'>dehaze</i>
														<span>Каталог</span>
													</div>
													<div class="ae-menu horizontal-menu ae-menu-bar" id="ae-menu-main">
														<ul class="ul-top-items">
															<?php foreach ($categories as $category) { ?>
															<?php if (sizeof($category['children']) > 0) { ?>
															<li class="li-top-item mega-menu">
																<a class="a-top-link" href="<?php echo $category['href']; ?>">
																<span><?php echo $category['name']; ?></span>
																</a>
																<div class="flyout-menu-container sub-menu-container">
																	<ul class="ul-second-items">
																		<?php foreach ($category['children'] as $child) { ?>
																		<li class="li-second-items">
																			<a href="<?php echo $child['href']; ?>" class="a-second-link a-item<?php if (sizeof($child['children']) > 0) print ' has-children'; ?>">
																			<span class="a-second-title"><?php echo $child['name']; ?></span>
																			<?php if (sizeof($child['children']) > 0) { ?><i class="material-icons chevron-right">chevron_right</i><?php } ?>
																			</a>
																			<?php if (sizeof($child['children']) > 0) { ?>
																			<div class="flyout-third-items">
																				<ul class="ul-third-items">
																					<?php foreach ($child['children'] as $grandchild) { ?>
																					<li class="li-third-items">
																						<a href="<?php echo $grandchild['href']; ?>" class="a-third-link"><span class="a-third-title"><?php echo $grandchild['name']; ?></span></a>
																					</li>
																					<?php } ?>
																				</ul>
																			</div>
																			<?php } ?>
																		</li>
																		<?php } ?>
																	</ul>
																</div>
															</li>
															<?php } else { ?>
															<li class="li-top-item">
																<a class="a-top-link" href="<?php echo $category['href']; ?>">
																<span><?php echo $category['name']; ?></span>
																</a>
															</li>
															<?php } ?>
															<?php } ?>
															<li class="li-top-item">
																<a class="a-top-link" href="<?php echo $contact; ?>">
																<span>Контакты</span>
																</a>
															</li>
														</ul>
													</div>
												</div>
											</div>
										</aside>
									</div>
								</div>
							</div>
						</div>
					</header>
