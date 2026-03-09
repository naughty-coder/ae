$(document).ready(function() {
    $('.sub-menu-container').each(function() {
        var total_cols = 0;
        $(this).find('.sub-item2-content').each(function() {
            var cols = parseFloat($(this).data('cols'));
            if (total_cols == 0) {
                $(this).css('clear', 'left')
            }
            total_cols += cols;
            if (total_cols > 12) {
                $(this).css('clear', 'left');
                total_cols = cols
            }
            if (total_cols == 12) {
                total_cols = 0
            }
        })
    });
    $('.vertical-menu .ae-menu-bar').click(function() {
        var effect = $(this).closest('.ae-menu').find('.menu-effect').val();
        if (effect == "none") {
            $('.vertical-menu .ul-top-items').toggle()
        }
        if (effect == "fade") {
            $('.vertical-menu .ul-top-items').fadeToggle()
        }
        if (effect == "slide") {
            $('.vertical-menu .ul-top-items').slideToggle()
        }
    });
    $('.a-plus').click(function() {
        var effect = $(this).closest('.ae-menu').find('.menu-effect').val();
        if (effect == "none") {
            $('.li-plus').hide();
            $('.over').show()
        }
        if (effect == "fade") {
            $('.li-plus').fadeOut();
            $('.over').fadeIn()
        }
        if (effect == "slide") {
            $('.li-plus').slideUp();
            $('.over').slideDown()
        }
    });
    $('.a-minus').click(function() {
        var effect = $(this).closest('.ae-menu').find('.menu-effect').val();
        if (effect == "none") {
            $('.over').hide();
            $('.li-plus').show()
        }
        if (effect == "fade") {
            $('.over').fadeOut();
            $('.li-plus').fadeIn()
        }
        if (effect == "slide") {
            $('.over').slideUp();
            $('.li-plus').slideDown()
        }
    });
    $('.ae-menu .sub-menu-container').each(function() {
        var menu = $('.ae-menu').offset();
        var dropdown = $(this).parent().offset();
        var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('.ae-menu').outerWidth());
        if (i > 0) {
            $(this).css('margin-left', '-' + (i + 10) + 'px')
        }
    })

/* ---------------- start Templatetrip link more menu ----------------------*/
	
$(document).ready(function() {
$('.ae-panel-heading').click(function() {

if($(this).hasClass('current-close')) {
$(this).addClass("current-open");
$(this).removeClass("current-close");
$('.ae-menu ul.ul-top-items').slideToggle("2000");
} else if($(this).hasClass('current-open')) {
$(this).addClass("current-close");
$(this).removeClass("current-open");
$('.ae-menu ul.ul-top-items').slideToggle("2000");
}

if($(this).hasClass('default-open') && !$('.header .header-bottom-block').hasClass('fixed')) {
$(this).addClass("current-close");
$(this).removeClass("default-open");
$('.ae-menu ul.ul-top-items').slideToggle("2000");
}	
if($(this).hasClass('default-open') && $('.header .header-bottom-block').hasClass('fixed')) {
$(this).addClass("current-open");
$(this).removeClass("default-open");
$('.ae-menu ul.ul-top-items').slideDown("2000");
}

});
});/* ---------------- End Templatetrip link more menu ----------------------*/

/* ---------------- start Templatetrip more menu ----------------------*/
		if($(document).width() <= 1500){
		var max_elem = 5;
		} else if ($(document).width() >= 1599){
		var max_elem = 9;
		}
		var menu = $('.main-category-list .ae-menu  ul.ul-top-items > li');	
		if ( menu.length > max_elem ) {
		$('.main-category-list .ae-menu ul.ul-top-items').append('<li class="more"><div class="more-menu"><span class="categories">More</span></div></li>');
		}
		
		$('.main-category-list .ae-menu ul.ul-top-items .more-menu').click(function() {
		if ($(this).hasClass('active')) {
		menu.each(function(j) {
		if ( j >= max_elem ) {
		$(this).slideUp(200);
		}
		});
		$(this).removeClass('active');
		$('.more-menu').html('<span class="categories">More</span>');
		} else {
		menu.each(function(j) {
		if ( j >= max_elem  ) {
		$(this).slideDown(200);
		}
		});
		$(this).addClass('active');
		$('.more-menu').html('<span class="categories">Less</span>');
		}
		});
		
		menu.each(function(j) {
		if ( j >= max_elem ) { 
		$(this).css('display', 'none');
		}
		});
		
	jQuery('.main-category-list .ae-panel-heading').click(function(event) {
        jQuery(this).toggleClass('active');
        jQuery("body #page").toggleClass("menu_hover");
        event.stopPropagation();
        jQuery('.header-bottom-block .main-category-list .ae-menu-bar ul.ul-top-items').slideToggle("2000");
		 jQuery('.full-header .main-category-list .ae-menu-bar ul.ul-top-items').slideToggle("2000");
    });


/* ---------------- End Templatetrip more menu ----------------------*/
});

function menuToggle() {
    if ($(window).width() < 992) {
		$('.full-header .container .header-right').appendTo('.header-bottom-block .container .header-bottom #header-bottom');
        $(".main-category-list ul.ul-top-items li.mega-menu > i").remove();
        $(".main-category-list ul.ul-top-items li.more-menu > i").remove();
        $(".main-category-list .ae-panel-heading.current-open").unbind("click");
        $('.main-category-list .ae-panel-heading.current-open').click(function() {
            $(this).parent().toggleClass('aeactive').find('ul.ul-top-items').slideToggle("fast")
        });
        $(".main-category-list ul.ul-top-items > li.mega-menu > a").after("<i class='material-icons'></i>");
        $(".main-category-list ul.ul-top-items > li.more-menu > a").after("<i class='material-icons'></i>");
        $(".main-category-list ul.ul-top-items > li.li-top-item > i").unbind("click");
        $(".main-category-list ul.ul-top-items > li.li-top-item > i").click(function() {
            $(this).parent().toggleClass("active").find(".sub-menu-container").first().slideToggle()
        })
    } else {
		$('.header-bottom-block .container .header-bottom #header-bottom .header-right').appendTo('.full-header .container');
       // $(".main-category-list .horizontal-menu ul.ul-top-items").css('display', 'block');
        $(".main-category-list ul.ul-top-items li.li-top-item > i").unbind("click");
        $(".main-category-list ul.ul-top-items li.li-top-item > i").removeClass("active")
    }
}
$(document).ready(function() {
    menuToggle()
});
$(window).resize(function() {
    menuToggle()
});