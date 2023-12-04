import 'package:app1/core/error/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models.dart';

abstract class ShopDataSource {
  Future<ShopModel> getShopDetails(String shopId);
  Future<List<ShopModel>> getShops();
}

class ShopDataSourceImpl extends ShopDataSource {
  final CollectionReference _shopCollection =
      FirebaseFirestore.instance.collection('shops');

  @override
  Future<List<ShopModel>> getShops() async {
    try {
      QuerySnapshot querySnapshot = await _shopCollection.get();
      List<ShopModel> shops =
          querySnapshot.docs.map((doc) => ShopModel.fromSnapshot(doc)).toList();
      return shops;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting shops: $e');
      }
    }
    throw ServerException();
  }

  @override
  Future<ShopModel> getShopDetails(String shopId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('shops')
          .doc(shopId)
          .get();
      if (doc.exists) {
        return ShopModel.fromSnapshot(doc);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting shop: $e');
      }
    }
    throw ServerException();
  }

  Future<String?> getShopNameById(String shopId) async {
    try {
      DocumentSnapshot docSnapshot = await _shopCollection.doc(shopId).get();
      if (docSnapshot.exists) {
        String shopName = docSnapshot['title'];
        return shopName;
      } else {
        return null; // Shop not found with the given ID
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching shop name: $e');
      }
      return null; // Error occurred while fetching shop name
    }
  }
}
