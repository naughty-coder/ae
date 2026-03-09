<?php print $header; ?>
    <!-- Page Title -->
    <section class="flat-spacing-2 pb-0">
        <div class="container">
            <div class="page-title type-2">
                <?php include(__DIR__ . '/../chunk/_breadcrumbs.tpl'); ?>

                <div class="box-text">
                    <p class="text-main-4">
                        Откройте для себя нашу коллекцию колец и найдите новое украшение для вашей шкатулки. От колец в виде короны, сердца и цветов с прозрачными кристаллами до простых бусин и колец — в нашей коллекции колец для женщин есть всё. Подчеркните свой стиль кольцом из стерлингового серебра, позолоты 14 карат, розовой позолоты 14 карат или настоящего золота 14 карат.
                    </p>
                </div>
            </div>
        </div>
    </section>
    <!-- /Page Title -->
    <!-- Category -->
    <?php if (sizeof($categories) > 1) { ?>
        <div class="flat-spacing-5">
            <div class="container-6">
                <div class="swiper tf-swiper" data-preview="5" data-tablet="4" data-mobile-sm="3" data-mobile="2" data-space-lg="30"
                    data-space-md="20" data-space="15" data-pagination="2" data-pagination-sm="3" data-pagination-md="4" data-pagination-lg="5">
                    <div class="swiper-wrapper">
                        <?php foreach ($categories as $category) { ?>
                            <div class="swiper-slide">
                                <div class="box_collection--V01 style_2 hover-img">
                                    <a href="<?php print $category['href']; ?>" class="image img-style">
                                        <img src="<?php print $category['image']; ?>" data-src="<?php print $category['image']; ?>" alt="" class=" lazyload">
                                    </a>
                                    <a href="<?php print $category['href']; ?>" class="name-cls link">
                                        <span class="h5 fw-normal text-uppercase">
                                            <?php print $category['name']; ?>
                                        </span>
                                    </a>
                                </div>
                            </div>
                        <?php } ?>
                    </div>
                    <div class="sw-dot-default d-flex d-xl-none tf-sw-pagination"></div>
                </div>
            </div>
        </div>
    <?php } else { ?>
        <div class="flat-spacing-2 pb-0"></div>
    <?php } ?>
    <!-- /Category -->
    <!-- Product -->
    <div class="flat-spacing pt-0">
        <span class="br-line cus-width d-block bg-line"></span>
        <div class="tf-shop-control style-2 mb_10 border-0">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col">
                        <div class="tf-control-filter justify-content-between pe-xxl-30">
                            <button class="tf-btn-filter h5 link mb-0">
                                <span class="icon icon-filter d-xl-none"></span>
                                <span class="text">ФИЛЬТР</span>
                            </button>
                            <button id="reset-filter" class="btn-check-none tf-btn-line">
                                <span class="text-body">Сбросить</span>
                            </button>
                        </div>
                    </div>
                    <div class="col">
                        <div class="tf-group-layout justify-content-end">
                            <div class="tf-dropdown-sort" data-bs-toggle="dropdown">
                                <div class="btn-select">
                                    <?php foreach ($sorts as $sort_item) { ?>
                                        <?php if ($sort_item['value'] == $sort . '-' . $order) { ?>
                                            <span class="text-sort-value"><?php print $sort_item['text']; ?></span>
                                        <?php } ?>
                                    <?php } ?>
                                    <span class="icon icon-arrow-angle-down"></span>
                                </div>
                                <div class="dropdown-menu">
                                    <?php foreach ($sorts as $sort_item) { ?>
                                        <div class="select-item" data-sort-value="<?php print $sort_item['value']; ?>" onclick="window.location='<?php print $sort_item['href']; ?>'">
                                            <span class="text-value-item"><?php print $sort_item['text']; ?></span>
                                        </div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-xl-3">
                    <?php print $column_left; ?>
                </div>
                <div class="col-xl-9">
                    <div class="wrapper-control-shop gridLayout-wrapper">
                        <div class="wrapper-shop tf-grid-layout tf-col-3" id="gridLayout">
                            <?php if (sizeof($products) > 0) { ?>
                                <?php foreach ($products as $product) { ?>
                                    <?php include(__DIR__ . '/../chunk/_product_item.tpl'); ?>
                                <?php } ?>
                            <?php } else { ?>
                                В категории пусто
                            <?php } ?>
                            
                            <?php /*
                            <div class="loadItem tempo wd-2-cols tempo box_image--V02 style-2 hover-img">
                                <a href="#" class="box_image-image img-style">
                                    <img src="/assets/images/collections/discover-2.jpg" data-src="/assets/images/collections/discover-2.jpg" alt=""
                                        class="lazyload">
                                </a>
                                <div class="box_image-content type-left">
                                    <div class="heading">
                                        <p class="fw-medium text-white text-uppercase">be love</p>
                                        <a href="#" class="title h2 fw-normal font-2 text-white link link-secondary">
                                            Be <span class="fst-italic">Unmissable.</span>
                                        </a>
                                    </div>
                                    <a href="#" class="tf-btn style-3 btn-fill-white animate-btn animate-dark">
                                        <span class="fw-medium text-uppercase">discover more</span>
                                    </a>
                                </div>
                            </div>
                            */ ?>

                            <?php print $pagination; ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /Product -->

    <?php include(__DIR__ . '/../chunk/_advs_black.tpl'); ?>
<?php print $footer; ?>