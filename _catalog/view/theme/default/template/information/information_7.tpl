<?php echo $header; ?>
<!-- Page Title -->
<section class="flat-spacing-2 pb-0">
    <div class="container">
        <div class="page-title">
            <div class="breadcrumbs">
                <ul class="bread-wrap">
                    <?php
                        $i = 0; $total = count($breadcrumbs);

                        foreach ($breadcrumbs as $breadcrumb) {
                            $i++;
                            
                            if ($i < $total) {
                                print '<li><a href="' . $breadcrumb['href'] . '" class="text-main-4 link">' . $breadcrumb['text'] . '</a></li>';
                                print '<li class="br-line w-12 bg-main"></li>';
                            } else {
                                print '<li><p>' . $breadcrumb['text'] . '</p></li>';
                            }
                        }
                    ?>
                </ul>
                <h1 class="heading fw-normal text-uppercase">
                    <?php print $heading_title; ?>
                </h1>
            </div>
            <div class="box-text">
                <p class="text-main-4">

                    Нужна помощь с выбором украшения или оформлением заказа? Напишите нам через раздел «Контакты» — мы подскажем и поможем сделать идеальный выбор.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Our Store -->
<div class="flat-spacing flat-animate-tab-2">
    <div class="container">
        <div class="row flex-wrap-reverse">
            <div class="col-md-6">
                <div class="store-accordion" id="jeda-address" role="tablist">
                    <?php $is_first = true; ?>
                    <?php foreach ($locations as $location) { ?>
                        <div class="widget-accordion-2 nav-tab-item<?php if ($is_first) { print ' active'; } ?>" role="presentation">
                            <div class="accordion-title<?php if (!$is_first) { print ' collapsed'; } ?>" data-bs-target="#location-<?php print $location['location_id']; ?>" role="button" data-bs-toggle="collapse"
                                aria-expanded="true" aria-controls="location-<?php print $location['location_id']; ?>">
                                <span class="h3 fw-normal"><?php print $location['name']; ?></span>
                                <span class="icon ic-accordion-custom"></span>
                            </div>
                            <div id="location-<?php print $location['location_id']; ?>" class="collapse<?php if ($is_first) { print ' show'; } ?>" data-bs-parent="#jeda-address">
                                <ul class="store-info-list">
                                    <li>
                                        <p class="caption">Адрес:</p>
                                        <a href="https://www.google.com/maps?q=15+Geogre+st,Sydney,NSW+2000,Australia" class="link text-main-4"
                                            target="_blank"><?php print $location['address']; ?></a>
                                    </li>
                                    <li>
                                        <p class="caption">Email:</p>
                                        <a href="mailto:<?php print $location['fax']; ?>" class="link text-main-4">
                                            <?php print $location['fax']; ?>
                                        </a>
                                    </li>
                                    <li>
                                        <p class="caption">Телефон:</p>
                                        <a href="tel:<?php print preg_replace('/[^\d\+]/im', '', $location['telephone']); ?>" class="link text-main-4">
                                            <?php print $location['telephone']; ?>
                                        </a>
                                    </li>
                                </ul>
                                <a href="https://www.google.com/maps?q=15+Geogre+st,Sydney,NSW+2000,Australia" target="_blank"
                                    class="btn-get-dir tf-btn-line text-caption-2 fw-normal">
                                    Get Direction
                                    <i class="icon icon-arrow-top-right"></i>
                                </a>
                            </div>
                        </div>

                        <?php 
                            $items[$location['location_id']] = [
                                'id' => $location['location_id'],
                                'name' => $location['name'],
                                'address' => $location['address'],
                                'phone' => $location['telephone'],
                                'email' => $location['fax'],
                                'center' => json_decode($location['geocode']),
                            ]; 
                        ?>

                        <?php $is_first = false; ?>
                    <?php } ?>
                </div>
            </div>
            <div class="col-md-6">
                <div id="map"></div>
            </div>
        </div>
    </div>
</div>
<!-- /Our Store -->
<?php ob_start(); ?>
<style>
    #map {
        width: 100%;
        height: 744px;
    }
