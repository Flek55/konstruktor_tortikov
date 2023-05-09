import 'dart:convert';

Product productsFromJson(String str) => Product.fromJson(json.decode(str));

String productsToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String name;
  String price;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
  };
}