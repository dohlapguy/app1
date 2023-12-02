import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

final CollectionReference productsCollection =
    FirebaseFirestore.instance.collection('products');
final CollectionReference shopsCollection =
    FirebaseFirestore.instance.collection('shops');

Future<void> updateShopNamesForAllProducts() async {
  try {
    QuerySnapshot productsQuery = await productsCollection.get();
    for (QueryDocumentSnapshot productDoc in productsQuery.docs) {
      String productId = productDoc.id;
      String shopId = productDoc['shopId'];

      DocumentSnapshot shopSnapshot = await shopsCollection.doc(shopId).get();
      if (shopSnapshot.exists) {
        String shopName = shopSnapshot['title'];
        await productsCollection.doc(productId).update({'shopName': shopName});
        if (kDebugMode) {
          print('Updated shopName for product $productId');
        }
      } else {
        if (kDebugMode) {
          print('Shop not found with shopId $shopId for product $productId');
        }
      }
    }
  } catch (e) {
    print('Error updating shopNames for products: $e');
  }
}

List<Map<String, dynamic>> mocks = [
  {
    'title': 'FashionHub',
    'thumbnail': 'https://via.placeholder.com/150',
    'rating': 4.8,
    'registered_date': '2023-07-24',
    'address': '123 Fashion Street, Cityville',
    'pin_code': '12345',
  },
  {
    'title': 'TechZone',
    'thumbnail': 'https://via.placeholder.com/150',
    'rating': 4.5,
    'registered_date': '2023-07-25',
    'address': '456 Tech Avenue, Technocity',
    'pin_code': '67890',
  },
  {
    'title': 'BeautyBoutique',
    'thumbnail': 'https://via.placeholder.com/150',
    'rating': 4.9,
    'registered_date': '2023-07-26',
    'address': '789 Beauty Boulevard, Glamourtown',
    'pin_code': '54321',
  },
  {
    'title': 'Bookworms',
    'thumbnail': 'https://via.placeholder.com/150',
    'rating': 4.2,
    'registered_date': '2023-07-27',
    'address': '321 Book Lane, Booksville',
    'pin_code': '98765',
  },
  {
    'title': 'SportZone',
    'thumbnail': 'https://via.placeholder.com/150',
    'rating': 4.6,
    'registered_date': '2023-07-28',
    'address': '567 Sports Road, Sportsville',
    'pin_code': '13579',
  },
  // Add more mock data here...
];

void insertMockShops() async {
  // Define your mock data
  List<Map<String, dynamic>> mockData = mocks;

  // Reference to the Firestore collection you want to insert data into
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('shops');

  try {
    for (var data in mockData) {
      await collectionRef.doc().set(data);
      print('Data for shop with ID ${data['id']} inserted successfully.');
    }
    print('All mock data inserted into Firestore.');
  } catch (error) {
    print('Error inserting mock data: $error');
  }
}

void addNewFieldsToProducts() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference productsCollection = firestore.collection('products');

  QuerySnapshot querySnapshot = await productsCollection.get();

  querySnapshot.docs.forEach((document) async {
    DocumentReference documentReference = document.reference;

    await documentReference.update({
      'discountPercentage': 0.0,
      'rating': 0.0,
      'stock': 0,
      'brand': 'Unknown',
      'category': 'Unknown',
    });
  });
}

Future<void> renameImageToThumbnail() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference productsCollection = firestore.collection('products');

    QuerySnapshot querySnapshot = await productsCollection.get();

    querySnapshot.docs.forEach((document) async {
      DocumentReference documentReference = document.reference;

      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      if (data.containsKey('name')) {
        dynamic image = data['name'];

        data.remove('name');

        data['title'] = image;

        await documentReference.set(data);
        print('done');
      }
    });
  } catch (e) {
    print('Error renaming image to thumbnail: $e');
  }
}

Future<void> addImagesFieldToProducts() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference productsCollection = firestore.collection('products');

    QuerySnapshot querySnapshot = await productsCollection.get();

    querySnapshot.docs.forEach((document) async {
      DocumentReference documentReference = document.reference;

      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      if (!data.containsKey('images')) {
        List<String> imageUrls = [data['thumbnail']];
        print(data['thumbnail']);
        data['images'] = imageUrls;

        await documentReference.set(data);
      }
    });
  } catch (e) {
    print('Error adding "images" field to products: $e');
  }
}

Future<void> addShopIdToProducts() async {
  try {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get references to the "products" and "shops" collections
    CollectionReference productsCollection = firestore.collection('products');
    CollectionReference shopsCollection = firestore.collection('shops');

    // Query the shops collection to get all documents
    QuerySnapshot shopsSnapshot = await shopsCollection.get();

    // Get the number of shops
    int numberOfShops = shopsSnapshot.docs.length;

    // Loop through each product document in the products collection
    await productsCollection.get().then((productSnapshot) {
      productSnapshot.docs.forEach((productDoc) async {
        // Generate a random index to link the product to one of the shops
        int randomShopIndex = Random().nextInt(numberOfShops);

        // Get the shop's document reference at the randomly generated index
        DocumentReference shopRef =
            shopsSnapshot.docs[randomShopIndex].reference;

        // Add the "shopId" field to the product's data
        await productDoc.reference.update({'shopId': shopRef.id});
        print('done');
      });
    });
  } catch (e) {
    print('Error adding shopId to products: $e');
    // Handle the error, if any
  }
}

Future<void> updateProductsRandomly() async {
  try {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get a reference to the "products" collection
    CollectionReference productsCollection = firestore.collection('products');

    // Query the products collection to get all documents
    QuerySnapshot productsSnapshot = await productsCollection.get();

    // Loop through each product document in the collection
    productsSnapshot.docs.forEach((productDoc) async {
      // Generate random values for the fields
      String randomDiscountPercentage =
          (Random().nextDouble() * 50).toStringAsFixed(2);
      int randomStock = Random().nextInt(100);
      List<String> brands = [
        'Brand A',
        'Brand B',
        'Brand C',
        'Brand D',
        'Brand E'
      ];
      String randomBrand = brands[Random().nextInt(brands.length)];
      List<String> categories = ['Category X', 'Category Y', 'Category Z'];
      String randomCategory = categories[Random().nextInt(categories.length)];
      String randomRating = (Random().nextDouble() * 5).toStringAsFixed(2);

      // Update the product document with the random values
      await productDoc.reference.update({
        'discountPercentage': double.parse(randomDiscountPercentage),
        'stock': randomStock,
        'brand': randomBrand,
        'category': randomCategory,
        'rating': double.parse(randomRating),
      });
    });
  } catch (e) {
    print('Error updating products randomly: $e');
    // Handle the error, if any
  }
}

// Function to fetch products from the given URL and add them to Firestore
Future<void> fetchAndAddProducts() async {
  try {
    // Make a GET request to the given URL
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonData = json.decode(response.body);

      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get a reference to the "products" collection
      CollectionReference productsCollection = firestore.collection('products');

      // Loop through each product in the JSON data
      for (var product in jsonData['products']) {
        // Add the product to Firestore
        await productsCollection.add({
          'title': product['title'],
          'description': product['description'],
          'price': product['price'],
          'discountPercentage': product['discountPercentage'],
          'rating': product['rating'],
          'stock': product['stock'],
          'brand': product['brand'],
          'category': product['category'],
          'thumbnail': product['thumbnail'],
          'images': product['images'],
        });
      }

      print('Products added to Firestore successfully!');
    } else {
      print('Failed to fetch products. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching and adding products: $e');
    // Handle the error, if any
  }
}
