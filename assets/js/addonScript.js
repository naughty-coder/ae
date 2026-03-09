/* ------------ Start Content-width JS --------------- */
function contentwidth() {
	colsWidth = $('#column-right, #column-left').length;
	if($( window ).width() >= 1300) {
		$( "#content" ).addClass( "Cwidth" );
		$( "#column-left" ).addClass( "Lwidth" );
		$( "#column-right" ).addClass( "Rwidth" );
		if (colsWidth == 2) {
			$('.Cwidth').css('width', '82%');
			$('.Lwidth').css('width', '18%');
			$('.Rwidth').css('width', '18%');
		} else if (colsWidth == 1) {
			$('.Cwidth').css('width', '82%');
			$('.Lwidth').css('width', '18%');
			$('.Rwidth').css('width', '18%');
		} else {
			$('.Cwidth').css('width', '100%');
		}
	} else if($( window ).width() > 991) {
		$( "#content" ).addClass( "Cwidth" );
		$( "#column-left" ).addClass( "Lwidth" );
		$( "#column-right" ).addClass( "Rwidth" );
	if (colsWidth == 2) {
		$('.Cwidth').css('width', '82%');
		$('.Lwidth').css('width', '18%');
		$('.Rwidth').css('width', '18%');
		$("#column-left" ).addClass("Rtoggle" );
		$("#column-left h1.text-uppercase").click(function() {
			$(this).parent().toggleClass('active').find('.rightcolumn-toggle').slideToggle( "200" );
		});
	} else if (colsWidth == 1) {
		$('.Cwidth').css('width', '78%');
		$('.Lwidth').css('width', '22%');
		$('.Rwidth').css('width', '22%');
	} else {
		$('.Cwidth').css('width', '100%');
	}
	} else {
	$("#content").removeClass("Cwidth");
	$("#column-left").removeClass("Lwidth");
	$("#column-right").removeClass("Rwidth");
	$("#column-right" ).removeClass("Rtoggle" );
	$('#content').removeAttr("style");
	$('#column-left').removeAttr("style");
	$('#column-right').removeAttr("style");
	} 
}
$(document).ready(function(){contentwidth();});
$(window).resize(function() {contentwidth();});

/* ------------ End Content-width JS --------------- */

