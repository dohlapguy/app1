// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final String id;
  final String title;
  final String thumbnail;
  final double rating;
  final DateTime registeredDate;
  final String address;
  final String pincode;

  const Shop({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.rating,
    required this.registeredDate,
    required this.address,
    required this.pincode,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      thumbnail,
      rating,
      registeredDate,
      address,
      pincode,
    ];
  }
}
