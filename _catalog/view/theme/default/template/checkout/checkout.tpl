<?php print $header; ?>

<section class="flat-spacing-2 pb-0">
    <div class="container">
        <div class="page-title">
            <?php include(__DIR__ . '/../chunk/_breadcrumbs.tpl'); ?>
        </div>
    </div>
</section>
<!-- /Page Title -->

<!-- Checkout -->
<section class="flat-spacing">
    <div class="container">
        <div class="s-checkout flex-xl-nowrap">
            <div class="left-col">
                <div class="s-wrap">
                    <form class="form-checkout-cart-main style-border" method="POST" enctype="multipart/form-data" id="checkout_form">
                        <div class="box-ip-checkout">
                            <h4 class="checkout-title">КОНТАКТНЫЕ ДАННЫЕ</h4>
                            <div class="form-content-2">
                                <fieldset class="tf-field-2">
                                    <input class="tf-input" type="text" name="firstname" value="" placeholder="">
                                    <label class="tf-lable">Ваше имя</label>
                                </fieldset>
                                <div class="cols tf-grid-layout sm-col-2">
                                    <fieldset class="tf-field-2">
                                        <input class="tf-input" type="tel" name="telephone" value="" placeholder="">
                                        <label class="tf-lable">Телефон</label>
                                    </fieldset>
                                    <fieldset class="tf-field-2">
                                        <input class="tf-input" type="email" name="email" value="" placeholder="">
                                        <label class="tf-lable">Электронная почта</label>
                                    </fieldset>
                                </div>
                                <fieldset class="tf-field-2">
                                    <textarea class="tf-input" name="comment" value="" placeholder=""></textarea>
                                    <label class="tf-lable">Комментарий к заказу</label>
                                </fieldset>
                            </div>
                        </div>
                        <div class="box-ip-shipping">
                            <h4 class="checkout-title">
                                ДОСТАВКА
                            </h4>
                            <div class="form-content-2">
                                <label for="shipping_method-1" class="check-ship">
                                    <input type="radio" id="shipping_method-1" class="tf-check-rounded" name="shipping_method" value="Самовывоз из магазина" checked>
                                    <span class="text">
                                        <span>Самовывоз из магазина</span>
                                        <!-- <span class="price"></span> -->
                                    </span>
                                </label>
                                <label for="shipping_method-2" class="check-ship">
                                    <input type="radio" id="shipping_method-2" class="tf-check-rounded" name="shipping_method" value="Самовывоз из ПВЗ">
                                    <span class="text">
                                        <span>Самовывоз из ПВЗ</span>
                                        <!-- <span class="price"></span> -->
                                    </span>
                                </label>
                                <label for="shipping_method-3" class="check-ship">
                                    <input type="radio" id="shipping_method-3" class="tf-check-rounded" name="shipping_method" value="Курьер">
                                    <span class="text">
                                        <span>Курьер</span>
                                        <!-- <span class="price"></span> -->
                                    </span>
                                </label>
                            </div>
                        </div>
                        <div class="box-ip-payment">
                            <h4 class="checkout-title mb_12">ОПЛАТА</h4>
                            <div class="form-content-2 payment-method-box">
                                <label for="payment-1" class="check-ship">
                                    <input type="radio" id="payment-1" class="tf-check-rounded" name="payment_method" value="При получении" checked>
                                    <span class="text">
                                        <span>При получении</span>
                                        <!-- <span class="price"></span> -->
                                    </span>
                                </label>
                                <label for="payment-2" class="check-ship">
                                    <input type="radio" id="payment-2" class="tf-check-rounded" name="payment_method" value="Онлайн">
                                    <span class="text">
                                        <span>Онлайн</span>
                                        <!-- <span class="price"></span> -->
                                    </span>
                                </label>
                            </div>
                            <p class="text-main-4">
                                Отправляя заявку вы соглашаетесь с <a href="/privacy-policy/" class="fw-medium text-decoration-underline link">Политикой обработки персональных данных</a>.
                            </p>
                        </div>
                    </form>
                </div>
            </div>
            <div class="right-col sticky-top">
                <div class="tf-page-cart-sidebar">
                    <h4 class="checkout-title">ВАША КОРЗИНА</h4>
                    <ul class="list-order-product">
                        <?php foreach ($products as $product) { ?>
                            <li class="order-item">
                                <div class="content">
                                    <div class="img-product">
                                        <img src="<?php print $product['thumb']; ?>" alt="<?php print $product['name']; ?>" class="prd">
                                        <span class="text-caption quantity"><?php print $product['quantity']; ?></span>
                                    </div>
                                    <div class="info">
                                        <p class="name"><?php print $product['name']; ?></p>
                                        <?php if ($product['option']) { ?>
                                            <?php foreach ($product['option'] as $option) { ?>
                                                <span class="variant"><?php print $option['name']; ?>: <?php print $option['value']; ?></span>
                                            <?php } ?>
                                        <?php } ?>
                                    </div>
                                </div>
                                <h6 class="price nowrap"><?php print $product['price']; ?></h6>
                            </li>
                        <?php } ?>
                    </ul>
                    
                    <span class="br-line"></span>

                    <ul class="list-total">
                        <?php foreach ($totals as $total) { ?>
                            <?php if ($total['code'] != 'total') { ?>
                                <li class="total-item">
                                    <span><?php print $total['title']; ?>:</span>
                                    <span><?php print $total['text']; ?></span>
                                </li>
                            <?php } ?>
                        <?php } ?>
                    </ul>

                    <span class="br-line"></span>

                    <h4 class="last-total d-flex justify-content-between">
                        <?php foreach ($totals as $total) { ?>
                            <?php if ($total['code'] == 'total') { ?>
                                <span><?php print $total['title']; ?>:</span>
                                <span class="total-price-order"><?php print $total['text']; ?></span>
                            <?php } ?>
                        <?php } ?>
                    </h4>

                    <button class="tf-btn btn-fill fw-medium animate-btn w-100" data-submit="#checkout_form">
                        Оформить заказ
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /Checkout -->

<?php ob_start(); ?>
<script>
    $('body').on('click', '[data-submit]', function(e) {
        e.preventDefault();

        $($(this).data('submit')).submit();
    });

    $('body').on('keypress change', '#checkout_form input, #checkout_form textarea, #checkout_form select', function(e) {
        $('#checkout_form .error_input').removeClass('error_input');
        $('#checkout_form .b-errortext').remove();
    });

    $('body').on('submit', '#checkout_form', function(e) {
        e.preventDefault();

        $('#checkout_form .error_input').removeClass('error_input');
        $('#checkout_form .b-errortext').remove();

        id = $(this).attr('id');

        $('#' + id + ' > *').css({'opacity': '0.5'});

        $.ajax({
            url: '/index.php?route=checkout/checkout/checkout',
            type: 'post',
            data: $('#' + id).serialize(),
            dataType: 'json',
            success: function(json) {
                if (json.ok == 1) {
                    window.location = decodeURIComponent(json.redirect);
                } else {
                    $.each(json.errors, function(k, v) {
                        if (v.code == 'cart') {
                            window.location.reload();
                        } else {
                            $('#checkout_form [name="' + v.code + '"]').addClass('error_input');
                            $('#checkout_form [name="' + v.code + '"]').after('<div class="b-errortext">' + v.value + '</div>');
                        }
                    });
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            },
            complete: function() {
                $('#' + id + ' > *').css({'opacity': 1});
            }
        });
    });
</script>
<?php print str_replace('</body>', ob_get_clean() . '</body>', $footer); ?>