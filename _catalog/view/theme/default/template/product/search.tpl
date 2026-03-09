<?php print $header; ?>
    <!-- Page Title -->
    <section class="flat-spacing-2 pb-0">
        <div class="container">
            <div class="page-title type-2">
                <?php include(__DIR__ . '/../chunk/_breadcrumbs.tpl'); ?>
            </div>
        </div>
    </section>
    <!-- /Page Title -->
    <!-- Product -->
    <div class="flat-spacing pt-0">
        <span class="br-line cus-width d-block bg-line"></span>
        <div class="tf-shop-control style-2 mb_10 border-0">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-12">
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
                <div class="col-xl-12">
                    <div class="wrapper-control-shop gridLayout-wrapper">
                        <div class="wrapper-shop tf-grid-layout tf-col-4" id="gridLayout">
                            <?php if (sizeof($products) > 0) { ?>
                                <?php foreach ($products as $product) { ?>
                                    <?php include(__DIR__ . '/../chunk/_product_item.tpl'); ?>
                                <?php } ?>
                            <?php } else { ?>
                                Ничего не найдено
                            <?php } ?>
                            
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