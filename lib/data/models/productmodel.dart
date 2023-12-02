import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final String shopId;
  final String shopName;

  ProductModel({
    required this.shopName,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.shopId,
  });

  // Factory method to create a Product instance from Firestore DocumentSnapshot
  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ProductModel(
      id: snapshot.id,
      title: data['title'],
      description: data['description'],
      price: data['price'].toDouble(),
      discountPercentage: data['discountPercentage'].toDouble(),
      rating: data['rating'].toDouble(),
      stock: data['stock'] as int,
      brand: data['brand'],
      category: data['category'],
      thumbnail: data['thumbnail'],
      images: List<String>.from(data['images']),
      shopId: data['shopId'],
      shopName: data['shopName'],
    );
  }

  ProductModel copyWith(
      {String? title,
      String? description,
      double? price,
      double? discountPercentage,
      double? rating,
      int? stock,
      String? brand,
      String? category,
      String? thumbnail,
      List<String>? images,
      String? shopId,
      String? shopName}) {
    return ProductModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
    );
  }
}
