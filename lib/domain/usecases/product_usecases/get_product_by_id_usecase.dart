// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/core/utils/typedef.dart';
import 'package:app1/domain/entities/product.dart';
import 'package:app1/domain/repository/product_repo.dart';
import 'package:app1/domain/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetProductByIdUsecase implements UseCase<Product, GetProductByIdParams> {
  final ProductRepo productRepo;

  GetProductByIdUsecase({required this.productRepo});

  @override
  ResultFuture<Product> call(GetProductByIdParams params) async {
    return await productRepo.getProductById(params.productId);
  }
}

class GetProductByIdParams extends Equatable {
  final String productId;

  const GetProductByIdParams(this.productId);

  @override
  List<Object> get props => [productId];
}
