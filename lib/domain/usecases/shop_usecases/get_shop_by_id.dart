// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/core/error/failure.dart';
import 'package:app1/domain/repository/shop_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:app1/domain/usecases/usecase.dart';

import '../../../core/utils/typedef.dart';
import '../../entities/shop.dart';

class GetShopDetailsUsecase implements UseCase<Shop, Params> {
  final ShopRepo shopRepo;

  GetShopDetailsUsecase({required this.shopRepo});

  @override
  ResultFuture<Shop> call(Params params) {
    return shopRepo.getShopDetails(shopId: params.shopId);
  }
}

class Params extends Equatable {
  final String shopId;

  const Params({required this.shopId});

  @override
  List<Object> get props => [shopId];
}
