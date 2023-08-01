import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  final String id;
  final String title;
  final String thumbnail;
  final double rating;
  final DateTime registeredDate;
  final String address;
  final String pincode;

  ShopModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.rating,
    required this.registeredDate,
    required this.address,
    required this.pincode,
  });

  // Factory method to create a Shop instance from Firestore DocumentSnapshot
  factory ShopModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ShopModel(
      id: snapshot.id,
      title: data['title'],
      thumbnail: data['thumbnail'],
      rating: data['rating'].toDouble(),
      registeredDate: (data['registered_date'] as Timestamp).toDate(),
      address: data['address'],
      pincode: data['pin_code'],
    );
  }
}