$(document).ready(function() {
	
		$(".user-info a.dropdown-toggle").click(function(){
			$( ".account-link-toggle" ).slideToggle( "2000" );
			$(".header-cart-toggle").slideUp("slow");
			$(".language-toggle").slideUp("slow");
			$(".currency-toggle").slideUp("slow");
			$("body").removeClass("language-open");
			$("body").removeClass("currency-open");
			$("body").removeClass("cart-open");
			$("body").toggleClass("user-open");
	  	});
			
		$("#cart button.dropdown-toggle").click(function(){
			$( ".header-cart-toggle" ).slideToggle( "2000" );														 
		   	$(".account-link-toggle").slideUp("slow");
			$(".language-toggle").slideUp("slow");
			$(".currency-toggle").slideUp("slow");
			$("body").removeClass("language-open");
			$("body").removeClass("currency-open");
			$("body").removeClass("user-open");
			$("body").toggleClass("cart-open");
			$('.aesearchtoggle').parent().removeClass("active");
			$('.aesearchtoggle').hide('fast');
   	    });
		
		$("#form-currency button.dropdown-toggle").click(function(){
			$( ".currency-toggle" ).slideToggle( "2000" );	
			$(".language-toggle").slideUp("slow");
			$(".account-link-toggle").slideUp("slow");
			$(".header-cart-toggle").slideUp("slow");
			$("body").removeClass("language-open");
			$("body").removeClass("user-open");
			$("body").removeClass("cart-open");
			$("body").toggleClass("currency-open");
			$('.aesearchtoggle').parent().removeClass("active");
			$('.aesearchtoggle').hide('fast');
			
    	});
		
        $("#form-language button.dropdown-toggle").click(function(){
			$( ".language-toggle" ).slideToggle( "2000" );																  
			$(".currency-toggle").slideUp("fast");
			$(".account-link-toggle").slideUp("slow");
			$(".header-cart-toggle").slideUp("slow");
			$("body").removeClass("currency-open");
			$("body").removeClass("cart-open");
			$("body").removeClass("user-open");
			$("body").toggleClass("language-open");
			$('.aesearchtoggle').parent().removeClass("active");
			$('.aesearchtoggle').hide('fast');
       	});
		
	$(".option-filter .list-group-items a").click(function() {
		$(this).toggleClass('collapsed').next('.list-group-item').slideToggle();
	});
	
	$('#page > .container > .row').wrapAll("<div class='page-bg'></div>");
	$( "#content" ).addClass( "left-column" );
	
	$("#column-left .products-list .product-thumb, #column-right .products-list .product-thumb").unwrap();
	$("#column-left .list-products .product-thumb, #column-right .list-products .product-thumb").unwrap();

	$("#content > h1, .account-wishlist #content > h2, .account-address #content > h2, .account-download #content > h2").first().addClass("page-title");
	
	$("#content > .page-title").wrap("<div class='page-title-wrapper'></div>");
	$(".page-title-wrapper").append($("ul.breadcrumb"));
	$(".page-title-wrapper").prependTo(".page-bg");
	
	$("#account-order #content > h2").wrap("<div class='page-title-wrapper'><div class='breadcrub'></div></div>");
	$("#account-address #content > h2").wrap("<div class='page-title-wrapper'><div class='breadcrub'></div></div>");
	$(".page-title-wrapper .breadcrub").append($("ul.breadcrumb"));
	$("#content > .page-title-wrapper").prependTo($(".page-bg"));
	
	$('#column-left .product-thumb .image, #column-right .product-thumb .image').attr('class', 'image col-xs-5 col-sm-4 col-md-4');
	$('#column-left .product-thumb .thumb-description, #column-right .product-thumb .thumb-description').attr('class', 'thumb-description col-xs-7 col-sm-8 col-md-8');
	
		$('#content .row > .product-sort .product-thumb .image').attr('class', 'image col-xs-3 col-sm-3 col-md-2');
		$('#content .row > .product-sort .product-thumb .thumb-description').attr('class', 'thumb-description col-xs-9 col-sm-9 col-md-10');
		$('#content .row > .product-list .product-thumb .image').attr('class', 'image col-xs-5 col-sm-4 col-md-3');
		$('#content .row > .product-list .product-thumb .thumb-description').attr('class', 'thumb-description col-xs-7 col-sm-8 col-md-9');
		$('#content .row > .product-grid .product-thumb .image').attr('class', 'image col-xs-12');
		$('#content .row > .product-grid .product-thumb .thumb-description').attr('class', 'thumb-description col-xs-12');

		$('select.form-control').wrap("<div class='select-wrapper'></div>");
		$('input[type="checkbox"]').wrap("<span class='checkbox-wrapper'></span>");
		$('input[type="checkbox"]').attr('class','checkboxid');
		$('input[type="radio"]').wrap("<span class='radio-wrapper'></span>");
		$('input[type="radio"]').attr('class','radioid');
		
		$('#column-left .products-list .btn-cart').removeAttr('data-original-title');
		
		// $('.slideshow-panel, #ttcmsrightbanner').wrapAll("<div class='offer-slider'><div class='row'></div></div>");
		$('.ae-special-countdown, .ae-latest-product').wrapAll("<div class='ttspecialnew'><div class='row'></div></div>");
		$('.newletter-subscribe, #ttcmstopfooterservice').wrapAll("<div class='ttfooterbottombanners'></div>");
		$('.footer-bottom .container .footer-bottom-cms #footer-bottom .aefooterbottombanners').appendTo('.footer-container > .container');
/*-------start go to top---------*/		
	$( "body" ).append( "<div class='backtotop-img'><div class='goToTop ttbox'></div></div>" );
	$( "body" ).append( "<div id='goToTop' title='Top' class='goToTop ttbox-img'></div>" );
	$("#goToTop").hide();
/*-------end go to top---------*/		
/*---------------------- Inputtype Js Start -----------------------------*/
$('.checkboxid').change(function(){
if($(this).is(":checked")) {
$(this).addClass("chkactive");
$(this).parent().addClass('active');
} else {
$(this).removeClass("chkactive");
$(this).parent().removeClass('active');
}
});

$(function() {
var $radioButtons = $('input[type="radio"]');
$radioButtons.click(function() {
$radioButtons.each(function() {
$(this).parent().toggleClass('active', this.checked);
});
});
});
/*---------------------- Inputtype Js End -----------------------------*/

/*------------- Slider -Loader Js Strat ---------------*/
$(window).load(function() 
{ 
$(".aeloading-bg").fadeOut("slow");
})
/*------------- Slider -Loader Js End ---------------*/
/* Slider Load Spinner */
$(window).load(function() { 
	$(".slideshow-panel .aeloading-bg").removeClass("ttloader");
});

/* --------------- Start Sticky-header JS ---------------*/	
function menuClass() {
	if($( window ).width() > 991) {
		$( ".left-main-menu" ).addClass( "left-menu" );
	}
	else {
		$(".left-main-menu").removeClass('left-menu');
	}
}
$(document).ready(function(){menuClass();});
$(window).resize(function() {menuClass();});
	
	function header() {	
	 if (jQuery(window).width() > 1199){
		 if (jQuery(this).scrollTop() > 800)
			{    
				jQuery('.full-header').addClass("fixed");
				$( ".header-bottom-block .container .header-bottom #header-bottom .left-menu" ).prependTo( ".full-header .container" );
				 
			}else{
			 jQuery('.full-header').removeClass("fixed");
			 $( ".full-header .container .left-menu" ).prependTo( ".header-bottom-block .container .header-bottom #header-bottom" );
			}
		} else {
		  jQuery('.full-header').removeClass("fixed");
		  $( ".full-header .container .left-menu" ).prependTo( ".header-bottom-block .container .header-bottom #header-bottom" );
		  }
	}
	 
	$(document).ready(function(){header();});
	jQuery(window).resize(function() {header();});
	jQuery(window).scroll(function() {header();});

/* --------------- End Sticky-header JS ---------------*/
/* --------------- Start Carousel Counter JS ---------------*/
		colsblogCarousel = $('#column-right, #column-left').length;
			if (colsblogCarousel == 2) {
				cBi=2;
			} else if (colsblogCarousel == 1) {
				cBi=3;
			} else {
				cBi=3;
		}

		colscategoryCarousel = $('#column-right, #column-left').length;
			if (colscategoryCarousel == 2) {
				cwi=3;
			} else if (colscategoryCarousel == 1) {
				cwi=5;
			} else {
				cwi=5;
		}

		colsbestsellerCarousel = $('#column-right, #column-left').length;
			if (colsbestsellerCarousel == 2) {
				cbi=2;
			} else if (colsbestsellerCarousel == 1) {
				cbi=3;
			} else {
				cbi=3;
		}

		colsCarousel = $('#column-right, #column-left').length;
			if (colsCarousel == 2) {
				ci=3;
			} else if (colsCarousel == 1) {
				ci=6;
			} else {
				ci=6;
		}

		colsrelatedCarousel = $('#column-right, #column-left').length;
			if (colsrelatedCarousel == 2) {
				cRi=3;
			} else if (colsrelatedCarousel == 1) {
				cRi=5;
			} else {
				cRi=5;
		}

/* --------------- End Carousel Counter JS ---------------*/
/* ----------- SmartBlog Js Start ----------- */
			var ttblog = $('#ttsmartblog-carousel').owlCarousel({
				items : cBi, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					543:{
						items:1
					},
					544:{
						items:2
					},
					1199:{
						items:2
					},
					1350:{
						items:cBi
					}
				}
			});

      // Custom Navigation Events
      $(".aeblog_next").click(function(){
			ttblog.trigger('next.owl.carousel',[700]);
	  })
	  $(".aeblog_prev").click(function(){
		 	ttblog.trigger('prev.owl.carousel',[700]);
	  })
 /* ----------- SmartBlog Js End ----------- */

        var ttfooterserivce = $('#ttcmstopfooterservice .aecmsservices').owlCarousel({
				items : 4, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: true,
				autoplay:true,	
				autoplaySpeed: 700,
				smartSpeed:450,
				pagination:true,
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					360:{
						items:2
					},
					544:{
						items:3
					},
					992:{
						items:3
					},
					1450:{
						items:4
					}
				}
			});


