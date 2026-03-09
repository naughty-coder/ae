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
                <h1 class="heading fw-normal">
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
<!-- /Page Title -->
<!-- Term & Condition -->
<section class="flat-spacing">
    <div class="container">
        <div class="main-legal">
            <div class="legal-wrap">
                <?php print $description; ?>
            </div>
        </div>
    </div>
</section>
<!-- /Term & Condition -->
<?php echo $footer; ?>