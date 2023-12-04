import '../../core/error/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models.dart';

abstract class ProductDataSource {
  Future<ProductModel> getProductById(String productId);
  Future<List<ProductModel>> getProductsOfShop(
      {required String shopId,
      String? startAfterId,
      FilterProductModel? filter});
}

class ProductDataSourceImpl extends ProductDataSource {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  // Function to get all products from Firestore
  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _productsCollection.get();

      List<ProductModel> products =
          snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting products: $e');
      }
      return [];
    }
  }

  @override
  Future<List<ProductModel>> getProductsOfShop(
      {required String shopId,
      String? startAfterId,
      FilterProductModel? filter}) async {
    const int limit = 4;
    List<ProductModel> products = [];

    try {
      Query query =
          _productsCollection.where('shopId', isEqualTo: shopId).limit(limit);

      if (filter != null) {
        final categories =
            filter.category!.map((category) => category.name).toList();

        query = _productsCollection
            .where('shopId', isEqualTo: shopId)
            .where('category', whereIn: categories)
            .limit(limit);
      }

      if (startAfterId != null) {
        final startAfter = await _productsCollection.doc(startAfterId).get();
        final doc = startAfter;
        query = query.startAfterDocument(doc);
      }

      QuerySnapshot snapshot = await query.get();

      // Loop through the documents in the snapshot and convert them to Product objects
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        products.add(ProductModel.fromSnapshot(doc));
      }
      return products;
    } catch (e) {
      // Handle any errors that might occur during the fetching process
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String productId) async {
    try {
      DocumentSnapshot snapshot =
          await _productsCollection.doc(productId).get();

      return ProductModel.fromSnapshot(snapshot);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching product details: $e');
      }
      throw ServerException();
    }
  }
}
