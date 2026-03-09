<!-- Footer -->
        <footer class="tf-footer">
            <div class="footer-top"><!--  border-top-0 -->
                <div class="container">
                    <ul class="category-list justify-content-xl-center">
                        <li>
                            <a href="/catalog/" class="tf-btn btn-line has-icon link">
                                <span class="text h6 text-uppercase fw-normal mb-0">Каталог</span>
                            </a>
                        </li>
                        <?php foreach ($categories as $category) { ?>
                            <li>
                                <a href="<?php print $category['href']; ?>" class="tf-btn btn-line has-icon link">
                                    <span class="text h6 text-uppercase fw-normal mb-0"><?php print $category['name']; ?></span>
                                </a>
                            </li>
                        <?php } ?>
                    </ul>
                </div>
            </div>
            <div class="footer-body p-xl-0">
                <div class="container">
                    <div class="row-footer">
                        <div class="col-s1">
                            <div class="footer-inner-wrap flex-lg-nowrap align-items-end">
                                <div class="box-title">
                                    <h6>Присоединяйтесь к клубу JEDA</h6>
                                    <p class="notice font-2">
                                        Блестящие вещи ждут<br/>
                                        вас — внутри скидка 10%!
                                    </p>
                                </div>
                                <div class="box-email">
                                    <p class="text-body text-main-3">Получите ранний доступ к новым товарам, эксклюзивным предложениям и не только.</p>
                                    <div class="jeda-form form-email">
                                        <div id="jeda-form-container" class="jeda-form-container">
                                            <div id="error-message" class="jeda-form-message-panel d-none">
                                                <div class="jeda-form-message-panel__text jeda-form-message-panel__text--center">
                                                    <span class="jeda-form-message-panel__inner-text">Your subscription could not be saved. Please try again.
                                                    </span>
                                                </div>
                                            </div>
                                            <div id="success-message" class="jeda-form-message-panel d-none">
                                                <div class="jeda-form-message-panel__text jeda-form-message-panel__text--center">
                                                    <span class="jeda-form-message-panel__inner-text">Your subscription has been successful.
                                                    </span>
                                                </div>
                                            </div>
                                            <div id="sib-container" class="sib-container--large sib-container--vertical">
                                                <form id="jeda-form" method="POST" class="form-newsletter" data-type="subscription">
                                                    <div>
                                                        <div class="sib-input jeda-form-block mb-0">
                                                            <div class="form__entry entry_block">
                                                                <div class="form__label-row mb-0">
                                                                    <div class="entry__field">
                                                                        <input class="input" type="text" id="EMAIL" name="EMAIL" autocomplete="off"
                                                                            placeholder="your_email@example.com" data-required="true"
                                                                            required />
                                                                    </div>

                                                                    <button
                                                                        class="jeda-form-block__button jeda-form-block__button-with-loader subscribe-button btn-submit link"
                                                                        form="jeda-form" type="submit">
                                                                        <svg class="icon clickable__icon progress-indicator__icon sib-hide-loader-icon"
                                                                            viewBox="0 0 512 512">
                                                                            <path
                                                                                d="M460.116 373.846l-20.823-12.022c-5.541-3.199-7.54-10.159-4.663-15.874 30.137-59.886 28.343-131.652-5.386-189.946-33.641-58.394-94.896-95.833-161.827-99.676C261.028 55.961 256 50.751 256 44.352V20.309c0-6.904 5.808-12.337 12.703-11.982 83.556 4.306 160.163 50.864 202.11 123.677 42.063 72.696 44.079 162.316 6.031 236.832-3.14 6.148-10.75 8.461-16.728 5.01z">
                                                                            </path>
                                                                        </svg>
                                                                        <span class="icon-arrow-right-2"></span>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <div class="sib-optin jeda-form-block">
                                                            <div class="form__entry entry_mcq">
                                                                <div class="form__label-row mb-0">
                                                                    <div class="entry__choice">
                                                                        <label>
                                                                            <input type="checkbox" class="input_replaced" value="1" id="OPT_IN" name="OPT_IN" />
                                                                            <span class="checkbox checkbox_tick_positive"></span>
                                                                            <span>
                                                                                <p></p>
                                                                            </span>
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <label class="entry__error entry__error--primary"></label>
                                                                <label class="entry__specification"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-s2">
                            <div class="footer-inner-wrap flex-sm-nowrap s2">
                                <div class="footer-col-block">
                                    <p class="footer-heading footer-heading-mobile font-2">
                                        Мы находимся
                                    </p>
                                    <div class="tf-collapse-content">
                                        <ul class="footer-menu-list mb-24">
                                            <li>
                                                <p class="text-main-4">Найдите магазин поблизости</p>
                                            </li>
                                            <li><a href="<?php print $url->link('information/information', 'information_id=7'); ?>" class="text-main-4 link text-decoration-underline">Посмотреть все магазины</a></li>
                                            <li><a href="tel:<?php print preg_replace('/[^\d\+]/im', '', $telephone); ?>" class="text-main-4 link"><?php print $telephone; ?></a></li>
                                            <li><a href="mailto:<?php print $email; ?>" class="text-main-4 link"><?php print $email; ?></a></li>
                                        </ul>
                                        <ul class="tf-social-icon">
                                            <li>
                                                <a href="#" target="_blank" class="social-vk">
                                                    <span class="icon">
                                                        <svg width="20" height="13" viewBox="0 0 20 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M10.8864 12.33C4.20957 12.33 0.159061 7.69781 0 0H3.3819C3.48732 5.65499 6.05911 8.05107 8.03165 8.54398V0H11.2721V4.88003C13.1743 4.66918 15.1654 2.44972 15.8349 0H19.0254C18.514 3.01199 16.3463 5.23144 14.8149 6.14697C16.3481 6.88771 18.8136 8.82511 19.7652 12.33H16.2594C15.5195 9.98755 13.7051 8.17314 11.2739 7.92623V12.33H10.8864Z" fill="black"/>
                                                        </svg>
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" target="_blank" class="social-tg">
                                                    <span class="icon">
                                                        <svg width="16" height="13" viewBox="0 0 16 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M6.2683 8.57932L6.01796 12.2125C6.38579 12.2125 6.54832 12.0496 6.75363 11.8562L8.52091 10.1915L12.1976 12.8229C12.8742 13.1846 13.3626 12.9973 13.5311 12.2144L15.9448 1.19634C16.1919 0.236608 15.5671 -0.198683 14.9198 0.0859995L0.747056 5.37997C-0.220367 5.75586 -0.214727 6.2787 0.570715 6.51167L4.20776 7.61133L12.6279 2.46536C13.0254 2.23186 13.3902 2.35739 13.0908 2.61483L6.26809 8.57917L6.2683 8.57932Z" fill="black"/>
                                                        </svg>
                                                    </span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="footer-col-block p-xl-0">
                                    <p class="footer-heading footer-heading-mobile font-2">
                                        помощь
                                    </p>
                                    <div class="tf-collapse-content">
                                        <ul class="footer-menu-list">
                                            <li><a href="<?php print $url->link('information/information', 'information_id=6'); ?>" class="text-main-4 link">Доставка</a></li>
                                            <li><a href="<?php print $url->link('information/information', 'information_id=5'); ?>" class="text-main-4 link">Возвраты</a></li>
                                            <li><a href="<?php print $url->link('information/information', 'information_id=3'); ?>" class="text-main-4 link">Политика конфиденциальности</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="footer-col-block">
                                    <p class="footer-heading footer-heading-mobile font-2">
                                        о нас
                                    </p>
                                    <div class="tf-collapse-content">
                                        <ul class="footer-menu-list">
                                            <li><a href="<?php print $url->link('information/information', 'information_id=7'); ?>" class="text-main-4 link">Наши магазины</a></li>
                                            <li><a href="<?php print $url->link('information/information', 'information_id=8'); ?>" class="text-main-4 link">Свяжитесь с нами</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="container">
                    <div class="footer-bottom-wrap">
                        <p class="text-nocopy">
                            Все права защищены, 2025 JEDA
                        </p>
                        <ul class="paymend-method-list">
                            <li>
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M13.4705 7.70605H10.5881V11.7649H13.4705C14.1175 11.7649 14.647 11.5884 14.9999 11.2355C15.4117 10.8825 15.5881 10.3531 15.5881 9.76488C15.5881 9.17664 15.4117 8.70605 14.9999 8.29429C14.647 7.94135 14.1175 7.70605 13.4705 7.70605Z" fill="#4FAD50"/>
                                    <path d="M12 0C5.35293 0 0 5.35293 0 12C0 18.647 5.35293 24 12 24C18.647 24 24 18.647 24 12C23.9412 5.35293 18.5882 0 12 0ZM16.5882 12.5882C15.8235 13.2941 14.8235 13.7059 13.6471 13.7059H10.5882V14.7647H15.1176C15.1765 14.7647 15.2941 14.7647 15.3529 14.8235C15.4118 14.8824 15.4118 14.9412 15.4118 15.0588V16.2353C15.4118 16.2941 15.4118 16.4118 15.3529 16.4706C15.2941 16.5294 15.2353 16.5294 15.1176 16.5294H10.5882V18.2353C10.5882 18.2941 10.5882 18.4118 10.5294 18.4706C10.4706 18.5294 10.4118 18.5294 10.3529 18.5294H8.82353C8.7647 18.5294 8.64706 18.5294 8.58823 18.4706C8.52941 18.4118 8.52941 18.3529 8.52941 18.2353V16.5294H6.52941C6.47059 16.5294 6.35295 16.5294 6.29412 16.4706C6.2353 16.4118 6.23529 16.3529 6.23529 16.2353V15.0588C6.23529 15 6.2353 14.8824 6.29412 14.8235C6.35295 14.7647 6.41177 14.7647 6.52941 14.7647H8.52941V13.7059H6.52941C6.47059 13.7059 6.35295 13.7059 6.29412 13.6471C6.2353 13.5882 6.23529 13.5294 6.23529 13.4118V12.0588C6.23529 12 6.2353 11.9412 6.29412 11.8824C6.35295 11.8235 6.41177 11.8235 6.52941 11.8235H8.52941V6.17647C8.52941 6.11764 8.52941 6 8.58823 5.94118C8.64706 5.88235 8.70588 5.88235 8.82353 5.88235H13.7059C14.8824 5.88235 15.8824 6.2353 16.6471 7C17.4118 7.70588 17.7647 8.70589 17.7647 9.82353C17.7647 10.8824 17.3529 11.8235 16.5882 12.5882Z" fill="#4FAD50"/>
                                </svg>
                            </li>
                            <li>
                                <svg width="43" height="24" viewBox="0 0 43 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="0.5" y="0.5" width="41.057" height="23" rx="1.5" stroke="#111111" stroke-opacity="0.15"/>
                                    <path d="M32.3047 8.11426H30.6666C30.1713 8.11426 29.7904 8.26664 29.5618 8.76188L26.438 15.8857H28.6475C28.6475 15.8857 29.0285 14.9333 29.1047 14.7047C29.3332 14.7047 31.5047 14.7047 31.8094 14.7047C31.8856 14.9714 32.0761 15.8476 32.0761 15.8476H34.057L32.3047 8.11426ZM29.7142 13.1047C29.9047 12.6476 30.5523 10.9333 30.5523 10.9333C30.5523 10.9714 30.7428 10.4762 30.8189 10.2095L30.9713 10.8952C30.9713 10.8952 31.3904 12.7619 31.4666 13.1428H29.7142V13.1047Z" fill="#3362AB"/>
                                    <path d="M26.5904 13.3333C26.5904 14.9333 25.1427 16 22.8951 16C21.9427 16 21.0284 15.8095 20.5332 15.581L20.838 13.8286L21.1046 13.9429C21.7903 14.2476 22.2475 14.3619 23.0856 14.3619C23.6951 14.3619 24.3427 14.1333 24.3427 13.6C24.3427 13.2571 24.0761 13.0286 23.238 12.6476C22.438 12.2667 21.3713 11.6571 21.3713 10.5524C21.3713 9.02857 22.857 8 24.9523 8C25.7523 8 26.438 8.15238 26.857 8.34286L26.5523 10.019L26.3999 9.86667C26.0189 9.71429 25.5237 9.5619 24.7999 9.5619C23.9999 9.6 23.6189 9.94286 23.6189 10.2476C23.6189 10.5905 24.0761 10.8571 24.7999 11.2C26.0189 11.7714 26.5904 12.419 26.5904 13.3333Z" fill="#3362AB"/>
                                    <path d="M8 8.19047L8.0381 8.03809H11.3143C11.7714 8.03809 12.1143 8.19047 12.2286 8.6857L12.9524 12.1143C12.2286 10.2857 10.5524 8.79999 8 8.19047Z" fill="#F9B50B"/>
                                    <path d="M17.5619 8.11427L14.2476 15.8476H12L10.0952 9.37141C11.4666 10.2476 12.6095 11.619 13.0286 12.5714L13.2571 13.3714L15.3143 8.07617H17.5619V8.11427Z" fill="#3362AB"/>
                                    <path d="M18.4381 8.07617H20.5333L19.2 15.8476H17.1047L18.4381 8.07617Z" fill="#3362AB"/>
                                </svg>
                            </li>
                            <li>
                                <svg width="44" height="24" viewBox="0 0 44 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="0.5" y="0.5" width="42.6135" height="23.0003" rx="1.5" stroke="#111111" stroke-opacity="0.15"/>
                                    <path d="M32.7748 8H27.4585C27.7682 9.75471 29.4715 11.4062 31.3296 11.4062H35.5619C35.6136 11.2514 35.6135 10.9933 35.6135 10.8385C35.6135 9.29023 34.3232 8 32.7748 8Z" fill="url(#paint0_linear_3973_10954)"/>
                                    <path d="M27.9233 11.7178V16.0013H30.5041V13.7305H32.7751C34.0138 13.7305 35.0977 12.8532 35.459 11.7178H27.9233Z" fill="#4FAD50"/>
                                    <path d="M18.8389 8V15.9478H21.1099C21.1099 15.9478 21.6777 15.9478 21.9873 15.3801C23.5358 12.3352 24.0003 11.4062 24.0003 11.4062H24.31V15.9478H26.8907V8H24.6197C24.6197 8 24.0519 8.05161 23.7422 8.5677C22.4519 11.1998 21.7293 12.5416 21.7293 12.5416H21.4196V8H18.8389Z" fill="#4FAD50"/>
                                    <path d="M8 15.9966V8.04883H10.5807C10.5807 8.04883 11.3033 8.04883 11.7162 9.18423C12.7485 12.1776 12.8518 12.5904 12.8518 12.5904C12.8518 12.5904 13.0582 11.8679 13.9873 9.18423C14.4002 8.04883 15.1228 8.04883 15.1228 8.04883H17.7035V15.9966H15.1228V11.7131H14.8131L13.3679 15.9966H12.2324L10.7872 11.7131H10.4775V15.9966H8Z" fill="#4FAD50"/>
                                    <defs>
                                    <linearGradient id="paint0_linear_3973_10954" x1="27.4493" y1="9.72751" x2="35.5953" y2="9.72751" gradientUnits="userSpaceOnUse">
                                    <stop stop-color="#27B1E6"/>
                                    <stop offset="1" stop-color="#148ACA"/>
                                    </linearGradient>
                                    </defs>
                                </svg>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
        <!-- /Footer -->

        <div class="overlay-filter" id="overlay-filter"></div>
    </div>
    <!-- Shopping Cart -->
    <div class="offcanvas offcanvas-end popup-shopping-cart" id="shoppingCart">
        <?php print $popup_cart; ?>
    </div>
    <!-- /Shopping Cart -->

    <!-- Search -->
    <div class="offcanvas offcanvas-top offcanvas-search" id="search">
        <div class="offcanvas-content">
            <div class="container">
                <div class="popup-content">
                    <form class="form-search" action="/search/">
                        <fieldset>
                            <input type="text" placeholder="Поиск по каталогу" class="" name="search" tabindex="0" value="" aria-required="true"
                                required="">
                        </fieldset>
                        <button type="submit" class="link"><i class="icon icon-search"></i></button>
                        <span class="icon-close-popup" data-bs-dismiss="offcanvas">
                            <i class="icon-close"></i>
                        </span>
                    </form>
                </div>
            </div>
        </div>
        <span class="close" data-bs-dismiss="offcanvas"></span>
    </div>
    <!-- /Search -->

    <!-- Mobile Menu -->
    <div class="offcanvas offcanvas-start canvas-mb" id="mobileMenu">
        <span class="icon-close-popup" data-bs-dismiss="offcanvas">
            <i class="icon-close"></i>
        </span>
        <div class="mb-canvas-content">
            <div class="mb-body">
                <div class="mb-content-top">
                    <form class="form-search" action="/search/">
                        <fieldset>
                            <input type="text" placeholder="Поиск по каталогу" class="" name="search" tabindex="0" value="" aria-required="true"
                                required="">
                        </fieldset>
                        <button type="submit" class="link"><i class="icon icon-search"></i></button>
                    </form>
                    <ul class="nav-ul-mb" id="wrapper-menu-navigation">
                        <li class="nav-mb-item">
                            <a href="/" class="mb-menu-link">Главная</a>
                        </li>
                        <?php foreach ($categories as $ci => $category) { ?>
                        	<li class="nav-mb-item">
	                            <a href="#dropdown-footer-menu-<?php print $ci; ?>" class="collapsed mb-menu-link" data-bs-toggle="collapse" aria-expanded="true"
	                                aria-controls="dropdown-footer-menu-<?php print $ci; ?>">
	                                <span><?php print $category['name']; ?></span>
	                                <span class="btn-open-sub"></span>
	                            </a>
	                            <?php if (sizeof($category['children']) > 0) { ?>
		                            <div id="dropdown-footer-menu-<?php print $ci; ?>" class="collapse">
		                                <ul class="sub-nav-menu">
		                                	<?php foreach ($category['children'] as $child) { ?>
			                                    <li><a href="<?php print $child['href']; ?>" class="sub-nav-link"><?php print $child['name']; ?></a></li>
			                                <?php } ?>
		                                </ul>
		                            </div>
		                        <?php } ?>
	                        </li>
                        <?php } ?>
                    </ul>
                </div>
                <div class="mb-other-content">
                    <div class="group-icon">
                        <a href="/wishlist/" class="site-nav-icon">
                            <i class="icon icon-hearth"></i>
                            Избранное
                        </a>
                    </div>
                    <ul class="mb-info">
                        <li>
                            Электронная почта:
                            <a href="mailto:<?php print $email; ?>" class="fw-medium"><?php print $email; ?></a>
                        </li>
                        <li>
                            Телефон:
                            <a href="tel:<?php print preg_replace('/[^\d\+]/im', '', $telephone); ?>" class="fw-medium"><?php print $telephone; ?></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- /Mobile Menu -->
    <!-- Javascript -->
    <script src="/assets/js/bootstrap.min.js"></script>
    <script src="/assets/js/jquery.min.js"></script>
    <script src="/assets/js/swiper-bundle.min.js"></script>
    <script src="/assets/js/carousel.js"></script>
    <script src="/assets/js/bootstrap-select.min.js"></script>
    <script src="/assets/js/lazysize.min.js"></script>
    <script src="/assets/js/count-down.js"></script>
    <script src="/assets/js/wow.min.js"></script>
    <script src="/assets/js/infinityslide.js"></script>
    <script src="/assets/js/drift.min.js"></script>
    <script src="/assets/js/gsap.min.js"></script>
    <script src="/assets/js/ScrollTrigger.min.js"></script>
    <script src="/assets/js/SplitText.min.js"></script>
    <script src="/assets/js/main.js"></script>
    <script src="/assets/js/jedaforms.js" defer></script>
    <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>
    <script src="/assets/js/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript">
        $('input[type="tel"]').inputmask("+9 999 999-99-99");
    </script>
    <script src="/assets/js/common.js?><?php print rand(); ?>"></script>

    <?php print $inline_scripts; ?>
</body>

</html>