/* -----------Start carousel For Testimonial ----------- */

		var tttestimonial = $('.testimonial').owlCarousel({
				items : 1, //1 items above 1000px browser width
				nav : false,
				dots : true,
				loop: true,
				autoplay:true,
				autoplaySpeed: 1000,
				autoplayHoverPause:true,
				smartSpeed:450,
				pagination:true,
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					768:{
						items:1
					},
					992:{
						items:1
					},
					1200:{
						items:1
					}
				}
			});

/* ----------- End carousel For Testimonial ----------- */
/*-------------------------- Countdown js start ------------------------------ */
$('.ae-special-countdown .product-thumb').each(function(){
var $desc = jQuery(this).find('.thumb-description .progress');
var $qty = jQuery(this).find('.quantity');
var $pbar = jQuery(this).find('.progress-bar');
var $progress = $desc;
var $progressBar = $pbar;
var $quantity = $qty.html();
var currentWidth = parseInt($progressBar.css('width'));
var allowedWidth = parseInt($progress.css('width'));
var addedWidth = currentWidth + parseInt($quantity);
if (addedWidth > allowedWidth) {
addedWidth = allowedWidth;
}
var progress = (addedWidth / allowedWidth) * 100;
$progressBar.animate({width: progress + '%' }, 100);
});

$('.special-carousel.products-list .product-thumb').each(function(){
var $desc = jQuery(this).find('.thumb-description .progress');
var $qty = jQuery(this).find('.quantity');
var $pbar = jQuery(this).find('.progress-bar');
var $progress = $desc;
var $progressBar = $pbar;
var $quantity = $qty.html();
var currentWidth = parseInt($progressBar.css('width'));
var allowedWidth = parseInt($progress.css('width'));
var addedWidth = currentWidth + parseInt($quantity);
if (addedWidth > allowedWidth) {
addedWidth = allowedWidth;
}
var progress = (addedWidth / allowedWidth) * 100;
$progressBar.animate({width: progress + '%' }, 100);
});


$('#content .image-additional img').on('click',function(event) {
    var img_wrap = $(this).closest( ".countdown-images" );
    $(img_wrap).find('.special-image img').attr('src',$(event.target).data('image-large-src'));
    $('.selected').removeClass('selected');
    $(event.target).addClass('selected');
    $(img_wrap).find('.product-image img').prop('src', $(event.currentTarget).data('image-large-src'));
});

	  	var ttspecialcountdown = $('#content .ae-special-countdown .special-countdown.products-carousel').owlCarousel({
				items : 1, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					320:{
						items:1
					},
					481:{
						items:1
					},
					1200:{
						items:1
					},
					1400:{
						items:1
					}
				}
		});
		

