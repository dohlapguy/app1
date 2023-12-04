// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/domain/repository/shop_repo.dart';

import 'package:app1/domain/usecases/usecase.dart';

import '../../../core/utils/typedef.dart';
import '../../entities/shop.dart';

class GetShopsUsecase implements UseCase<List<Shop>, NoParams> {
  final ShopRepo shopRepo;

  GetShopsUsecase({required this.shopRepo});

  @override
  ResultFuture<List<Shop>> call(NoParams params) {
    return shopRepo.getShops();
  }
}
