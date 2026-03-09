<?php if ($options || $show_price) { ?>
<div class="canvas-sidebar sidebar-filter canvas-filter left pe-xxl-30" id="ocfilter">
    <div class="canvas-wrapper">
        <div class="canvas-header d-flex d-xl-none">
            <span class="title">ФИЛЬТР</span>
            <span class="icon-close link icon-close-popup" data-bs-dismiss="offcanvas" onclick='$(".sidebar-filter,.overlay-filter").removeClass("show");'></span>
        </div>

        <div class="canvas-body">
            <?php include 'filter_list.tpl'; ?>
        </div>

        <?php /*
        <div class="canvas-bottom d-xl-none">
            <button id="reset-filter" class=" tf-btn btn-reset">
                <span class=" fw-medium">CLEAR ALL</span>
            </button>
            <button type="button" class="tf-btn btn-fill animate-btn" data-bs-dismiss="offcanvas">
                <span class=" fw-medium">APPLY [100]</span>
            </button>
        </div>
        */ ?>
    </div>
</div>

<?php ob_start(); ?>
<script type="text/javascript"><!--
$(function() {
	var options = {
    mobile: 0,
    php: {
      searchButton : <?php echo $search_button; ?>,
      showPrice    : <?php echo $show_price; ?>,
	    showCounter  : <?php echo $show_counter; ?>,
			manualPrice  : <?php echo $manual_price; ?>,
      link         : '<?php echo $link; ?>',
	    path         : '<?php echo $path; ?>',
	    params       : '<?php echo $params; ?>',
	    index        : '<?php echo $index; ?>'
	  },
    text: {
	    show_all: '<?php echo $text_show_all; ?>',
	    hide    : '<?php echo $text_hide; ?>',
	    load    : '<?php echo $text_load; ?>',
			any     : '<?php echo $text_any; ?>',
	    select  : '<?php echo $button_select; ?>'
	  }
	};

  setTimeout(function() {
    $('#ocfilter').ocfilter(options);
  }, 1);
});
//--></script>
<?php $document->addInlineScript(ob_get_clean()); ?>
<?php } ?>