$('#column-right .ae-special-countdown .special-countdown.products-carousel').owlCarousel({
	items:1,
	itemsDesktop: [1199,1],
	itemsDesktopSmall: [991,1],
	itemsTablet: [767,1],
	itemsMobile: [480,1],
	navigation: true,
	autoPlay: true,
	stopOnHover  : true,
	pagination: false
});
$('#column-left .ae-special-countdown .special-countdown.products-carousel').owlCarousel({
	items:1,
	itemsDesktop: [1199,1],
	itemsDesktopSmall: [991,1],
	itemsTablet: [767,1],
	itemsMobile: [480,1],
	navigation: true,
	autoPlay: true,
	stopOnHover  : true,
	pagination: false
});

	  	var ttspecialadditional = $('#content .special-additional-images').owlCarousel({
				items : 3, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					320:{
						items:2
					},
					480:{
						items:3
					},
					544:{
						items:2
					},
					768:{
						items:3
					},
					992:{
						items:2
					},
					1400:{
						items:3
					}
				}
		});

// Custom Navigation Events
$(".additional-next").click(function(){
	$(".additional-images").trigger('owl.next');
})
$(".additional-prev").click(function(){
	$(".additional-images").trigger('owl.prev');
})
$(".additional-images-container .customNavigation").addClass('owl-navigation');

$("#column-left .ae-special-countdown .item-countdown, #column-right .ae-special-countdown .item-countdown").each(function() {
    $(this).insertAfter($(this).parent().parent().parent().find(".button-group"));
});
/*-------------------------- Countdown js End ------------------------------ */
/*-------------------------- latest js Start ------------------------------ */
$('.bestseller-carousel .product-thumb').each(function(){
var $desc = jQuery(this).find('.thumb-description .progress');
var $qty = jQuery(this).find('.quantity');
var $pbar = jQuery(this).find('.progress-bar');
var $progress = $desc;
var $progressBar = $pbar;
var $quantity = $qty.html();
var currentWidth = parseInt($progressBar.css('width'));
var allowedWidth = parseInt($progress.css('width'));
var addedWidth = currentWidth + parseInt($quantity);
if (addedWidth > allowedWidth) {
addedWidth = allowedWidth;
}
var progress = (addedWidth / allowedWidth) * 100;
$progressBar.animate({width: progress + '%' }, 100);
});


	  	var ttbestsellerproduct = $('#content .bestseller-carousel .bestseller-items.products-carousel').owlCarousel({
				items : cbi, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					544:{
						items:1
					},
					768:{
						items:2
					},
					1199:{
						items:2
					},
					1500:{
						items:cbi
					}
				}
		});
		
	  	var ttlatestproduct = $('.ae-latest-product .latest-carousel .latest-items.products-carousel').owlCarousel({
				items : 1, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					481:{
						items:2
					},
					768:{
						items:3
					},
					992:{
						items:1
					},
					1310:{
						items:1
					}
				}
		});

		
	  	var ttfeatureproduct = $('.common-home #content .featured-carousel .featured-items.products-carousel').owlCarousel({
				items : 5, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					410:{
						items:2
					},
					768:{
						items:3
					},
					1250:{
						items:4
					},
					1650:{
						items:5
					}
				}
		});


	  	var ttspecialtab = $('.special-carousel.products-list .special-items.products-carousel').owlCarousel({
				items : 1, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					544:{
						items:1
					},
					768:{
						items:2
					},
					992:{
						items:1
					},
					1500:{
						items:1
					}
				}
			});


	  	var ttcategorytab = $('#content .ae-cat-carousel .aecategory-tab.products-carousel').owlCarousel({
				items : cwi, //1 items above 1000px browser width
				nav : true,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					410:{
						items:2
					},
					768:{
						items:3
					},
					992:{
						items:3
					},
					1250:{
						items:4
					},
					1650:{
						items:cwi
					}
				}
			});


	  	var cat_feature = $('.category-feature.ae-carousel').owlCarousel({
				items : 3, //1 items above 1000px browser width
				nav : true,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					360:{
						items:2
					},
					992:{
						items:2
					},
					1250:{
						items:3
					},
					1700:{
						items:3
					}
				}
			});


      // Custom Navigation Events
	  $(".aefcat_prev").click(function(){
        cat_feature.trigger('owl.prev');
      })
      $(".aefcat_next").click(function(){
        cat_feature.trigger('owl.next');
      })
	  
	jQuery('.ae-category-featured .aefcat-items .category-feature .item').on('click', 'content', function() {
        jQuery('.ae-category-featured .aefcat-items .category-feature .item.active').removeClass('active');
        jQuery(this).addClass('active');
    });

	var ttrelatedproduct = $('.related-carousel .related-items.products-carousel').owlCarousel({
				items : cRi, //1 items above 1000px browser width
				nav : false,
				dots : false,
				loop: false,
				autoplay:false,	
				rtl:false,
				responsive: {
					0:{
						items:1
					},
					410:{
						items:2
					},
					768:{
						items:3
					},
					1301:{
						items:4
					},
					1600:{
						items:cRi
					}
				}
			});
