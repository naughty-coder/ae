<!DOCTYPE html>

<!--[if IE 8 ]><html class="ie" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru-RU" lang="ru-RU"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru-RU" lang="ru-RU">
<!--<![endif]-->

<head>
    <meta charset="utf-8">
    
    <title><?php echo $title; ?></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <?php if ($description) { ?>
    <meta name="description" content="<?php echo $description; ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
    <meta name="keywords" content= "<?php echo $keywords; ?>" />
    <?php } ?>

    <!-- font -->
    <link rel="stylesheet" href="/assets/fonts/fonts.css">
    <link rel="stylesheet" href="/assets/icon/icomoon/style.css">
    <!-- css -->
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/swiper-bundle.min.css">
    <link rel="stylesheet" href="/assets/css/animate.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/styles.css?AAA">

    <!-- Favicon and Touch Icons  -->
    <!-- <link rel="shortcut icon" href="/assets/images/logo/short-logo.svg"> -->
    <!-- <link rel="apple-touch-icon-precomposed" href="/assets/images/logo/short-logo.svg"> -->

</head>

<body>

    <!-- Scroll Top -->
    <button id="goTop">
        <span class="border-progress"></span>
        <span class="icon icon-arrow-right-2"></span>
    </button>

    <!-- preload -->
    <div class="preload preload-container" id="preload">
        <div class="preload-logo">
            <div class="spinner"></div>
        </div>
    </div>
    <!-- /preload -->

    <div id="wrapper">
        <!-- Top Bar-->
        <div class="tf-topbar p-0 style-2">
            <div class="topbar-botom bg-primary d-none d-xl-block">
                <div class="container-3">
                    <div class="row align-items-center">
                        <div class="col-3">
                            <ul class="box-action justify-content-start">
                                <li>
                                    <i class="icon-phone text-white"></i>
                                    <a href="tel:<?php print preg_replace('/[^\d\+]/im', '', $telephone); ?>" class="text-caption text-white link-secondary"><?php print $telephone; ?></a>
                                </li>
                                <li class="br-line bg-white"></li>
                                <li>
                                    <i class="icon-location text-white"></i>
                                    <a href="<?php print $url->link('information/information', 'information_id=7'); ?>" class="text-caption text-white link-secondary">Наши магазины</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col">
                            <div class="countdown-V01 text-xs text-white text-right">
                                <span>Получите 30% скидки и бесплатную доставку. До конца акции </span>
                                <div class="count-down">
                                    <div class="js-countdown" data-timer="993299" data-labels="d : ,h : ,m : , s">
                                    </div>
                                </div>
                                <span>-</span>
                                <a href="/catalog/" class="tf-btn-line style-white-2 lh-20"><span class="text-xs">В КАТАЛОГ</span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /Top Bar -->
        <!-- Header -->
        <?php ob_start(); ?>
          <li class="menu-item">
              <a href="/catalog/" class="item-link">
                  Каталог
              </a>
          </li>

          <?php foreach ($categories as $category) { ?>
            <li class="menu-item position-relative">
                <?php if (sizeof($category['children']) > 0) { ?>
                  <a href="javascript:void(0)" class="item-link">
                    <?php print $category['name']; ?>
                    <i class="icon icon-arrow-angle-down"></i>
                  </a>
                <?php } else { ?>
                  <a href="<?php print $category['href']; ?>" class="item-link">
                    <?php print $category['name']; ?>
                  </a>
                <?php } ?>

                <?php if (sizeof($category['children']) > 0) { ?>
                  <div class="sub-menu">
                      <div class="mega-menu-item">
                          <p class="text-caption menu-heading"><?php print $category['name']; ?></p>
                          <ul class="menu-list">
                              <?php foreach ($category['children'] as $child) { ?>
                                  <li><a href="<?php print $child['href']; ?>" class="menu-link-text link"><?php print $child['name']; ?></a></li>
                              <?php } ?>
                          </ul>
                      </div>
                  </div>
                <?php } ?>
            </li>
          <?php } ?>
        <?php $menu = ob_get_clean(); ?>

        <?php if ($is_main) { ?>
          <header class="tf-header header-absolute-2 type-2">
              <div class="container-3">
                  <div class="row align-items-center">
                      <div class="col-md-4 col-3 d-xl-none">
                          <a href="#mobileMenu" data-bs-toggle="offcanvas" class="btn-mobile-menu">
                              <span></span>
                          </a>
                      </div>
                      <div class="col-xl-5 d-none d-xl-block">
                          <nav class="box-navigation">
                              <ul class="box-nav-menu justify-content-start">
                                  <?php print $menu; ?>
                              </ul>
                          </nav>
                      </div>
                      <div class="col-xl-2 col-md-4 col-6">
                          <div class="logo-site justify-content-center w-100">
                              <svg width="129" height="46" viewBox="0 0 129 46" fill="none" xmlns="http://www.w3.org/2000/svg" style="vertical-align:middle;display:block;max-height:32px;width:auto;">
                                  <path d="M13.0408 1.04756C12.5379 1.00503 7.52437 1.19384 4.9528 1.04756C2.38123 0.901285 2.6135 1.77792 3.91587 1.77377C5.76886 1.76858 6.45945 2.55288 6.71557 3.74489C6.9157 4.67444 6.70002 18.8199 6.81926 24.3898C7.08471 36.8038 5.63095 40.3134 1.21987 43.7899C0.393443 44.4414 0.428699 44.6717 0.597717 44.7236C0.864207 44.8055 1.83062 44.3304 3.08634 43.4786C6.81719 40.9483 9.90308 37.5175 10.3448 32.7931C10.6196 29.8468 10.5003 7.52427 10.5522 5.30105C10.632 1.85158 10.9721 2.002 12.9371 1.77377C14.282 1.61712 13.5437 1.0901 13.0408 1.04756ZM44.2522 28.0209C43.9246 27.9638 43.8737 28.496 43.7338 29.3695C43.3543 31.7442 41.3675 32.2661 40.0008 32.2744C39.5384 32.2775 37.0705 32.3439 35.4384 32.2744C33.3739 32.1862 32.844 30.6062 32.8461 29.6808C32.8471 28.9961 32.8523 19.1798 32.8461 17.3353C37.3836 17.3363 38.039 17.327 40.0008 17.6465C41.5417 17.8976 41.6558 19.0782 41.6599 20.0326C41.6641 20.9871 42.0301 20.8729 42.2821 20.7588C42.534 20.6447 42.4542 19.2027 42.4895 18.3727C42.5268 17.4982 42.843 15.0747 42.9042 14.638C42.9654 14.2043 42.616 14.3247 42.0747 14.8454C41.3986 15.4959 40.7723 15.5509 40.0008 15.5716C39.3704 15.5882 34.4014 15.5831 32.8461 15.5716C32.8253 15.4005 32.8305 6.11958 32.8461 2.91495C33.1955 2.89005 35.5576 2.9108 37.3048 2.91495C40.1854 2.92117 41.7512 3.11206 42.1784 4.88607C42.3526 5.61124 42.055 6.59162 42.5931 6.54597C43.1313 6.50032 43.0204 5.97434 43.1116 5.30105C43.2029 4.62775 43.319 2.3983 43.5264 1.46254C43.7338 0.526771 43.5077 0.626365 43.2153 0.736333C42.9229 0.846301 42.0685 1.15442 41.4525 1.15131C40.8366 1.14819 27.0476 0.985318 25.795 1.04756C25.2226 1.07557 25.1739 1.4781 25.3802 1.67002C25.542 1.82149 25.8582 1.77584 26.2097 1.77377C28.3458 1.76339 28.9317 2.69086 29.0094 4.57484C29.0364 5.23673 29.0011 26.7759 29.0094 28.3321C29.0374 33.3969 27.9507 33.2029 26.6245 33.3118C25.9329 33.3688 25.9972 33.4767 26.0024 33.623C26.0169 34.0172 26.1952 34.1106 27.9725 34.038C30.5897 33.9311 40.5514 34.1583 42.8005 34.1417C44.2999 34.1314 44.2429 32.5036 44.5633 29.7845C44.7344 28.3269 44.6214 28.0852 44.2522 28.0209ZM72.4566 1.04756C71.2579 0.991542 59.2648 1.2924 57.2138 1.04756C56.6725 0.983243 56.0462 1.17102 56.1769 1.46254C56.3749 1.90552 56.6124 1.79555 57.9396 1.87751C59.8175 1.9937 59.8268 3.16912 59.9098 5.71602C59.9834 7.96622 59.8258 22.5837 59.9098 25.2198C60.1441 32.5482 59.3633 33.3419 57.3175 33.3118C56.5667 33.3014 56.7949 33.5815 56.799 33.7268C56.8052 33.9363 56.9784 34.1002 58.3544 34.038C60.6595 33.9342 61.9847 33.9674 65.8202 34.1417C71.3045 34.3918 76.7505 35.0868 82.3893 31.3064C85.2999 29.3561 89.7359 24.3266 89.3584 16.2979C88.8721 5.9567 80.2978 1.41378 72.4566 1.04756ZM72.0418 32.7931C67.9387 33.0618 65.0757 32.1872 64.5365 31.4932C63.4571 30.104 63.7702 27.2926 63.7464 25.531C63.7215 23.7695 63.7288 7.95999 63.7464 5.71602C63.7702 2.61098 63.2041 2.73858 67.4793 2.60372C78.3722 2.26032 85.0179 8.67582 85.3144 17.7503C85.5985 26.4543 81.4643 32.1748 72.0418 32.7931ZM128.347 33.5193C128.264 33.291 127.645 33.3616 126.999 33.3118C125.976 33.2329 124.426 32.2661 123.473 30.407C121.861 27.2604 113.964 6.17249 112.378 1.98125C111.369 -0.683915 110.967 0.675124 110.201 2.70746C109.666 4.12771 101.481 26.2832 100.765 28.5396C99.1999 33.4653 97.4122 33.3087 95.8911 33.3118C95.1476 33.3139 95.1621 33.3771 95.1652 33.623C95.1714 34.0338 95.301 34.0328 95.8911 34.038C96.3877 34.0421 103.624 34.0442 104.394 34.038C105.163 34.0318 105.118 33.9156 105.12 33.623C105.122 33.3305 104.807 33.3346 103.875 33.3118C102.183 33.2703 102.594 31.238 102.942 29.992C103.208 29.0427 105.176 23.5226 105.534 22.315C105.893 21.1074 105.91 21.1707 106.26 21.1738C106.611 21.1769 112.363 21.1603 114.659 21.1738C115.805 21.18 115.767 21.1468 115.904 21.485C116.166 22.1334 119.101 29.8883 119.637 31.3407C120.217 32.9144 119.97 33.0296 119.637 33.208C119.301 33.3875 119.158 33.9944 119.844 33.9342C120.53 33.8741 125.945 34.0587 127.31 34.038C128.349 34.0224 128.496 33.9301 128.347 33.5193ZM106.468 19.5139C106.468 19.5139 110.199 8.06892 110.304 7.68715C110.41 7.30537 110.568 6.20569 111.134 7.99838C111.7 9.79106 115.178 19.5139 115.178 19.5139H106.468Z" fill="#FCCB00" stroke="#FCCB00" stroke-miterlimit="10"/>
                              </svg>
                          </div>
                      </div>
                      <div class="col-xl-5 col-md-4 col-3">
                          <div class="header-right justify-content-end align-items-center">
                              <form class="form-search style-radius style-white d-none d-xl-block" action="/search/">
                                  <fieldset>
                                      <input type="text" placeholder="Поиск по каталогу" class="bg-transparent" name="search" tabindex="0" value=""
                                          aria-required="true" required>
                                  </fieldset>
                                  <button type="submit" class="link"><i class="icon icon-search"></i></button>
                              </form>
                              <ul class="nav-icon">
                                  <li class="d-inline-flex d-xl-none">
                                      <a href="#search" data-bs-toggle="offcanvas" class="nav-icon-item text-black link">
                                          <i class="icon icon-search"></i>
                                      </a>
                                  </li>
                                  <!-- <li class="d-none d-md-inline-flex">
                                      <a href="#log" data-bs-toggle="modal" class="nav-icon-item text-black link">
                                          <i class="icon icon-user"></i>
                                      </a>
                                  </li> -->
                                  <li class="d-none d-md-inline-flex">
                                      <a href="/wishlist/" class="nav-icon-item text-black link">
                                          <i class="icon icon-hearth"></i>
                                      </a>
                                  </li>
                                  <li class="d-inline-flex">
                                      <a href="#shoppingCart" data-bs-toggle="offcanvas" class="nav-icon-item text-black link">
                                          <i class="icon icon-cart"></i>
                                          <span class="count-notice"<?php if ($count_products == 0) { print ' style="display:none"'; } ?>></span>
                                      </a>
                                  </li>
                              </ul>
                          </div>
                      </div>
                  </div>
              </div>
          </header>
        <?php } else { ?>
          <header class="tf-header">
              <div class="container">
                  <div class="row align-items-center">
                      <div class="col-md-4 col-3 d-xl-none">
                          <a href="#mobileMenu" data-bs-toggle="offcanvas" class="btn-mobile-menu">
                              <span></span>
                          </a>
                      </div>
                      <div class="col-xl-2 col-md-4 col-6">
                          <a href="/" class="logo-site">
                              <svg width="129" height="46" viewBox="0 0 129 46" fill="none" xmlns="http://www.w3.org/2000/svg" style="vertical-align:middle;display:block;max-height:32px;width:auto;"><path d="M13.0406 1.04756C12.5377 1.00503 7.52413 1.19384 4.95255 1.04756C2.38098 0.901285 2.61325 1.77792 3.91563 1.77377C5.76861 1.76858 6.45921 2.55288 6.71533 3.74489C6.91545 4.67444 6.69977 18.8199 6.81902 24.3898C7.08447 36.8038 5.6307 40.3134 1.21963 43.7899C0.393199 44.4414 0.428454 44.6717 0.597473 44.7236C0.863963 44.8055 1.83038 44.3304 3.08609 43.4786C6.81694 40.9483 9.90283 37.5175 10.3446 32.7931C10.6193 29.8468 10.5001 7.52427 10.5519 5.30105C10.6318 1.85158 10.9719 2.002 12.9369 1.77377C14.2818 1.61712 13.5435 1.0901 13.0406 1.04756ZM44.252 28.0209C43.9243 27.9638 43.8735 28.496 43.7335 29.3695C43.354 31.7442 41.3673 32.2661 40.0006 32.2744C39.5381 32.2775 37.0702 32.3439 35.4381 32.2744C33.3736 32.1862 32.8437 30.6062 32.8458 29.6808C32.8469 28.9961 32.852 19.1798 32.8458 17.3353C37.3834 17.3363 38.0387 17.327 40.0006 17.6465C41.5415 17.8976 41.6555 19.0782 41.6597 20.0326C41.6638 20.9871 42.0299 20.8729 42.2818 20.7588C42.5338 20.6447 42.454 19.2027 42.4892 18.3727C42.5265 17.4982 42.8428 15.0747 42.904 14.638C42.9652 14.2043 42.6157 14.3247 42.0744 14.8454C41.3984 15.4959 40.7721 15.5509 40.0006 15.5716C39.3701 15.5882 34.4012 15.5831 32.8458 15.5716C32.8251 15.4005 32.8303 6.11958 32.8458 2.91495C33.1953 2.89005 35.5574 2.9108 37.3046 2.91495C40.1852 2.92117 41.7509 3.11206 42.1781 4.88607C42.3523 5.61124 42.0547 6.59162 42.5929 6.54597C43.1311 6.50032 43.0201 5.97434 43.1114 5.30105C43.2026 4.62775 43.3188 2.3983 43.5261 1.46254C43.7335 0.526771 43.5075 0.626365 43.2151 0.736333C42.9226 0.846301 42.0682 1.15442 41.4523 1.15131C40.8364 1.14819 27.0473 0.985318 25.7947 1.04756C25.2223 1.07557 25.1736 1.4781 25.38 1.67002C25.5417 1.82149 25.858 1.77584 26.2095 1.77377C28.3456 1.76339 28.9314 2.69086 29.0092 4.57484C29.0362 5.23673 29.0009 26.7759 29.0092 28.3321C29.0372 33.3969 27.9505 33.2029 26.6243 33.3118C25.9326 33.3688 25.9969 33.4767 26.0021 33.623C26.0166 34.0172 26.195 34.1106 27.9723 34.038C30.5895 33.9311 40.5512 34.1583 42.8003 34.1417C44.2997 34.1314 44.2426 32.5036 44.5631 29.7845C44.7342 28.3269 44.6211 28.0852 44.252 28.0209ZM72.4563 1.04756C71.2576 0.991542 59.2646 1.2924 57.2135 1.04756C56.6723 0.983243 56.046 1.17102 56.1766 1.46254C56.3747 1.90552 56.6121 1.79555 57.9394 1.87751C59.8172 1.9937 59.8266 3.16912 59.9095 5.71602C59.9832 7.96622 59.8255 22.5837 59.9095 25.2198C60.1439 32.5482 59.3631 33.3419 57.3172 33.3118C56.5665 33.3014 56.7946 33.5815 56.7988 33.7268C56.805 33.9363 56.9781 34.1002 58.3541 34.038C60.6592 33.9342 61.9844 33.9674 65.82 34.1417C71.3043 34.3918 76.7502 35.0868 82.389 31.3064C85.2997 29.3561 89.7356 24.3266 89.3582 16.2979C88.8719 5.9567 80.2975 1.41378 72.4563 1.04756ZM72.0415 32.7931C67.9384 33.0618 65.0755 32.1872 64.5363 31.4932C63.4569 30.104 63.77 27.2926 63.7462 25.531C63.7213 23.7695 63.7285 7.95999 63.7462 5.71602C63.77 2.61098 63.2038 2.73858 67.4791 2.60372C78.372 2.26032 85.0176 8.67582 85.3142 17.7503C85.5983 26.4543 81.4641 32.1748 72.0415 32.7931ZM128.347 33.5193C128.264 33.291 127.645 33.3616 126.999 33.3118C125.976 33.2329 124.426 32.2661 123.473 30.407C121.861 27.2604 113.963 6.17249 112.378 1.98125C111.369 -0.683915 110.967 0.675124 110.2 2.70746C109.665 4.12771 101.481 26.2832 100.764 28.5396C99.1996 33.4653 97.412 33.3087 95.8908 33.3118C95.1473 33.3139 95.1618 33.3771 95.165 33.623C95.1712 34.0338 95.3008 34.0328 95.8908 34.038C96.3875 34.0421 103.624 34.0442 104.394 34.038C105.163 34.0318 105.117 33.9156 105.119 33.623C105.122 33.3305 104.806 33.3346 103.875 33.3118C102.183 33.2703 102.593 31.238 102.942 29.992C103.207 29.0427 105.175 23.5226 105.534 22.315C105.893 21.1074 105.91 21.1707 106.26 21.1738C106.611 21.1769 112.362 21.1603 114.659 21.1738C115.805 21.18 115.767 21.1468 115.903 21.485C116.166 22.1334 119.1 29.8883 119.636 31.3407C120.217 32.9144 119.97 33.0296 119.636 33.208C119.3 33.3875 119.157 33.9944 119.844 33.9342C120.53 33.8741 125.945 34.0587 127.31 34.038C128.349 34.0224 128.496 33.9301 128.347 33.5193ZM106.467 19.5139C106.467 19.5139 110.198 8.06892 110.304 7.68715C110.41 7.30537 110.567 6.20569 111.134 7.99838C111.7 9.79106 115.178 19.5139 115.178 19.5139H106.467Z" fill="black" stroke="black" stroke-miterlimit="10"/></svg>
                          </a>
                      </div>
                      <div class="col-xl-8 d-none d-xl-block">
                          <nav class="box-navigation">
                              <ul class="box-nav-menu">
                                  <?php print $menu; ?>
                              </ul>
                          </nav>
                      </div>
                      <div class="col-xl-2 col-md-4 col-3">
                          <ul class="nav-icon">
                              <li class="d-inline-flex">
                                  <a href="#search" data-bs-toggle="offcanvas" class="nav-icon-item text-black link">
                                      <i class="icon icon-search"></i>
                                  </a>
                              </li>
                              <li class="br-line d-none d-xl-flex"></li>
                              <!--<li class="d-none d-md-inline-flex">
                                  <a href="#log" data-bs-toggle="modal" class="nav-icon-item text-black link">
                                      <i class="icon icon-user"></i>
                                  </a>
                              </li>-->
                              <li class="d-none d-md-inline-flex">
                                  <a href="/wishlist/" class="nav-icon-item text-black link">
                                      <i class="icon icon-hearth"></i>
                                  </a>
                              </li>
                              <li class="d-inline-flex">
                                  <a href="#shoppingCart" data-bs-toggle="offcanvas" class="nav-icon-item text-black link">
                                      <i class="icon icon-cart"></i>                                      
                                      <span class="count-notice"<?php if ($count_products == 0) { print ' style="display:none"'; } ?>></span>
                                  </a>
                              </li>
                          </ul>
                      </div>
                  </div>
              </div>
          </header>
          <?php } ?>
        <!-- /Header -->



        