</style>
<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU&amp;apikey=cff91f55-8c1e-4d89-8115-b2ec0c8256ea" type="text/javascript"></script>
<script type="text/javascript">
    var myMap, selectedPlacemark = null;
    var items = <?php print json_encode($items); ?>;

    $ = jQuery.noConflict();

    $(document).on('shown.bs.collapse', '.collapse', function () {
        const id = this.id.replace('location-', '');
        focusOnPointById(id);
    });

    ymaps.ready(init);

    function focusOnPointById(id) {
        // Перебираем все объекты в коллекции.
        collection.each(function (geoObject) {
            if (geoObject.properties.get('id') == id) {
                // Симулируем клик по точке.
                geoObject.events.fire('click', { target: geoObject, zoomToElem: true });
            }
        });
    }

    function showPoint(id) {
        $('#location-' + id).collapse('show');
    }

    function init() {
        // Создание экземпляра карты.
        myMap = new ymaps.Map('map', {
            center: [59.9692925, 29.9545959],
            zoom: 14,
            controls: []
        });

        var svgIcon = `<svg width="32" height="32" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg"><rect width="100" height="100" rx="50" fill="#1F1F1F"/><g clip-path="url(#clip0_4037_9254)"><path d="M48.967 50.9295C51.2366 53.1147 56.3523 53.0297 61.2115 46.7356C65.2919 45.9967 73.3292 42.9418 75.7726 41.0518C77.2298 39.9244 76.4168 39.2021 74.0627 38.0719C70.5593 36.3899 64.5032 33.8896 61.1012 34.3747C54.1979 35.3586 53.6524 38.2689 49.3531 41.9347C50.2609 37.1355 50.8235 35.8011 52.0557 33.2158C54.7666 30.5229 59.4553 28.5921 63.528 27.6976C66.855 26.9669 68.695 27.0707 69.8709 26.5939C70.4986 26.3395 71.4362 25.0576 70.2018 24.3314C69.0524 23.6549 64.8247 24.5842 62.1491 25.6558C59.7532 26.6154 55.8956 29.1687 53.2139 31.1189C53.8918 29.7796 54.5658 28.3625 55.4753 27.2561C57.3523 24.9732 59.8425 23.3287 62.7007 21.6275C64.4298 20.5983 65.3879 19.823 64.6311 19.1994C64.0652 18.7326 62.5275 18.3314 60.6599 19.6409C56.0434 22.8779 53.7804 26.3528 51.2835 32.7192C50.3745 33.5541 49.155 34.4464 47.6984 36.3061C49.3288 27.9961 48.3972 22.7852 45.2715 17.0473C44.2622 15.1948 43.4658 16.0562 43.1756 17.0473C42.7923 18.3568 43.4431 18.6432 42.4586 21.0205C41.5017 23.3315 39.9584 25.0223 38.3771 29.7393C33.5378 30.3938 30.8804 35.5567 30.8208 38.5686C30.7226 43.5455 35.6033 46.2174 41.19 46.6252C40.5171 48.6962 40.1906 50.9234 41.521 51.2054C42.95 51.5083 44.3229 50.6243 45.6576 46.0182C45.9262 45.9167 46.6962 45.6341 47.7535 44.8594C47.5721 47.3674 47.528 49.5438 48.967 50.9295ZM61.046 45.8527C59.8519 46.0563 59.4432 45.4493 59.6671 44.9697C60.0306 44.1906 60.9661 43.9086 61.4873 43.9765C62.0085 44.0443 62.1817 44.0035 61.7631 44.5835C61.3444 45.1634 61.415 45.4228 61.046 45.8527ZM58.1228 37.6856C61.3428 36.7922 67.0028 38.2844 70.0364 39.5067C74.0153 41.1097 73.1858 41.4342 72.1874 41.9899C70.4032 42.9826 64.7073 45.2175 61.9285 45.7975C62.8617 43.8065 63.1188 43.2414 61.7631 43.1487C60.7934 43.0825 59.2082 43.4726 58.0676 44.6938C56.745 46.1098 57.7913 47.2648 60.1084 46.9563C57.772 49.9616 53.0617 51.1535 50.5665 49.5499C49.0955 48.6046 48.7281 46.7604 49.0773 43.7005C52.5504 40.5827 54.4616 38.7015 58.1228 37.6856ZM39.3147 31.6707C39.4466 30.9031 39.547 30.4733 39.9766 30.843C40.4063 31.2127 40.5767 31.7187 40.3627 32.3881C40.1487 33.0575 39.6484 33.0448 39.4251 32.664C39.3291 32.5007 39.2105 32.2783 39.3147 31.6707ZM41.6864 45.2457C30.1617 45.0972 32.6299 34.3211 37.991 31.1741C37.5597 33.9172 37.6011 35.0821 39.3147 35.092C42.3582 35.1091 42.6688 30.439 39.9766 29.8497C41.12 27.5557 42.2733 24.9633 42.955 23.5037C43.6081 22.1059 44.4111 20.9769 45.8231 24.0003C47.6846 27.9856 47.111 34.8101 46.6504 37.5201C44.4745 39.5652 42.8993 41.9612 41.6864 45.2457ZM42.7344 49.4947C42.1602 49.3971 41.949 48.444 42.0174 46.6252C42.4553 46.6307 43.4663 46.6859 44.8303 46.4045C44.1657 48.5754 43.5882 49.6399 42.7344 49.4947ZM45.2164 44.9697C44.0002 45.1287 42.4586 45.1905 42.4586 45.1905C43.5976 42.689 44.9401 40.8592 46.2092 39.617C45.956 41.5241 45.3631 44.2386 45.2164 44.9697ZM45.9886 44.6938C46.2699 43.4859 46.9394 39.9884 47.3675 37.9064C47.5599 37.7403 48.8738 36.2768 50.5665 34.5954C50.3221 35.1881 48.9697 39.2291 48.0293 43.3694C47.491 43.8942 47.0183 44.4792 45.9886 44.6938Z" fill="url(#paint0_linear_4037_9254)"/><path d="M22.6559 55.9909C22.3884 55.9683 19.7216 56.0687 18.3537 55.9909C16.9859 55.9131 17.1094 56.3794 17.8022 56.3772C18.7878 56.3744 19.1551 56.7916 19.2914 57.4256C19.3978 57.9201 19.2831 65.4442 19.3465 68.407C19.4877 75.0102 18.7144 76.877 16.3681 78.7262C15.9285 79.0727 15.9473 79.1952 16.0372 79.2228C16.1789 79.2664 16.693 79.0137 17.3609 78.5606C19.3454 77.2147 20.9869 75.3898 21.2218 72.8768C21.368 71.3096 21.3046 59.436 21.3321 58.2534C21.3746 56.4186 21.5555 56.4986 22.6007 56.3772C23.3161 56.2939 22.9234 56.0135 22.6559 55.9909ZM39.2577 70.3384C39.0834 70.3081 39.0564 70.5911 38.9819 71.0558C38.78 72.3189 37.7233 72.5965 36.9963 72.6009C36.7503 72.6025 35.4376 72.6379 34.5695 72.6009C33.4713 72.554 33.1895 71.7136 33.1906 71.2213C33.1911 70.8571 33.1939 65.6357 33.1906 64.6546C35.6042 64.6551 35.9528 64.6502 36.9963 64.8201C37.8159 64.9537 37.8766 65.5817 37.8788 66.0893C37.881 66.597 38.0757 66.5363 38.2097 66.4756C38.3438 66.4149 38.3013 65.6479 38.32 65.2064C38.3399 64.7412 38.5081 63.4522 38.5407 63.2198C38.5732 62.9892 38.3873 63.0532 38.0994 63.3302C37.7398 63.6762 37.4067 63.7054 36.9963 63.7165C36.661 63.7253 34.0179 63.7225 33.1906 63.7165C33.1795 63.6254 33.1823 58.6888 33.1906 56.9842C33.3764 56.9709 34.6329 56.982 35.5623 56.9842C37.0945 56.9875 37.9273 57.089 38.1546 58.0327C38.2472 58.4184 38.0889 58.9399 38.3752 58.9156C38.6615 58.8913 38.6024 58.6115 38.651 58.2534C38.6995 57.8953 38.7613 56.7094 38.8716 56.2116C38.9819 55.7139 38.8617 55.7669 38.7061 55.8254C38.5506 55.8838 38.0961 56.0477 37.7685 56.0461C37.4409 56.0444 30.1063 55.9578 29.44 55.9909C29.1355 56.0058 29.1096 56.2199 29.2194 56.322C29.3054 56.4026 29.4736 56.3783 29.6606 56.3772C30.7968 56.3717 31.1085 56.865 31.1498 57.8671C31.1642 58.2192 31.1454 69.6762 31.1498 70.504C31.1647 73.198 30.5867 73.0948 29.8812 73.1527C29.5134 73.1831 29.5475 73.2405 29.5503 73.3183C29.558 73.528 29.6529 73.5776 30.5983 73.539C31.9904 73.4822 37.2892 73.603 38.4855 73.5942C39.2831 73.5887 39.2527 72.7228 39.4231 71.2765C39.5142 70.5012 39.454 70.3726 39.2577 70.3384ZM54.26 55.9909C53.6224 55.9611 47.2431 56.1211 46.1521 55.9909C45.8642 55.9567 45.5311 56.0566 45.6006 56.2116C45.7059 56.4473 45.8322 56.3888 46.5382 56.4324C47.5371 56.4942 47.542 57.1194 47.5862 58.4741C47.6253 59.671 47.5415 67.4463 47.5862 68.8485C47.7108 72.7466 47.2955 73.1687 46.2073 73.1527C45.808 73.1472 45.9293 73.2962 45.9315 73.3735C45.9348 73.4849 46.0269 73.5721 46.7588 73.539C47.9849 73.4838 48.6898 73.5015 50.73 73.5942C53.6472 73.7272 56.544 74.0969 59.5433 72.086C61.0916 71.0486 63.4511 68.3733 63.2503 64.1028C62.9917 58.6021 58.4309 56.1857 54.26 55.9909ZM54.0394 72.8768C51.8569 73.0197 50.334 72.5545 50.0472 72.1854C49.473 71.4465 49.6396 69.951 49.6269 69.014C49.6137 68.077 49.6175 59.6677 49.6269 58.4741C49.6396 56.8225 49.3385 56.8904 51.6125 56.8186C57.4066 56.636 60.9415 60.0485 61.0993 64.8753C61.2504 69.5051 59.0513 72.5479 54.0394 72.8768ZM83.9888 73.2631C83.9447 73.1417 83.6154 73.1792 83.2718 73.1527C82.728 73.1108 81.9034 72.5965 81.3965 71.6076C80.5388 69.9339 76.3382 58.7169 75.4949 56.4875C74.9582 55.0699 74.7442 55.7928 74.3366 56.8738C74.052 57.6293 69.6986 69.4141 69.3175 70.6143C68.4852 73.2344 67.5343 73.1511 66.7251 73.1527C66.3297 73.1538 66.3374 73.1875 66.3391 73.3183C66.3424 73.5368 66.4113 73.5362 66.7251 73.539C66.9893 73.5412 70.8386 73.5423 71.2479 73.539C71.6572 73.5357 71.6329 73.4739 71.634 73.3183C71.6351 73.1627 71.4674 73.1649 70.9721 73.1527C70.072 73.1306 70.2904 72.0496 70.4757 71.3869C70.6169 70.882 71.6638 67.9457 71.8546 67.3034C72.0454 66.661 72.0543 66.6947 72.2407 66.6963C72.4271 66.698 75.4866 66.6892 76.7083 66.6963C77.3178 66.6997 77.2974 66.682 77.3702 66.8619C77.5097 67.2068 79.0706 71.3317 79.3558 72.1042C79.6646 72.9414 79.5334 73.0026 79.3558 73.0975C79.1771 73.193 79.1009 73.5158 79.4661 73.4838C79.8312 73.4518 82.7114 73.55 83.4373 73.539C83.9899 73.5307 84.0682 73.4816 83.9888 73.2631ZM72.351 65.8134C72.351 65.8134 74.3355 59.7257 74.3918 59.5226C74.448 59.3195 74.5319 58.7346 74.833 59.6881C75.1342 60.6417 76.9841 65.8134 76.9841 65.8134H72.351Z" fill="#FCCB00" stroke="white" stroke-width="0.531915" stroke-miterlimit="10"/></g><defs><linearGradient id="paint0_linear_4037_9254" x1="53.6601" y1="52.2235" x2="53.6601" y2="15.9574" gradientUnits="userSpaceOnUse"><stop offset="0.01" stop-color="#AD465E"/><stop offset="0.21" stop-color="#8D5A9B"/><stop offset="0.23" stop-color="#7E66A6"/><stop offset="0.25" stop-color="#647CBA"/><stop offset="0.28" stop-color="#518CC8"/><stop offset="0.31" stop-color="#4595D1"/><stop offset="0.34" stop-color="#4299D4"/><stop offset="0.46" stop-color="#8ACAD6"/><stop offset="0.61" stop-color="#93C69A"/><stop offset="0.78" stop-color="#F7E683"/><stop offset="0.99" stop-color="#DB8D68"/></linearGradient><clipPath id="clip0_4037_9254"><rect width="68.0851" height="63.2979" fill="white" transform="translate(15.957 15.9575)"/></clipPath></defs></svg>`;

        var svgSelectedIcon = `<svg width="32" height="32" viewBox="2 2 20 20"><circle cx="12" cy="12" r="10" fill="black"></circle><text x="12" y="16" font-size="10" fill="white" text-anchor="middle" font-family="Arial" font-weight="bold">✓</text></svg>`;
        var CustomLayout = ymaps.templateLayoutFactory.createClass(`<div style="position: relative; width: 24px; height: 24px;">${svgIcon}</div>`);
        var SelectedLayout = ymaps.templateLayoutFactory.createClass(`<div style="position: relative; width: 24px; height: 24px;">${svgSelectedIcon}</div>`);
            
        collection = new ymaps.GeoObjectCollection(null),
        myMap.geoObjects.add(collection);
        
        let is_first = true;
        $.each(items, function(i, item) {
            placemark = new ymaps.Placemark(item.center, { id: item.id },
            {
                iconLayout: is_first ? SelectedLayout : CustomLayout, // Указываем кастомный макет
                iconShape: {
                    type: 'Circle',
                    coordinates: [12, 12],
                    radius: 12
                }
            });

            if (is_first) {
                selectedPlacemark = placemark;
            }

            // Обработка кликов по точке.
            placemark.events.add('click', function (e) {
                var targetPlacemark = e.get('target');
                var zoomToElem = e.get('zoomToElem') ?? false;

                // Если есть выбранная метка, сбрасываем её иконку.
                if (selectedPlacemark) {
                    selectedPlacemark.options.set({ iconLayout: CustomLayout });
                }

                // Устанавливаем новую иконку для выбранной метки.
                targetPlacemark.options.set({ iconLayout: SelectedLayout });
                selectedPlacemark = targetPlacemark; // Сохраняем выбранную метку

                var coordinates = targetPlacemark.geometry.getCoordinates();
                if (zoomToElem || (myMap.getZoom() < 13)) {
                    myMap.setCenter(coordinates, 16, { duration: 500 });
                } else {
                    myMap.setCenter(coordinates, myMap.getZoom(), { duration: 500 });
                }

                showPoint(targetPlacemark.properties.get('id'));
            });

            collection.add(placemark);

            is_first = false;
        });

        // Выставляем масштаб карты чтобы были видны все группы.
        myMap.setBounds(myMap.geoObjects.getBounds());
    }
</script>
<?php $js = ob_get_clean(); ?>
<?php echo str_replace('</body>', $js . '</body>', $footer); ?>