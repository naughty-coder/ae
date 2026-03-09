<div class="card_product-wrapper">
    <a href="<?php print $product['href']; ?>" class="product-img">
        <img src="<?php print $product['thumb']; ?>" data-src="<?php print $product['thumb']; ?>" alt="Image Product" class="lazyload img-product">
        <?php if (!empty($product['thumb2'])) { ?>
            <img src="<?php print $product['thumb2']; ?>" data-src="<?php print $product['thumb2']; ?>" alt="Image Product" class="lazyload img-hover">
        <?php } ?>
    </a>
    <?php if ($product['price'] != '0 ₽') { ?>
    <ul class="list-product-btn">
        <li class="wishlist">
            <a data-toggle-wishlist="<?php print $product['product_id']; ?>" class="hover-tooltip tooltip-left box-icon">
                <span class="icon icon-heart-2"></span>
                <span class="tooltip">В избранное</span>
            </a>
        </li>
        <li>
            <a href="" data-add-to-cart="<?php print $product['product_id']; ?>" class="hover-tooltip tooltip-left box-icon">
                <span class="icon icon-shop-cart"></span>
                <span class="spinner-border spinner-border-sm d-none spinner-loader" role="status" aria-hidden="true"></span>

                <span class="tooltip">В корзину</span>
            </a>
        </li>
    </ul>
    <?php } else { ?>
        <div class="variant-box stock bg-main link text-white" style="pointer-events:none">
            <p class="text-center d-none d-md-block">Нет в наличии</p>
            <p class="text-center d-md-none">Нет в наличии</p>
        </div>
    <?php } ?>
    <?php /*
    <div class="badge-box">
        <span class="badge-item new">NEW IN</span>
    </div>
    <div class="variant-box">
        <div class="size-box bg-light-gray text-center">
            <p class="text-caption">3 sizes are available</p>
        </div>
    </div>
    */ ?>
</div>
<div class="card_product-info">
    <a href="<?php print $product['href']; ?>" class="name-product h5 fw-normal link text-line-clamp-2">
        <?php print $product['name']; ?>
    </a>
    <?php if ($product['price'] != '0 ₽') { ?>
        <div class="price-wrap">
            <?php if ($product['special']) { ?>
                <span class="price-new h5 mb-0"><?php print $product['special']; ?></span>
                <span class="price-old fw-normal"><?php print $product['price']; ?></span>
            <?php } else { ?>
                <span class="price-new h5 mb-0"><?php print $product['price']; ?></span>
            <?php } ?>
        </div>
    <?php } ?>
</div>