/*-------------------------- latest js End ------------------------------ */
	$(".aepopupclose").click(function() {
        $("#dialog").removeClass("in");
        $("#dialog").css('display', 'none');
        $(".b-modal.__b-popup1__").remove();
        $(".newletter-popup").css('display', 'none');
    });

// product Carousel

		initialize_owl($('#owl1'));
	
		$('a[href="#tab-featured-0"]').on('shown.bs.tab', function () {
			initialize_owl($('#owl1'));
		}).on('hide.bs.tab', function () {
			destroy_owl($('#owl1'));
		});

		initialize_owl($('#owl2'));

		$('a[href="#tab-latest-0"]').on('shown.bs.tab', function () {
			initialize_owl($('#owl2'));
		}).on('hide.bs.tab', function () {
			destroy_owl($('#owl2'));
		});

		initialize_owl($('#owl3'));

		$('a[href="#tab-bestseller-0"]').on('shown.bs.tab', function () {
			initialize_owl($('#owl3'));
		}).on('hide.bs.tab', function () {
			destroy_owl($('#owl3'));
		});

		initialize_owl($('#owl4'));

		$('a[href="#tab-special-0"]').on('shown.bs.tab', function () {
			initialize_owl($('#owl4'));
		}).on('hide.bs.tab', function () {
			destroy_owl($('#owl4'));
		});


/* ---------------- start ontheme sub cat more menu ----------------------*/
 	$('.ae-category-featured .content > .caption .cat-sub > ul').each(function(){		
		var subcat = $(this).find('li');	
		var max_link = 5;	
		if ( subcat.length > max_link ) {
		$(this).append('<li class="more"><div class="more-menu"><span class="categories">More</span></div></li>');
		}
			subcat.each(function(j) {
			if ( j >= max_link ) { 
				$(this).css('display', 'none');
				$(this).addClass('disable');
			}
			});
		});
		
 		$('.ae-category-featured .content > .caption .cat-sub > ul .more-menu').each(function() {
		var subcatd = $(this).parent().parent().find('li.disable');
		var max_link = 2;
		var subcat = $(this).parent().parent().find('li');
		$(this).click(function() {
		if ($(this).hasClass('active')) {
		subcat.each(function(j) {
		if ( j >= max_link ) {
			if(subcat.hasClass('disable')){
			subcatd.slideUp(200);
			}
		}
		});
		$(this).removeClass('active');
		$(this).html('<span class="categories">More</span>');
		} else {
		subcat.each(function(j) {
		if ( j >= max_link  ) {
			subcat.slideDown(200);
		}
		});
		$(this).addClass('active');
		$(this).html('<span class="categories">Less</span>');
		}
		});				
		});
/* ---------------- End ontheme sub cat more menu ----------------------*/

/* Go to Top JS START */
	$(function () {
		$(window).scroll(function () {
			if ($(this).scrollTop() > 150) {
				$('.goToTop').fadeIn();
			} else {
				$('.goToTop').fadeOut();
			}
		});
	
		// scroll body to 0px on click
		$('.goToTop').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 1000);
			return false;
		});
	});
	/* Go to Top JS END */

	/* Active class in Product List Grid START */
$(".product-layout.product-list .product-thumb .image .rating").each(function(){
	$(this).insertAfter($(this).parent().parent().parent().find(".thumb-description .caption .product-description > h4"));
});
$(".product-layout.product-grid .product-thumb .thumb-description .caption .product-description > .rating").each(function(){
  $(this).appendTo($(this).parent().parent().parent().parent().parent().find(".image"));
});
$(".product-layout.product-sort .product-thumb .image .rating").each(function(){
	$(this).insertAfter($(this).parent().parent().parent().find(".thumb-description .caption .product-description > h4"));
});

