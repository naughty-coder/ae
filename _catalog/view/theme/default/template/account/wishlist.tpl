<?php echo $header; ?>
<!-- Page Title -->
<section class="flat-spacing-2 pb-0">
	<div class="container">
		<div class="page-title">
			<?php include(__DIR__ . '/../chunk/_breadcrumbs.tpl'); ?>
		</div>
	</div>
</section>
<!-- /Page Title -->
<!-- Product -->
<div class="flat-spacing">
	<div class="container">
		<div class="wrapper-wishlist tf-grid-layout tf-col-2 md-col-3 xl-col-4">
            <?php if (sizeof($products) > 0) { ?>
                <?php foreach ($products as $product) { ?>
                    <?php include(__DIR__ . '/../chunk/_product_item.tpl'); ?>
                <?php } ?>
            <?php } else { ?>
                В избранном пусто
            <?php } ?>
		</div>
	</div>
</div>
<!-- /Product -->
<?php echo $footer; ?>