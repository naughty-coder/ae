<div class="breadcrumbs">
    <ul class="bread-wrap">
        <?php
            $i = 0; $total = count($breadcrumbs);

            foreach ($breadcrumbs as $breadcrumb) {
                $i++;
                
                if ($i < $total) {
                    print '<li><a href="' . $breadcrumb['href'] . '" class="text-main-4 link-secondary">' . $breadcrumb['text'] . '</a></li>';
                    print '<li class="br-line w-12 bg-main"></li>';
                } else {
                    print '<li><p>' . $breadcrumb['text'] . '</p></li>';
                }
            }
        ?>
    </ul>
    <h1 class="heading fw-normal text-uppercase">
        <?php print $heading_title; ?>
        <?php if (isset($product_total)) { ?>
            <span class="number-count">
                <?php print $product_total; ?>
            </span>
        <?php } ?>
    </h1>
</div>