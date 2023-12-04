import 'package:app1/core/utils/typedef.dart';

import '../entities/product.dart';

abstract class ProductRepo {
  ResultFuture<Product> getProductById(String productId);
  ResultFuture<List<Product>> getProductsOfShop(
      {required String shopId, String? startAfterId});
}
