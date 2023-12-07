// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/core/error/failure.dart';
import 'package:app1/domain/repository/shop_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:app1/domain/usecases/usecase.dart';

import '../../../core/utils/typedef.dart';
import '../../entities/shop.dart';

class GetShopDetailUsecase implements UseCase<Shop, GetShopDetailParams> {
  final ShopRepo shopRepo;

  GetShopDetailUsecase({required this.shopRepo});

  @override
  ResultFuture<Shop> call(GetShopDetailParams params) async {
    return await shopRepo.getShopDetail(shopId: params.shopId);
  }
}

class GetShopDetailParams extends Equatable {
  final String shopId;

  const GetShopDetailParams({required this.shopId});

  @override
  List<Object> get props => [shopId];
}
