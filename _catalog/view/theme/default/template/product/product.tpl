<?php echo $header; ?>
        <!-- Page Title -->
        <div class="flat-spacing-16 pb-0">
            <div class="container">
                <div class="page-title border-0">
                    <?php include(__DIR__ . '/../chunk/_breadcrumbs_product.tpl'); ?>
                </div>
            </div>
        </div>
        <!-- /Page Title -->
        <!-- Product Detail -->
        <section class="themesFlat">
            <div class="tf-main-product section-image-zoom">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="tf-product-media-wrap sticky-top">
                                <div class="thumbs-slider">
                                    <div class="flat-wrap-media-product">
                                        <div dir="ltr" class="swiper tf-product-media-main" id="gallery-swiper-started">
                                            <div class="swiper-wrapper">
                                                <?php foreach ($images as $image) { ?>
                                                    <!-- item 1 -->
                                                    <div class="swiper-slide">
                                                        <a href="<?php print $image['popup']; ?>" target="_blank" class="item"
                                                            data-pswp-width="593px" data-pswp-height="744px">
                                                            <img class="tf-image-zoom lazyload" data-zoom="<?php print $image['popup']; ?>"
                                                                data-src="<?php print $image['popup']; ?>"
                                                                src="<?php print $image['popup']; ?>" alt="img-product">
                                                        </a>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                    <?php if (sizeof($images) > 1) { ?>
                                        <div dir="ltr" class="swiper tf-product-media-thumbs" data-preview="4" data-direction="horizontal">
                                            <div class="swiper-wrapper stagger-wrap">
                                                <?php foreach ($images as $image) { ?>
                                                    <div class="swiper-slide stagger-item">
                                                        <div class="item">
                                                            <img data-src="<?php print $image['popup']; ?>"
                                                                src="<?php print $image['popup']; ?>" alt="" class="lazyload">
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="tf-product-info-wrap">
                                <div class="tf-zoom-main sticky-top"></div>
                                <div class="tf-product-info-list other-image-zoom">
                                    <div class="tf-product-info-heading">
                                        <ul class="product-info-rate rate-wrap">
                                            <li><i class="icon-star"></i></li>
                                            <li><i class="icon-star"></i></li>
                                            <li><i class="icon-star"></i></li>
                                            <li><i class="icon-star"></i></li>
                                            <li><i class="icon-star"></i></li>
                                        </ul>
                                        <h3 class="product-info-name fw-normal">
                                            <?php print $heading_title; ?>
                                        </h3>

                                        <?php if ($price != '0 ₽') { ?>
                                            <div class="product-info-price">
                                                <div class="price-wrap">
                                                    <?php if ($special) { ?>
                                                        <span class="price-new price-on-sale h4"><?php print $special; ?></span>
                                                        <span class="price-old compare-at-price fw-normal h6"><?php print $price; ?></span>
                                                    <?php } else { ?>
                                                        <span class="price-new price-on-sale h4"><?php print $price; ?></span>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        <?php } ?>

                                        <p class="product-infor-sub h6 fw-normal text-main-4">
                                            Элегантное кольцо с белыми фианитами и вставкой из натуральной кожи, создающее стильный и современный образ.
                                        </p>
                                        <!-- <div class="product-info-progress-sale">
                                            <h6 class="text-hurry-up fw-normal">Осталось 23 шт.</h6>
                                            <div class="progress-cart">
                                                <div class="value" style="width: 0%;" data-progress="70"></div>
                                            </div>
                                        </div> -->
                                    </div>
                                    <form class="tf-product-info-variant" id="product">
                                        <input type="hidden" name="product_id" value="<?php print $product_id; ?>" />
                                        <div class="variant-picker-item">
                                            <?php list($mdl, $mtl) = explode('_', $model, 2); ?>
                                            <div class="variant-picker-label h6 fw-normal">
                                                Материал:
                                                <!-- <span class="variant-picker-label-value tf-dropdown-select d-none"><?php print $mtl; ?></span> -->
                                            </div>
                                            <div class="variant-picker-values">
                                                <?php foreach ($pairs as $metall => $pair) { ?>
                                                    <div class="hover-tooltip color-btn style-image-square<?php print $metall == $mtl ? ' active current' : ''; ?>" data-color="<?php print $metall; ?>">
                                                        <?php if ($metall == $mtl) { ?>
                                                            <div class="check-color">
                                                                <img src="/assets/images/products/material/<?php print $metall == 'Z' ? 'yellow' : 'gray'; ?>.jpg" alt="">
                                                            </div>
                                                        <?php } else { ?>
                                                            <a href="<?php print $pair['href']; ?>" class="check-color">
                                                                <img src="/assets/images/products/material/<?php print $metall == 'Z' ? 'yellow' : 'gray'; ?>.jpg" alt="">
                                                            </a>
                                                        <?php } ?>
                                                        <span class="tooltip"><?php print $metall == 'Z' ? 'Золото' : 'Серебро'; ?></span>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </div>

                                        <?php if ($options) { ?>
                                          <?php foreach ($options as $option) { ?>
                                            <div class="variant-picker-item variant-size">
                                                <div class="variant-picker-label h6 fw-normal">
                                                    <?php echo $option['name']; ?>:
                                                </div>

                                                <div class="variant-picker-values">
                                                    <div class="btn-group" role="group" aria-label="Размер">
                                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                            <input type="radio" class="btn-check" name="option[<?php echo $option['product_option_id']; ?>]" id="opt_<?php echo $option_value['product_option_value_id']; ?>"
                                                               value="<?php echo $option_value['product_option_value_id']; ?>" checked>
                                                            <label class="btn btn-outline-secondary size-btn" for="opt_<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?></label>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                            </div>
                                          <?php } ?>
                                        <?php } ?>
                                        
                                        <?php if ($price != '0 ₽') { ?>
                                          <div class="variant-picker-item">
                                              <div class="variant-picker-label h6 fw-normal">Количество:</div>
                                              <div class="variant-picker-values">
                                                  <div class="wg-quantity">
                                                      <button class="btn-quantity btn-decrease" data-decrement-value="#input-qty-<?php print $product_id; ?>"><i class="icon-minus"></i></button>
                                                      <input id="input-qty-<?php print $product_id; ?>" class="quantity-product" type="text" name="quantity" value="1" data-update-total="">
                                                      <button class="btn-quantity btn-increase" data-increment-value="#input-qty-<?php print $product_id; ?>"><i class="icon-plus"></i></button>
                                                  </div>
                                              </div>
                                          </div>
                                        <?php } ?>
                                    </form>

                                      <?php if ($price != '0 ₽') { ?>
                                        <div class="tf-product-total-quantity">
                                          <div class="group-btn">
                                              <a data-add-to-cart-full class="tf-btn btn-fill-2 text-uppercase fw-medium animate-btn">
                                                  Добавить в корзину
                                                  <!-- <i class="icon-minus d-none d-sm-block"></i> -->
                                                  <!-- <span class="price-add d-none d-sm-block"><?php if ($special) { print $special; } else { print $price; } ?></span> -->
                                              </a>
                                              <div class="group-btn-action">
                                                  <a data-toggle-wishlist="<?php print $product_id; ?>" class="tf-btn-icon hover-tooltip btn-add-wishlist">
                                                      <span class="icon icon-heart-2"></span>
                                                      <span class="tooltip">В избранное</span>
                                                  </a>
                                              </div>
                                          </div>
                                          <a data-add-to-cart-full data-redirect="/checkout/" class="tf-btn w-100 text-uppercase fw-medium">
                                              купить в один клик
                                          </a>
                                        </div>
                                      <?php } else { ?>
                                        <div class="tf-product-total-quantity">
                                          <div class="group-btn">
                                              <a href="#shoppingCart" data-bs-toggle="offcanvas" class="tf-btn btn-unavailable animate-btn text-line-clamp-1 text-center text-nowrap">
                                                  Товара нет в наличии
                                              </a>
                                              <div class="group-btn-action">
                                                  <a data-toggle-wishlist="<?php print $product_id; ?>" class="tf-btn-icon hover-tooltip btn-add-wishlist">
                                                      <span class="icon icon-heart-2"></span>
                                                      <span class="tooltip">В избранное</span>
                                                  </a>
                                              </div>
                                          </div>
                                        </div>
                                      <?php } ?>

                                    <div class="tf-product-share">
                                        <ul class="tf-social-icon">
                                            <li>
                                                <a href="#" class="social-vk">
                                                    <span class="icon"><svg width="20" height="13" viewBox="0 0 20 13" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10.8864 12.33C4.20957 12.33 0.159061 7.69781 0 0H3.3819C3.48732 5.65499 6.05911 8.05107 8.03165 8.54398V0H11.2721V4.88003C13.1743 4.66918 15.1654 2.44972 15.8349 0H19.0254C18.514 3.01199 16.3463 5.23144 14.8149 6.14697C16.3481 6.88771 18.8136 8.82511 19.7652 12.33H16.2594C15.5195 9.98755 13.7051 8.17314 11.2739 7.92623V12.33H10.8864Z" fill="black"/></svg></span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" class="social-tg">
                                                    <span class="icon"><svg width="16" height="13" viewBox="0 0 16 13" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6.2683 8.57932L6.01796 12.2125C6.38579 12.2125 6.54832 12.0496 6.75363 11.8562L8.52091 10.1915L12.1976 12.8229C12.8742 13.1846 13.3626 12.9973 13.5311 12.2144L15.9448 1.19634C16.1919 0.236608 15.5671 -0.198683 14.9198 0.0859995L0.747056 5.37997C-0.220367 5.75586 -0.214727 6.2787 0.570715 6.51167L4.20776 7.61133L12.6279 2.46536C13.0254 2.23186 13.3902 2.35739 13.0908 2.61483L6.26809 8.57917L6.2683 8.57932Z" fill="black"/></svg></span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <?php /*
                                <div class="tf-product-fbt">
                                    <h4 class="title fw-normal text-uppercase">Часто покупают вместе</h4>
                                    <form class="tf-product-form-bundle">
                                        <ul class="tf-bundle-products">
                                            <li class="tf-bundle-product-item">
                                                <div class="bundle-check">
                                                    <input type="checkbox" class="tf-check style-2" checked disabled>
                                                </div>
                                                <a href="product-default.html" class="bundle-image">
                                                    <img src="/assets/images/products/product-3.jpg" alt="img-product">
                                                </a>
                                                <div class="bundle-info">
                                                    <a href="product-default.html" class="name link h5 fw-normal">
                                                        Crystal Birthstone Eternity Circle Charm
                                                    </a>
                                                    <div class="bundle-price price-wrap">
                                                        <span class="price-new h5">$2,499.00</span>
                                                        <span class="price-old fw-normal">$2,899.00</span>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="tf-bundle-product-item ">
                                                <div class="bundle-check">
                                                    <input type="checkbox" class="tf-check style-2">
                                                </div>
                                                <a href="product-default.html" class="bundle-image">
                                                    <img src="/assets/images/products/product-24.jpg" alt="img-product">
                                                </a>
                                                <div class="bundle-info">
                                                    <a href="product-default.html" class="name link h5 fw-normal">
                                                        Sparkling Infinity Heart Clasp Snake Chain Bracelet
                                                    </a>
                                                    <div class="bundle-price price-wrap">
                                                        <span class="price-new h5">$2,499.00</span>
                                                        <span class="price-old fw-normal">$2,899.00</span>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="tf-bundle-product-item ">
                                                <div class="bundle-check">
                                                    <input type="checkbox" class="tf-check style-2">
                                                </div>
                                                <a href="product-default.html" class="bundle-image">
                                                    <img src="/assets/images/products/product-28.jpg" alt="img-product">
                                                </a>
                                                <div class="bundle-info">
                                                    <a href="product-default.html" class="name link h5 fw-normal">
                                                        Engagement Ring in 18k Yellow Gold
                                                    </a>
                                                    <div class="bundle-price price-wrap">
                                                        <span class="price-new h5">$2,499.00</span>
                                                        <span class="price-old fw-normal">$2,899.00</span>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <a href="#shoppingCart" data-bs-toggle="offcanvas"
                                            class="tf-btn btn-fill text-uppercase fw-medium w-100 animate-btn">
                                            Добавить в корзину
                                            <i class="icon-minus"></i>
                                            <span class="total-price"></span>
                                        </a>
                                    </form>
                                </div>
                                */ ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /Product Detail -->
        <!-- Product Desciption -->
        <div class="flat-spacing-3">
            <div class="container">
                <div class="widget-accordion wd-product-descriptions">
                    <div class="accordion-title collapsed" data-bs-target="#description" data-bs-toggle="collapse" aria-expanded="false"
                        aria-controls="description" role="button">
                        <span class="icon icon-arrow-right-down"></span>
                        <span>Описание</span>
                    </div>
                    <div id="description" class="collapse widget-desc">
                        <div class="accordion-body">
                            <h6 class="text-main-4 fw-normal">
                                <?php print $description; ?>
                            </h6>
                        </div>
                    </div>
                </div>
                <div class="widget-accordion wd-product-descriptions">
                    <div class="accordion-title collapsed" data-bs-target="#material" data-bs-toggle="collapse" aria-expanded="true"
                        aria-controls="material" role="button">
                        <span class="icon icon-arrow-right-down"></span>
                        <span>Дополнительная информация</span>
                    </div>
                    <div id="material" class="collapse widget-material">
                        <div class="accordion-body">
                            <table class="table-material">
                                <tbody>
                                    <?php foreach ($attribute_groups as $attribute_group) { ?>
                                        <?php if ($attribute_group['attribute_group_id'] == 7) { ?>
                                            <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                                                <tr>
                                                    <td class="h6"><?php print $attribute['name']; ?></td>
                                                    <td class="h6"><?php print $attribute['text']; ?></td>
                                                </tr>
                                            <?php } ?>
                                        <?php } ?>
                                    <?php } ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <?php /*
                <div class="widget-accordion wd-product-descriptions">
                    <div class="accordion-title collapsed" data-bs-target="#review" data-bs-toggle="collapse" aria-expanded="true"
                        aria-controls="review" role="button">
                        <span class="icon icon-arrow-right-down"></span>
                        <span>reviews</span>
                    </div>
                    <div id="review" class="collapse widget-review">
                        <div class="accordion-body">
                            <div class="wd-rating-review">
                                <div class="rate-head">
                                    <ul class="rate-wrap align-items-center">
                                        <li><i class="icon-star"></i></li>
                                        <li><i class="icon-star"></i></li>
                                        <li><i class="icon-star"></i></li>
                                        <li><i class="icon-star"></i></li>
                                        <li><i class="icon-star"></i></li>
                                        <li>(3)</li>
                                    </ul>
                                    <p>4.5/5.0</p>
                                </div>
                                <ul class="rating-progress">
                                    <li>
                                        <div class="rate-number">
                                            <span>5</span>
                                            <i class="icon-star"></i>
                                        </div>
                                        <span class="line-progress-rate progress" role="progressbar" aria-valuenow="100" aria-valuemin="0"
                                            aria-valuemax="100">
                                            <span class="progress-bar"></span>
                                        </span>
                                        <span class="rate-count">3</span>
                                    </li>
                                    <li>
                                        <div class="rate-number">
                                            <span>4</span>
                                            <i class="icon-star"></i>
                                        </div>
                                        <span class="line-progress-rate progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                            aria-valuemax="100">
                                            <span class="progress-bar" style="width: 0;"></span>
                                        </span>
                                        <span class="rate-count">0</span>
                                    </li>
                                    <li>
                                        <div class="rate-number">
                                            <span>3</span>
                                            <i class="icon-star"></i>
                                        </div>
                                        <span class="line-progress-rate progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                            aria-valuemax="100">
                                            <span class="progress-bar" style="width: 0;"></span>
                                        </span>
                                        <span class="rate-count">0</span>
                                    </li>
                                    <li>
                                        <div class="rate-number">
                                            <span>2</span>
                                            <i class="icon-star"></i>
                                        </div>
                                        <span class="line-progress-rate progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                            aria-valuemax="100">
                                            <span class="progress-bar" style="width: 0;"></span>
                                        </span>
                                        <span class="rate-count">0</span>
                                    </li>
                                    <li>
                                        <div class="rate-number">
                                            <span>1</span>
                                            <i class="icon-star"></i>
                                        </div>
                                        <span class="line-progress-rate progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                            aria-valuemax="100">
                                            <span class="progress-bar" style="width: 0;"></span>
                                        </span>
                                        <span class="rate-count">0</span>
                                    </li>
                                </ul>
                                <a href="#write-review" class="tf-btn fw-medium ">
                                    write a review
                                </a>
                            </div>
                            <div class="box-preview-wrapper">
                                <div class="review-post-list">
                                    <h5 class="title">3 reviews</h5>
                                    <ul>
                                        <li class="post-review-item">
                                            <div class="rv-image">
                                                <img src="/assets/images/avatar/avt-1.jpg" data-src="/assets/images/avatar/avt-1.jpg" alt="" class="lazyload">
                                            </div>
                                            <div class="rv-content">
                                                <div class="d-flex align-items-center justify-content-between flex-wrap">
                                                    <ul class="meta">
                                                        <li class="entry_name h6">
                                                            Emily R.
                                                        </li>
                                                        <li class="br-line"></li>
                                                        <li class="entry_date">Mar 3rd, 2025</li>
                                                    </ul>
                                                    <ul class="rate-wrap align-items-center">
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star text-main-10"></i></li>
                                                    </ul>
                                                </div>
                                                <h6 class="rv-text">
                                                    Absolutely stunning! I bought a gold necklace from here, and the quality exceeded my expectations.
                                                    The craftsmanship is top-notch, and the packaging was beautiful. Will definitely return for more!
                                                </h6>
                                            </div>
                                        </li>
                                        <li class="post-review-item">
                                            <div class="rv-image">
                                                <img src="/assets/images/avatar/avt-2.jpg" data-src="/assets/images/avatar/avt-2.jpg" alt="" class="lazyload">
                                            </div>
                                            <div class="rv-content">
                                                <div class="d-flex align-items-center justify-content-between flex-wrap">
                                                    <ul class="meta">
                                                        <li class="entry_name h6">
                                                            James L.
                                                        </li>
                                                        <li class="br-line"></li>
                                                        <li class="entry_date">Mar 3rd, 2025</li>
                                                    </ul>
                                                    <ul class="rate-wrap align-items-center">
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                    </ul>
                                                </div>
                                                <h6 class="rv-text">
                                                    I purchased an engagement ring, and my fiancée loves it! The diamonds sparkle beautifully, and the
                                                    staff was incredibly helpful in guiding me through the selection process. Highly recommend!
                                                </h6>
                                            </div>
                                        </li>
                                        <li class="post-review-item">
                                            <div class="rv-image">
                                                <img src="/assets/images/avatar/avt-3.jpg" data-src="/assets/images/avatar/avt-3.jpg" alt="" class="lazyload">
                                            </div>
                                            <div class="rv-content">
                                                <div class="d-flex align-items-center justify-content-between flex-wrap">
                                                    <ul class="meta">
                                                        <li class="entry_name h6">
                                                            Sophia M.
                                                        </li>
                                                        <li class="br-line"></li>
                                                        <li class="entry_date">Mar 3rd, 2025</li>
                                                    </ul>
                                                    <ul class="rate-wrap align-items-center">
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                        <li><i class="icon-star"></i></li>
                                                    </ul>
                                                </div>
                                                <h6 class="rv-text">
                                                    This jewelry shop is my go-to! The designs are elegant, and the prices are reasonable for the
                                                    quality you get. I recently got a pair of silver earrings, and they are just perfect. Amazing
                                                    service too!
                                                </h6>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="review-post-comment" id="write-review">
                                    <h5 class="title">write a review</h5>
                                    <h6 class="sub-title">Your email address will not be published. Required fields are marked *</h6>
                                    <div class="your-rate">
                                        <h6 class="fw-normal">Your rating *</h6>
                                        <ul class="rate-wrap handle-rating">
                                            <li class="star" data-value="1"><i class="icon-star"></i></li>
                                            <li class="star" data-value="2"><i class="icon-star"></i></li>
                                            <li class="star" data-value="3"><i class="icon-star"></i></li>
                                            <li class="star" data-value="4"><i class="icon-star"></i></li>
                                            <li class="star" data-value="5"><i class="icon-star"></i></li>
                                        </ul>
                                    </div>
                                    <form class="form-review style-border form-action">
                                        <div class="form-content">
                                            <div class="cols tf-grid-layout sm-col-2">
                                                <input type="text" placeholder="Name *" id="name" required>
                                                <input type="text" placeholder="Email *" id="email" required>
                                            </div>
                                            <textarea id="desc" placeholder="Your review *" style="height: 249px;" required></textarea>
                                        </div>
                                        <div class="checkbox-wrap">
                                            <input id="save" type="checkbox" class="tf-check style-2 p-0">
                                            <label for="save" class="h6 fw-normal">Save my name, email, and website in this browser for the next time
                                                I
                                                comment.</label>
                                        </div>
                                        <div class="form_message"></div>
                                        <button type="submit" class="tf-btn btn-fill-2 fw-medium animate-btn">
                                            Submit
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                */ ?>
            </div>
        </div>
        <!-- /Product Desciption -->

        <?php /*
        <!-- For You -->
        <section class="flat-spacing-3 pt-0">
            <div class="container">
                <div class="sect-top wow fadeInUp">
                    <h3 class="s-title">Вам может понравиться</h3>
                    <div class="group-btn-slider">
                        <div class="nav-prev-swiper tf-sw-nav">
                            <i class="icon-arrow-left"></i>
                        </div>
                        <div class="nav-next-swiper tf-sw-nav">
                            <i class="icon-arrow-right"></i>
                        </div>
                    </div>
                </div>
                <div dir="ltr" class="swiper tf-swiper wow fadeInUp" data-preview="4" data-tablet="3" data-mobile-sm="2" data-mobile="2"
                    data-space-lg="30" data-space-md="20" data-space="15" data-pagination="2" data-pagination-sm="2" data-pagination-md="3"
                    data-pagination-lg="4">
                    <div class="swiper-wrapper">
                        <!-- item 1 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-22.jpg" data-src="/assets/images/products/product-22.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-23.jpg" data-src="/assets/images/products/product-23.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickAdd" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Quick Add</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Open Heart Bangle
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$1,799.00</span>
                                        <span class="price-old fw-normal">$1,259.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- item 2 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-24.jpg" data-src="/assets/images/products/product-24.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-25.jpg" data-src="/assets/images/products/product-25.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#shoppingCart" data-bs-toggle="offcanvas" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Add to Cart</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Crystal Birthstone Eternity Circle Charm
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$2,499.00</span>
                                        <span class="price-old fw-normal">$2,899.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- item 3 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-26.jpg" data-src="/assets/images/products/product-26.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-27.jpg" data-src="/assets/images/products/product-27.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#shoppingCart" data-bs-toggle="offcanvas" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Add to Cart</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Ball Bracelet
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$3,199.00</span>
                                        <span class="price-old fw-normal">$2,239.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- item 4 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-28.jpg" data-src="/assets/images/products/product-28.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-29.jpg" data-src="/assets/images/products/product-29.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#shoppingCart" data-bs-toggle="offcanvas" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Add to Cart</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Engagement Ring in 18k Yellow Gold
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$1,399.00</span>
                                        <span class="price-old fw-normal">$979.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- item 5 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-22.jpg" data-src="/assets/images/products/product-22.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-23.jpg" data-src="/assets/images/products/product-23.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#shoppingCart" data-bs-toggle="offcanvas" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Add to Cart</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Open Heart Bangle
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$1,119.00</span>
                                        <span class="price-old fw-normal">$1,599.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="sw-dot-default tf-sw-pagination d-xl-none"></div>
                </div>
            </div>
        </section>
        <!-- /For You -->
        <!-- Recently -->
        <section class="flat-spacing pt-0">
            <div class="container">
                <div class="sect-top wow fadeInUp">
                    <h3 class="s-title">Недавно просмотренные товары</h3>
                    <div class="group-btn-slider">
                        <div class="nav-prev-swiper tf-sw-nav">
                            <i class="icon-arrow-left"></i>
                        </div>
                        <div class="nav-next-swiper tf-sw-nav">
                            <i class="icon-arrow-right"></i>
                        </div>
                    </div>
                </div>
                <div dir="ltr" class="swiper tf-swiper wow fadeInUp" data-preview="4" data-tablet="3" data-mobile-sm="2" data-mobile="2"
                    data-space-lg="30" data-space-md="20" data-space="15" data-pagination="2" data-pagination-sm="2" data-pagination-md="3"
                    data-pagination-lg="4">
                    <div class="swiper-wrapper">
                        <!-- item 1 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-22.jpg" data-src="/assets/images/products/product-22.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-23.jpg" data-src="/assets/images/products/product-23.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickAdd" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Quick Add</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Open Heart Bangle
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$1,799.00</span>
                                        <span class="price-old fw-normal">$1,259.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- item 2 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-24.jpg" data-src="/assets/images/products/product-24.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-25.jpg" data-src="/assets/images/products/product-25.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#shoppingCart" data-bs-toggle="offcanvas" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Add to Cart</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Crystal Birthstone Eternity Circle Charm
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$2,499.00</span>
                                        <span class="price-old fw-normal">$2,899.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- item 3 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-26.jpg" data-src="/assets/images/products/product-26.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-27.jpg" data-src="/assets/images/products/product-27.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#shoppingCart" data-bs-toggle="offcanvas" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Add to Cart</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Ball Bracelet
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$3,199.00</span>
                                        <span class="price-old fw-normal">$2,239.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- item 4 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-28.jpg" data-src="/assets/images/products/product-28.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-29.jpg" data-src="/assets/images/products/product-29.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#shoppingCart" data-bs-toggle="offcanvas" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Add to Cart</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Engagement Ring in 18k Yellow Gold
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$1,399.00</span>
                                        <span class="price-old fw-normal">$979.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- item 5 -->
                        <div class="swiper-slide">
                            <div class="card_product--V01">
                                <div class="card_product-wrapper">
                                    <a href="product-default.html" class="product-img">
                                        <img src="/assets/images/products/product-22.jpg" data-src="/assets/images/products/product-22.jpg" alt="Image Product"
                                            class="lazyload img-product">
                                        <img src="/assets/images/products/product-23.jpg" data-src="/assets/images/products/product-23.jpg" alt="Image Product"
                                            class="lazyload img-hover">
                                    </a>
                                    <ul class="list-product-btn">
                                        <li class="wishlist">
                                            <a href="javascript:void(0);" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-heart-2"></span>
                                                <span class="tooltip">Add to Wishlist</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#shoppingCart" data-bs-toggle="offcanvas" class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-shop-cart"></span>
                                                <span class="tooltip">Add to Cart</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#quickView" data-bs-toggle="modal" class="hover-tooltip tooltip-left box-icon quickview">
                                                <span class="icon icon-view"></span>
                                                <span class="tooltip">Quick View</span>
                                            </a>
                                        </li>
                                        <li class="compare">
                                            <a href="#compare" data-bs-toggle="modal" aria-controls="compare"
                                                class="hover-tooltip tooltip-left box-icon">
                                                <span class="icon icon-compare"></span>
                                                <span class="tooltip">Add to Compare</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card_product-info">
                                    <a href="product-default.html" class="name-product h5 fw-normal link text-line-clamp-2">
                                        Open Heart Bangle
                                    </a>
                                    <div class="price-wrap">
                                        <span class="price-new h5">$1,119.00</span>
                                        <span class="price-old fw-normal">$1,599.00</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="sw-dot-default tf-sw-pagination d-xl-none"></div>
                </div>
            </div>
        </section>
        <!-- /Recently -->
        */ ?>
    <?php include(__DIR__ . '/../chunk/_advs_black.tpl'); ?>
<?php ob_start(); ?>
<script src="/assets/js/photoswipe-lightbox.umd.min.js"></script>
<script src="/assets/js/photoswipe.umd.min.js"></script>
<script src="/assets/js/zoom.js"></script>
<?php $js = ob_get_clean(); ?>
<?php echo str_replace('</body>', $js . '</body>', $footer); ?>
