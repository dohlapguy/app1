import 'package:app1/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/shop.dart';

abstract class ShopRepo {
  Future<Either<Failure, List<Shop>>> getShops();
  Future<Either<Failure, Shop>> getShopDetails({required String shopId});
}