$(".product-layout.product-list .product-thumb .image .aeproducthover").each(function(){
  $(this).appendTo($(this).parent().parent().find(".thumb-description .caption"));
});
$(".product-layout.product-grid .product-thumb .thumb-description .caption .aeproducthover").each(function(){
  $(this).appendTo($(this).parent().parent().parent().parent().find(".image"));
});
$(".product-layout.product-sort .product-thumb .image .aeproducthover").each(function(){
	$(this).appendTo($(this).parent().parent().find(".thumb-description .caption"));
});

	$('#list-view').click(function() {
		$('#grid-view').removeClass('active');
		$('#list-view').addClass('active');
		$('#content .row > .product-list .product-thumb .image').attr('class', 'image col-xs-5 col-sm-4 col-md-3');
		$('#content .row > .product-list .product-thumb .thumb-description').attr('class', 'thumb-description col-xs-7 col-sm-8 col-md-9');
		//$(".product-layout.product-list .product-thumb .button-group .btn-cart").removeAttr('data-original-title'); /* for remove tooltrip */
		$(".product-layout.product-list .product-thumb .image .rating").each(function(){
			$(this).insertAfter($(this).parent().parent().parent().find(".thumb-description .caption .product-description > h4"));
		});
		$(".product-layout.product-list .product-thumb .image .aeproducthover").each(function(){
		    $(this).appendTo($(this).parent().parent().find(".thumb-description .caption"));
		});

	});
	$('#grid-view').click(function() {
		$('#list-view').removeClass('active');
		$('#grid-view').addClass('active');
		$('#content .row > .product-grid .product-thumb .image').attr('class', 'image col-xs-12');
		$('#content .row > .product-grid .product-thumb .thumb-description').attr('class', 'thumb-description col-xs-12');
		//$(".product-layout.product-grid .product-thumb .button-group .btn-cart").attr('data-original-title','Add to cart');/* for add tooltrip */	
		$(".product-layout.product-grid .product-thumb .thumb-description .caption .product-description > .rating").each(function(){
		  $(this).appendTo($(this).parent().parent().parent().parent().parent().find(".image"));
		});
		$(".product-layout.product-grid .product-thumb .thumb-description .caption .aeproducthover").each(function(){
		  $(this).appendTo($(this).parent().parent().parent().parent().find(".image"));
		});
	});

	$('#short-view').click(function() {
		$('#list-view').removeClass('active');
		$('#grid-view').removeClass('active');
		$('#short-view').addClass('active');
		$('#content .row > .product-sort .product-thumb .image').attr('class', 'image col-xs-3 col-sm-3 col-md-2');
		$('#content .row > .product-sort .product-thumb .thumb-description').attr('class', 'thumb-description col-xs-9 col-sm-9 col-md-10');
		//$(".product-layout.product-sort .product-thumb .button-group .btn-cart").attr('data-original-title','Add to cart');/* for add tooltrip */	
		$(".product-layout.product-sort .product-thumb .image .rating").each(function(){
			$(this).insertAfter($(this).parent().parent().parent().find(".thumb-description .caption .product-description > h4"));
		});
		$(".product-layout.product-sort .product-thumb .image .aeproducthover").each(function(){
			$(this).appendTo($(this).parent().parent().find(".thumb-description .caption"));
		});
	});

		 if (localStorage.getItem('display') == 'grid') {
			jQuery('#grid-view').trigger('click');
		  } else if (localStorage.getItem('display') == 'list'){
			jQuery('#list-view').trigger('click');
		  }
		  else if (localStorage.getItem('display') == 'sort'){
			jQuery('#short-view').trigger('click');
		  }
		  else{
			jQuery('#grid-view').trigger('click');
		  }  
	/* Active class in Product List Grid END */

});


// Documnet.ready() over....
function initialize_owl(el) {
    el.owlCarousel({
        items : ci, //1 items above 1000px browser width
		nav : false,
		dots : false,
		loop: false,
		autoplay:false,	
		autoplayHoverPause:true,
		responsive: {
			1500: {
				items: ci
			},
			1200: {
				items: 4
			},
			768: {
				items: 3
			},
			320: {
				items: 2
			},
			0:   {
				items:1
			}
		}
    });

	// Custom Navigation Events

$(".customNavigation .next").click(function(){
	$(this).parent().parent().find(".products-carousel").trigger('next.owl.carousel',[700]);
})
$(".customNavigation .prev").click(function(){
	$(this).parent().parent().find(".products-carousel").trigger('prev.owl.carousel',[700]);
})
$(".products-list .customNavigation").addClass('owl-navigation');

}

function destroy_owl(el) {
    if(typeof el.data('owlCarousel') != 'undefined') {
		el.data('owlCarousel').destroy();
		el.removeClass('owl-carousel');
	}
}

/* ------ left-column  sticky js ---*/
function stickyleft() {
   if ($(document).width() <= 1199) {
			jQuery('#column-left, #column-right').theiaStickySidebar({
	  additionalMarginBottom: 30,
	  additionalMarginTop: 60
	});
		} else if ($(document).width() >= 1200) {
			jQuery('#column-left, #column-right').theiaStickySidebar({
	  additionalMarginBottom: 30,
	  additionalMarginTop: 30
	});
		}
	}
	$(document).ready(function() {
		stickyleft();
	});
	$(window).resize(function() {
		stickyleft();
	});
/* ---  end left-column stick js---*/
/*--------- Start sameheight JS -------------*/

	function sameHeight(){
	if ($(document).width() >= 992){	
		var specialHeight = $(".ae-special-countdown .aespecial-products-innner").height();
		var latestHeight = $(".ae-latest-product .aelatest-products-innner").height();
		if(specialHeight > latestHeight) {
		$(".ae-latest-product .aelatest-products-innner").height(specialHeight);
		} else {
		$(".ae-special-countdown .aespecial-products-innner").height(latestHeight);
		}
	}
	}
	
	$(window).resize(function(){sameHeight();});
	$(window).load(function(){sameHeight();});


