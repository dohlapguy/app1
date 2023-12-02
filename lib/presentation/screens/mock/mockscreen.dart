import 'dart:math';

import 'package:app1/data/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MockScreen extends StatelessWidget {
  const MockScreen({super.key});

  Future<List<ProductModel>> getpro(FilterProductModel filter) async {
    final categories =
        filter.category!.map((category) => category.name).toList();

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('category', whereIn: categories)
        // .where('price', isGreaterThanOrEqualTo: minPrice)
        // .where('price', isLessThanOrEqualTo: maxPrice)
        .get();

    final pro = querySnapshot.docs.map((doc) {
      return ProductModel.fromSnapshot(doc);
    }).toList();
    if (kDebugMode) {
      print(pro.map((e) => e.title));
    }
    return pro;
  }

  Future<void> changeProductCategories() async {
    final List<String> newCategories = [
      'Electronics',
      'Beauty',
      'Jewelry',
      'Accessories',
    ];

    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    final random = Random();

    for (final doc in querySnapshot.docs) {
      final newCategory = newCategories[random.nextInt(newCategories.length)];
      await doc.reference.update({'category': newCategory});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              changeProductCategories();
            },
            child: Text('f'),
          ),
          ElevatedButton(
            onPressed: () async {},
            child: Text('s'),
          )
        ],
      ),
    ));
  }
}
