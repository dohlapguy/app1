import 'package:cloud_firestore/cloud_firestore.dart';

import '../models.dart';

class ProductRepo {
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
      print('Error getting products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> getProductsOfShop(String shopId,
      {int limit = 4, String? startAfterId}) async {
    List<ProductModel> products = [];

    try {
      Query query =
          _productsCollection.where('shopId', isEqualTo: shopId).limit(limit);

      if (startAfterId != null) {
        final startAfter = await _productsCollection.doc(startAfterId).get();
        print(startAfter);
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
      print('Error fetching products: $e');
      return products;
    }
  }

  Future<ProductModel?> getProductById(String productId) async {
    try {
      DocumentSnapshot snapshot =
          await _productsCollection.doc(productId).get();

      if (snapshot.exists) {
        return ProductModel.fromSnapshot(snapshot);
      } else {
        // Product not found
        return null;
      }
    } catch (e) {
      print('Error fetching product details: $e');
      return null;
    }
  }
}
