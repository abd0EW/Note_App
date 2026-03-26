// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product1 productFromJson(String str) => Product1.fromJson(json.decode(str));

String productToJson(Product1 data) => json.encode(data.toJson());

class Product1 {
  int? id;
  String? title;
  double? price;
  double? discountPercentage;
  int? stock;
  double? rating;
  List<String>? images;
  String? thumbnail;
  String? description;
  String? brand;
  String? category;

  Product1({
    this.id,
    this.title,
    this.price,
    this.discountPercentage,
    this.stock,
    this.rating,
    this.images,
    this.thumbnail,
    this.description,
    this.brand,
    this.category,
  });

  factory Product1.fromJson(Map<String, dynamic> json) => Product1(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    discountPercentage: json["discountPercentage"]?.toDouble(),
    stock: json["stock"],
    rating: json["rating"]?.toDouble(),
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x)),
    thumbnail: json["thumbnail"],
    description: json["description"],
    brand: json["brand"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "discountPercentage": discountPercentage,
    "stock": stock,
    "rating": rating,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "thumbnail": thumbnail,
    "description": description,
    "brand": brand,
    "category": category,
  };
}
