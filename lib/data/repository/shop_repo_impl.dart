import 'package:app1/core/error/exceptions.dart';
import 'package:app1/core/error/failure.dart';
import 'package:app1/core/network/network_info.dart';
import 'package:app1/core/utils/typedef.dart';
import 'package:app1/data/datasource/shop_data_source.dart';
import 'package:app1/domain/repository/shop_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/shop.dart';

class ShopRepoImpl implements ShopRepo {
  final ShopDataSource shopDataSource;
  final NetworkInfo networkInfo;

  ShopRepoImpl({required this.networkInfo, required this.shopDataSource});

  @override
  ResultFuture<List<Shop>> getShops() async {
    if (await networkInfo.isConnected) {
      try {
        final shops = await shopDataSource.getShops();
        return right(shops);
      } catch (e) {
        if (kDebugMode) {
          print('Error getting shops: $e');
        }
      }
      return left(const ServerFailure());
    } else {
      return left(const NoInternetConnectionFailure());
    }
  }

  @override
  ResultFuture<Shop> getShopDetail({required String shopId}) async {
    if (await networkInfo.isConnected) {
      try {
        final shop = await shopDataSource.getShopDetails(shopId);
        return right(shop);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const NoInternetConnectionFailure());
    }
  }

  // Future<String> getShopNameById(String shopId) async {
  //   try {
  //     DocumentSnapshot docSnapshot = await _shopCollection.doc(shopId).get();
  //     if (docSnapshot.exists) {
  //       String shopName = docSnapshot['title'];
  //       return shopName;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error fetching shop name: $e');
  //     }
  //     throw ServerException();
  //   }
  // }
}
