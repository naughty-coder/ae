<?php
class ModelAccountWishlist extends Model {
	public function addWishlist($product_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$this->customer->getId() . "' AND product_id = '" . (int)$product_id . "'");

		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_wishlist SET customer_id = '" . (int)$this->customer->getId() . "', product_id = '" . (int)$product_id . "', date_added = NOW()");
	}

	public function deleteWishlist($product_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$this->customer->getId() . "' AND product_id = '" . (int)$product_id . "'");
	}

	// public function getWishlist() {
 //        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$this->customer->getId() . "'");

	// 	return $query->rows;
	// }

	public function getWishlist() {
	    // Проверяем, есть ли cookie
	    if (!isset($_COOKIE['wishlist'])) {
	        return [];
	    }

	    // Декодируем JSON из cookie
	    $wishlist = json_decode($_COOKIE['wishlist'], true);

	    // Защита: оставляем только целые положительные ID
	    if (!is_array($wishlist)) {
	        return [];
	    }

	    $wishlist_ids = array_filter($wishlist, function($id) {
	        return is_numeric($id) && (int)$id > 0;
	    });

	    // Приводим все к integer
	    $wishlist_ids = array_map('intval', $wishlist_ids);

	    return $wishlist_ids; // просто массив product_id
	}

	public function getTotalWishlist() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$this->customer->getId() . "'");

		return $query->row['total'];
	}
}
