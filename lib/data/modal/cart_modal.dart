import 'dart:convert';

import 'package:manektech_demo/data/modal/product_modal.dart';

class CartModal {
  int cartId;
  ProductModal product;
  int qty;

  CartModal(this.cartId, this.product, this.qty);

  factory CartModal.fromDb(Map data) {
    return CartModal(data['id'], ProductModal.fromJson(json.decode(data['product'])), data['qty']);
  }
}
