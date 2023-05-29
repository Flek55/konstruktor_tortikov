import 'dart:convert';

FavoriteProduct productsFromJson(String str) => FavoriteProduct.fromJson(json.decode(str));

String productsToJson(FavoriteProduct data) => json.encode(data.toJson());

class FavoriteProduct {
  String product_id;

  FavoriteProduct({
    required this.product_id,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) => FavoriteProduct(
    product_id: json["product_id"]
  );

  Map<String, dynamic> toJson() => {
    "product_id": product_id,
  };
}