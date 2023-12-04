import '../../domain/entities/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel extends Product {
  const ProductModel({
    required String shopName,
    required String id,
    required String title,
    required String description,
    required double price,
    required double discountPercentage,
    required double rating,
    required int stock,
    required String brand,
    required String category,
    required String thumbnail,
    required List<String> images,
    required String shopId,
  }) : super(
            shopName: shopName,
            id: id,
            title: title,
            description: description,
            price: price,
            discountPercentage: discountPercentage,
            rating: rating,
            stock: stock,
            brand: brand,
            category: category,
            thumbnail: thumbnail,
            images: images,
            shopId: shopId);

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
