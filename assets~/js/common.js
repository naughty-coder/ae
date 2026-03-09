// #shoppingCart" data-bs-toggle="offcanvas" 	

var cart = {
	'add': function(product_id, quantity, callback) {
		$('#shoppingCart').addClass('loading');

		$.ajax({
			url: '/index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				
			},
			complete: function() {
				$('#shoppingCart').removeClass('loading');

				callback();
			},
			success: function(json) {
				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
			        $('#shoppingCart').html(json['popup_cart']);

			        if (json['count_products'] > 0) {
				        $('[href="#shoppingCart"] .count-notice').show();
				    } else {
				        $('[href="#shoppingCart"] .count-notice').hide();
				    }

					var cartCanvas = document.getElementById('shoppingCart');
					var offcanvas = new bootstrap.Offcanvas(cartCanvas);
					offcanvas.show();
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'update': function(key, quantity, callback) {
		$('#shoppingCart').addClass('loading');

		$.ajax({
			url: '/index.php?route=checkout/cart/edit',
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				
			},
			complete: function() {
				$('#shoppingCart').removeClass('loading');

				callback();
			},
			success: function(json) {
				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
			        $('#shoppingCart').html(json['popup_cart']);

			        if (json['count_products'] > 0) {
				        $('[href="#shoppingCart"] .count-notice').show();
				    } else {
				        $('[href="#shoppingCart"] .count-notice').hide();
				    }


					// var cartCanvas = document.getElementById('shoppingCart');
					// var offcanvas = new bootstrap.Offcanvas(cartCanvas);
					// offcanvas.show();
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function(key, callback) {
		$('#shoppingCart').addClass('loading');

		$.ajax({
			url: '/index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				
			},
			complete: function() {
				$('#shoppingCart').removeClass('loading');

				callback();
			},
			success: function(json) {
				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
			        $('#shoppingCart').html(json['popup_cart']);

			        if (json['count_products'] > 0) {
				        $('[href="#shoppingCart"] .count-notice').show();
				    } else {
				        $('[href="#shoppingCart"] .count-notice').hide();
				    }

					// var cartCanvas = document.getElementById('shoppingCart');
					// var offcanvas = new bootstrap.Offcanvas(cartCanvas);
					// offcanvas.show();
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'clear': function(callback) {
		$('#shoppingCart').addClass('loading');

		$.ajax({
			url: '/index.php?route=checkout/cart/clear',
			type: 'post',
			dataType: 'json',
			beforeSend: function() {
				
			},
			complete: function() {
				$('#shoppingCart').removeClass('loading');

				callback();
			},
			success: function(json) {
				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
			        $('#shoppingCart').html(json['popup_cart']);

			        if (json['count_products'] > 0) {
				        $('[href="#shoppingCart"] .count-notice').show();
				    } else {
				        $('[href="#shoppingCart"] .count-notice').hide();
				    }

					// var cartCanvas = document.getElementById('shoppingCart');
					// var offcanvas = new bootstrap.Offcanvas(cartCanvas);
					// offcanvas.show();
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
};

var wishlist = {
	'cookie_name': 'wishlist',
	'expire_days': 365,

	// ========================
	// Внутренние методы
	// ========================

	'_getCookie': function() {
		var name = this.cookie_name + "=";
		var decoded = decodeURIComponent(document.cookie);
		var ca = decoded.split(';');

		for (var i = 0; i < ca.length; i++) {
			var c = ca[i].trim();
			if (c.indexOf(name) == 0) {
				return c.substring(name.length, c.length);
			}
		}
		return '';
	},

	'_setCookie': function(value) {
		var d = new Date();
		d.setTime(d.getTime() + (this.expire_days * 24 * 60 * 60 * 1000));
		var expires = "expires=" + d.toUTCString();
		document.cookie = this.cookie_name + "=" + encodeURIComponent(value) + ";path=/;expires=" + d.toUTCString() + ";domain=." + window.location.hostname.replace(/^www\./, '') + ";Secure";

        console.log(document.cookie);
	},

	'_getList': function() {
		var raw = this._getCookie();
		if (!raw) return [];

		try {
			var parsed = JSON.parse(raw);
			return Array.isArray(parsed) ? parsed : [];
		} catch (e) {
			return [];
		}
	},

	'_saveList': function(list) {
		this._setCookie(JSON.stringify(list));
	},

	// ========================
	// Публичные методы
	// ========================

	'add': function(product_id, callback) {

		if (!product_id) {
			if (typeof callback === 'function') callback(false, 'empty_id');
			return;
		}

		product_id = String(product_id);

		var list = this._getList();

		// контроль уникальности
		if (list.indexOf(product_id) === -1) {
			list.push(product_id);
			this._saveList(list);
		}

		if (typeof callback === 'function') callback(true, list);
	},

	'remove': function(product_id, callback) {

		if (!product_id) {
			if (typeof callback === 'function') callback(false, 'empty_id');
			return;
		}

		product_id = String(product_id);

		var list = this._getList();
		var index = list.indexOf(product_id);

		if (index !== -1) {
			list.splice(index, 1);
			this._saveList(list);
		}

		if (typeof callback === 'function') callback(true, list);
	},

	'toggle': function(product_id, callback) {
		if (!product_id) {
			if (typeof callback === 'function') callback(false, 'empty_id');
			return;
		}

		product_id = String(product_id);
		var list = this._getList();
		var index = list.indexOf(product_id);
		var state = 'added';

		if (index === -1) {
			list.push(product_id);
			state = 'added';
		} else {
			list.splice(index, 1);
			state = 'removed';
		}

		console.log(state);

		this._saveList(list);

		if (typeof callback === 'function') {
			callback(true, {
				state: state, // added | removed
				list: list
			});
		}
	},

	'get': function() {
		return this._getList();
	},

	'clear': function(callback) {
		this._saveList([]);
		if (typeof callback === 'function') callback(true, []);
	}
};

$(document).on('click', '[data-toggle-wishlist]', function (e) {
    e.preventDefault();

    const $btn = $(this);
    const productId = $btn.data('toggle-wishlist');

    wishlist.toggle(productId, function(success, result) {
        if (!success) return;

        // Находим иконку внутри кнопки
        const $icon = $btn.find('span.icon');
        const $tooltip = $btn.find('.tooltip');

        if (result.state === 'removed') {
            // Добавлено в избранное → сердце
            $icon.find('svg').remove();
            $icon.removeClass('icon-trash').addClass('icon-heart-2');
            $tooltip.text('В избранное');
        } else {
            // Удалено из избранного → корзина
            $icon.removeClass('icon-heart-2').addClass('icon-heart-full');
            $icon.append('<svg style="display:block" viewBox="0 0 1252 1024" fill="currentColor" width="19.25" height="16" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path transform="matrix(1, 0, 0, -1, 0, 960)" d="M625.823-64c-16.39 0-32.182 5.934-44.498 16.72-46.494 40.658-91.323 78.865-130.873 112.566l-0.202 0.176c-115.957 98.816-216.089 184.149-285.76 268.214C86.609 427.654 50.334 516.757 50.334 614.097c0 94.574 32.429 181.825 91.307 245.691 59.581 64.621 141.334 100.211 230.227 100.211 66.439 0 127.284-21.005 180.841-62.426 27.028-20.908 51.531-46.497 73.114-76.344 21.589 29.847 46.08 55.436 73.119 76.344 53.555 41.421 114.404 62.426 180.844 62.426 88.883 0 170.644-35.59 230.224-100.211 58.88-63.866 91.301-151.117 91.301-245.691 0-97.34-36.267-186.444-114.148-280.41-69.672-84.076-169.796-169.404-285.736-268.208-39.617-33.752-84.52-72.021-131.118-112.777C658.004-58.067 642.2-64.001 625.823-64z" /></svg>');

            $tooltip.text('Убрать из избранного');
        }
    });
});

$(document).on('click', '[data-clear-cart]', function (e) {
    e.preventDefault();

    const $btn = $(this);

    // защита от повторного клика
    if ($btn.hasClass('loading')) return;

    $btn.addClass('loading');

    // меняем иконку на spinner
    $btn.find('.icon').addClass('d-none');
    $btn.find('.spinner-loader').removeClass('d-none');

	cart.clear(function() {
		// возвращаем кнопку обратно
		setTimeout(function () {
	        $btn.removeClass('loading');
	        $btn.find('.icon').removeClass('d-none');
	        $btn.find('.spinner-loader').addClass('d-none');
        }, 500);
	});
});

$(document).on('click', '[data-add-to-cart]', function (e) {
    e.preventDefault();

    const $btn = $(this);

    // защита от повторного клика
    if ($btn.hasClass('loading')) return;

    $btn.addClass('loading');

    // меняем иконку на spinner
    $btn.find('.icon').addClass('d-none');
    $btn.find('.spinner-loader').removeClass('d-none');

	cart.add($(this).data('add-to-cart'), 1, function() {
		// возвращаем кнопку обратно
		setTimeout(function () {
	        $btn.removeClass('loading');
	        $btn.find('.icon').removeClass('d-none');
	        $btn.find('.spinner-loader').addClass('d-none');
        }, 500);
	});
});

$(document).on('click', '[data-add-to-cart-full]', function (e) {
    e.preventDefault();

    const $btn = $(this);

    // защита от повторного клика
    if ($btn.hasClass('loading')) return;

    $btn.addClass('loading');

    // меняем иконку на spinner
    $btn.find('.icon').addClass('d-none');
    $btn.find('.spinner-loader').removeClass('d-none');

    $('#shoppingCart').addClass('loading');

	$.ajax({
		url: '/index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {

		},
		complete: function() {
			$('#shoppingCart').removeClass('loading');

			setTimeout(function () {
		        $btn.removeClass('loading');
		        $btn.find('.icon').removeClass('d-none');
		        $btn.find('.spinner-loader').addClass('d-none');
	        }, 500);
		},
		success: function(json) {
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				if ($btn.data('redirect')) {
					window.location = $btn.data('redirect');
				} else {
			        $('#shoppingCart').html(json['popup_cart']);

			        if (json['count_products'] > 0) {
				        $('[href="#shoppingCart"] .count-notice').show();
				    } else {
				        $('[href="#shoppingCart"] .count-notice').hide();
				    }

					var cartCanvas = document.getElementById('shoppingCart');
					var offcanvas = new bootstrap.Offcanvas(cartCanvas);
					offcanvas.show();
				}
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});

$(document).on('click', '[data-delete-from-cart]', function (e) {
    e.preventDefault();

    const $btn = $(this);

    // защита от повторного клика
    if ($btn.hasClass('loading')) return;

    $btn.addClass('loading');

    // меняем иконку на spinner
    $btn.find('.icon').addClass('d-none');
    $btn.find('.spinner-loader').removeClass('d-none');

	cart.remove($(this).data('delete-from-cart'), function() {
		// возвращаем кнопку обратно
		setTimeout(function () {
	        $btn.removeClass('loading');
	        $btn.find('.icon').removeClass('d-none');
	        $btn.find('.spinner-loader').addClass('d-none');
        }, 500);
	});
});

$(document).on('change', '[data-update-cart]', function (e) {
    e.preventDefault();

    const $btn = $(this);

    // защита от повторного клика
    if ($btn.hasClass('loading')) return;

    $btn.addClass('loading');

	cart.update($(this).data('update-cart'), $(this).val(), function() {
		// возвращаем кнопку обратно
		setTimeout(function () {
	        $btn.removeClass('loading');
	        $btn.find('.icon').removeClass('d-none');
	        $btn.find('.spinner-loader').addClass('d-none');
        }, 500);
	});
});

$(document).on('click', '[data-decrement-value], [data-increment-value]', function (e) {
	e.preventDefault();
	
	if ($(this).data('decrement-value')) {
		$el = $($(this).data('decrement-value'));
		var value = parseInt($el.val(), 10);

		if (value > 1) {
            value = value - 1;
        }
	} else {
		$el = $($(this).data('increment-value'));
		var value = parseInt($el.val(), 10);

		if (value > -1) {
        	value = value + 1;
        }
	}

	$el.val(value).trigger('change');
});

// wishlist onload
var list = wishlist.get(); // текущий список избранного

$('[data-toggle-wishlist]').each(function() {
    var $btn = $(this);
    var productId = String($btn.data('toggle-wishlist'));

    if (list.indexOf(productId) !== -1) {
        var $icon = $btn.find('span.icon');
        var $tooltip = $btn.find('.tooltip');

        // Переключаем иконку и текст тултипа
        $icon.removeClass('icon-heart-2').addClass('icon-heart-full');
        $icon.append('<svg style="display:block" viewBox="0 0 1252 1024" fill="currentColor" width="19.25" height="16" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path transform="matrix(1, 0, 0, -1, 0, 960)" d="M625.823-64c-16.39 0-32.182 5.934-44.498 16.72-46.494 40.658-91.323 78.865-130.873 112.566l-0.202 0.176c-115.957 98.816-216.089 184.149-285.76 268.214C86.609 427.654 50.334 516.757 50.334 614.097c0 94.574 32.429 181.825 91.307 245.691 59.581 64.621 141.334 100.211 230.227 100.211 66.439 0 127.284-21.005 180.841-62.426 27.028-20.908 51.531-46.497 73.114-76.344 21.589 29.847 46.08 55.436 73.119 76.344 53.555 41.421 114.404 62.426 180.844 62.426 88.883 0 170.644-35.59 230.224-100.211 58.88-63.866 91.301-151.117 91.301-245.691 0-97.34-36.267-186.444-114.148-280.41-69.672-84.076-169.796-169.404-285.736-268.208-39.617-33.752-84.52-72.021-131.118-112.777C658.004-58.067 642.2-64.001 625.823-64z" /></svg>');

        if ($tooltip.length) {
            $tooltip.text('Убрать из избранного');
        }
    }
});























































