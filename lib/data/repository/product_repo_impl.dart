import 'package:app1/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repository/product_repo.dart';
import '../datasource/product_data_source.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductDataSource productDataSource;
  final NetworkInfo networkInfo;

  ProductRepoImpl({required this.productDataSource, required this.networkInfo});

  @override
  ResultFuture<List<Product>> getProductsOfShop({
    required shopId,
    String? startAfterId,
    // FilterProductModel? filter,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await productDataSource.getProductsOfShop(
            shopId: shopId, startAfterId: startAfterId);
        return right(products);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const NoInternetConnectionFailure());
    }
  }

  @override
  ResultFuture<Product> getProductById(String productId) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await productDataSource.getProductById(productId);
        return right(product);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const NoInternetConnectionFailure());
    }
  }
}
