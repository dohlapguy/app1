import 'package:cloud_firestore/cloud_firestore.dart';

import '../models.dart';

class ShopRepo {
  final CollectionReference _shopCollection =
      FirebaseFirestore.instance.collection('shops');

  Future<List<ShopModel>> getShops() async {
    try {
      QuerySnapshot querySnapshot = await _shopCollection.get();
      List<ShopModel> shops =
          querySnapshot.docs.map((doc) => ShopModel.fromSnapshot(doc)).toList();
      return shops;
    } catch (e) {
      print('Error getting shops: $e');
      throw e;
    }
  }

  Future<ShopModel?> getShopDetails(String shopId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('shops')
          .doc(shopId)
          .get();
      if (doc.exists) {
        final shopData = doc.data();
        return ShopModel.fromSnapshot(doc);
      }
      return null; // Return null if the shop with the specified ID doesn't exist.
    } catch (e) {
      print('Error getting shop: $e');
      return null;
    }
  }
}