/* ------------ End sameheight JS --------------*/
/* FilterBox - Responsive Content*/
function optionFilter(){
	if ($(window).width() <= 991) {
		$('#column-left .option-filter-box').appendTo('.row #content .category-description');
		$('#column-right .option-filter-box').appendTo('.row #content .category-description');
	} else {
		$('.row #content .category-description .option-filter-box').appendTo('#column-left .option-filter');
		$('.row #content .category-description .option-filter-box').appendTo('#column-right .option-filter');
	}
}
$(document).ready(function(){ optionFilter(); });
$(window).resize(function(){ optionFilter(); });
/*category filter js*/

function footerToggle() {
	
	if($( window ).width() < 992) {
		$("footer .footer-column h5").addClass( "toggle" );
		$("footer .footer-column ul").css( 'display', 'none' );
		$("footer .footer-column.active ul").css( 'display', 'block' );
		$("footer .footer-column h5.toggle").unbind("click");
		$("footer .footer-column h5.toggle").click(function() {
			$(this).parent().toggleClass('active').find('ul.list-unstyled').slideToggle( "fast" );
		});
		
		$("#ttcmsfooter .about-title").addClass( "toggle" );
		$("#ttcmsfooter .list-unstyled").css( 'display', 'none' );
		$("#ttcmsfooter .list-unstyled.active").css( 'display', 'block' );
		$("#ttcmsfooter .about-title.toggle").unbind("click");
		$("#ttcmsfooter .about-title.toggle").click(function() {
		$(this).parent().toggleClass('active').find('.list-unstyled').slideToggle( "fast" );
			
		});
		
		$("#column-left .panel-heading").addClass( "toggle" );
		$("#column-left .list-group").css( 'display', 'none' );
		$("#column-left .panel-default.active .list-group").css( 'display', 'block' );
		$("#column-left .panel-heading.toggle").unbind("click");
		$("#column-left .panel-heading.toggle").click(function() {
		$(this).parent().toggleClass('active').find('.list-group').slideToggle( "fast" );
		});
		
		$("#column-left .box-heading").addClass( "toggle" );
		$("#column-left .products-carousel").css( 'display', 'none' );
		$("#column-left .products-list.active .products-carousel").css( 'display', 'block' );
		$("#column-left .box-heading.toggle").unbind("click");
		$("#column-left .box-heading.toggle").click(function() {
		$(this).parent().toggleClass('active').find('.products-carousel').slideToggle( "fast" );
		});
		
		$("#column-right .panel-heading").addClass( "toggle" );
		$("#column-right .list-group").css( 'display', 'none' );
		$("#column-right .panel-default.active .list-group").css( 'display', 'block' );
		$("#column-right .panel-heading.toggle").unbind("click");
		$("#column-right .panel-heading.toggle").click(function() {
		$(this).parent().toggleClass('active').find('.list-group').slideToggle( "fast" );
		});
		
		
		$("#ttcmstestimonial .title_block").addClass( "toggle" );
		$("#ttcmstestimonial #tttestimonial-carousel").css( 'display', 'none' );
		$("#ttcmstestimonial .aetestimonial-inner.active tttestimonial-carousel").css( 'display', 'block' );
		$("#ttcmstestimonial .title_block.toggle").unbind("click");
		$("#ttcmstestimonial .title_block.toggle").click(function() {
		$(this).parent().toggleClass('active').find('#tttestimonial-carousel').slideToggle( "fast" );
		});
		
		$("#column-right .box-heading").addClass( "toggle" );
		$("#column-right .products-carousel").css( 'display', 'none' );
		$("#column-right .products-list.active .products-carousel").css( 'display', 'block' );
		$("#column-right .box-heading.toggle").unbind("click");
		$("#column-right .box-heading.toggle").click(function() {
		$(this).parent().toggleClass('active').find('.products-carousel').slideToggle( "fast" );
		});
		
	} else {
		$("#ttcmsfooter .about-title.toggle").unbind("click");
		$("#ttcmsfooter .about-title").removeClass( "toggle" );
		$("#ttcmsfooter .list-unstyled").css( 'display', 'block' );
		
		$("footer .footer-column h5.toggle").unbind("click");
		$("footer .footer-column h5").removeClass('toggle');
		$("footer .footer-column ul.list-unstyled").css('display', 'block');
		
		$("#column-left .panel-heading").unbind("click");
		$("#column-left .panel-heading").removeClass( "toggle" );
		$("#column-left .list-group").css( 'display', 'block' );

		$("#column-left .box-heading").unbind("click");
		$("#column-left .box-heading").removeClass( "toggle" );
		$("#column-left .products-carousel").css( 'display', 'block' );
		
		$("#column-right .panel-heading").unbind("click");
		$("#column-right .panel-heading").removeClass( "toggle" );
		$("#column-right .list-group").css( 'display', 'block' );

		$("#ttcmstestimonial .title_block").unbind("click");
		$("#ttcmstestimonial .title_block").removeClass( "toggle" );
		$("#ttcmstestimonial #tttestimonial-carousel").css( 'display', 'block' );
		
		$("#column-right .box-heading").unbind("click");
		$("#column-right .box-heading").removeClass( "toggle" );
		$("#column-right .products-carousel").css( 'display', 'block' );
		
	}
}

