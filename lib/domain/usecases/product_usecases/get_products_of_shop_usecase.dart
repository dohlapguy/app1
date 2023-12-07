// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/core/utils/typedef.dart';
import 'package:app1/domain/entities/product.dart';
import 'package:app1/domain/repository/product_repo.dart';
import 'package:app1/domain/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetProductsOfShopUsecase
    implements UseCase<List<Product>, GetProductsOfShopParams> {
  final ProductRepo productRepo;

  GetProductsOfShopUsecase({required this.productRepo});

  @override
  ResultFuture<List<Product>> call(GetProductsOfShopParams params) async {
    return await productRepo.getProductsOfShop(
        shopId: params.shopId, startAfterId: params.startAfterId);
  }
}

class GetProductsOfShopParams extends Equatable {
  final String shopId;
  final String? startAfterId;

  const GetProductsOfShopParams({required this.shopId, this.startAfterId});

  @override
  List<Object?> get props => [shopId, startAfterId];
}
