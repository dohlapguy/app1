import 'package:app1/domain/entities/shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel extends Shop {
  ShopModel({
    required String id,
    required String title,
    required String thumbnail,
    required double rating,
    required DateTime registeredDate,
    required String address,
    required String pincode,
  }) : super(
            id: id,
            title: title,
            thumbnail: thumbnail,
            rating: rating,
            registeredDate: registeredDate,
            address: address,
            pincode: pincode);

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