$(document).ready(function() {footerToggle();});
$(window).resize(function() {footerToggle();});

/* Category List - Tree View */
function categoryListTreeView() {
	$(".category-treeview li.category-li").find("ul").parent().prepend("<div class='list-tree'></div>").find("ul").css('display','none');

	$(".category-treeview li.category-li.category-active").find("ul").css('display','block');
	$(".category-treeview li.category-li.category-active").toggleClass('active');
}
$(document).ready(function() {categoryListTreeView();});


/* Category List - TreeView Toggle */
function categoryListTreeViewToggle() {
	$(".category-treeview li.category-li .list-tree").click(function() {
		$(this).parent().toggleClass('active').find('ul').slideToggle();
	});
}
$(document).ready(function() {categoryListTreeViewToggle();});

function menuToggle() {
	if($( window ).width() < 992) {
		$(".main-category-list ul.dropmenu li.ae-Sub-List > i").remove();
		$(".main-category-list ul.dropmenu .dropdown-menu ul li.dropdown-inner > i").remove();

		$(".main-category-list ul.dropmenu > li.ae-Sub-List > a").after("<i class='material-icons'></i>");
		$(".menu-category > li.ae-Sub-List .dropdown-inner ul > li.dropdown a.single-dropdown").after("<i class='material-icons'></i>");
		
		$(".main-category-list .ae-panel-heading.current-open").unbind("click");
		$('.main-category-list .ae-panel-heading.current-open').click(function(){
			$(this).parent().toggleClass('aeactive').find('ul.dropmenu').slideToggle( "fast" );
		});
		$(".main-category-list ul.dropmenu > li.ae-Sub-List > i").unbind("click");
		$(".main-category-list ul.dropmenu > li.ae-Sub-List > i").click(function() {
			$(this).parent().toggleClass("active").find("ul").first().slideToggle();
		});
		
		$(".menu-category > li.ae-Sub-List .dropdown-inner ul > li.dropdown > i").unbind("click");
		$(".menu-category > li.ae-Sub-List .dropdown-inner ul > li.dropdown > i").click(function() {
			$(this).parent().toggleClass("active").find(".dropdown-menu").slideToggle();
		});
	}
	else {
		$(".menu-category > li.ae-Sub-List .dropdown-inner ul > li.dropdown > i").unbind("click");
		$(".main-category-list").removeClass('ttactive');
		$(".menu-category ul.dropmenu li.ae-Sub-List > i").remove();
		$(".menu-category > li.ae-Sub-List .dropdown-inner ul > li.dropdown > i").remove();
	}
}
$(document).ready(function() {menuToggle();});
$( window ).resize(function(){menuToggle();});

/* Animate effect on Review Links - Product Page */
$(".product-total-review, .product-write-review").click(function() {
    $('html, body').animate({ scrollTop: $(".product-tabs").offset().top }, 1000);
});

function responsivecolumn()
{
	if ($(window).width() <= 991)
	{
		$('#page > .container > .page-bg > .row > #column-left').appendTo('#page > .container > .page-bg > .row');
		$('#page > .container > .page-bg > .row > #column-right').appendTo('#page > .container > .page-bg > .row');
		
		$('#page > .container-fluid > .page-bg > .row > #column-left').appendTo('#page > .container-fluid > .page-bg > .row');
		$('#page > .container-fluid > .page-bg > .row > #column-right').appendTo('#page > .container-fluid > .page-bg > .row');
		
		$('#page > .fullbg > .container.main-bg > .content-bottom > #column-left').appendTo('#page > .fullbg > .container.main-bg');
		$('#page > .fullbg > .container.main-bg > .content-bottom > #column-right').appendTo('#page > .fullbg > .container.main-bg');
	}
	else if($(window).width() >= 992)
	{
		$('#page > .container > .page-bg > .row > #column-left').prependTo('#page > .container > .page-bg > .row');
		$('#page > .container > .page-bg > .row > #column-right').appendTo('#page > .container > .page-bg > .row');
		
		$('#page > .container-fluid > .page-bg > .row > #column-left').prependTo('#page > .container-fluid > .page-bg > .row');
		$('#page > .container-fluid > .page-bg > .row > #column-right').appendTo('#page > .container-fluid > .page-bg > .row');
		
		$('#page > .fullbg > .container.main-bg > #column-left').prependTo('#page > .fullbg > .container.main-bg > .content-bottom');
		$('#page > .fullbg > .container.main-bg > #column-right').appendTo('#page > .fullbg > .container.main-bg > .content-bottom');
	}
}
$(window).resize(function(){responsivecolumn();});
$(window).ready(function(){responsivecolumn();});
/*category filter js end*/
