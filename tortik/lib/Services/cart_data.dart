import 'dart:convert';

CartProduct productsFromJson(String str) => CartProduct.fromJson(json.decode(str));

String productsToJson(CartProduct data) => json.encode(data.toJson());

class CartProduct {
  String product_id;
  int amount;

  CartProduct({
    required this.product_id,
    required this.amount,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
      product_id: json["product_id"],
      amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": product_id,
    "amount": amount,
  };
}