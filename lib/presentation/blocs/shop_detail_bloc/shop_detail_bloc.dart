import 'dart:async';

import 'package:app1/core/error/failure.dart';
import 'package:app1/domain/usecases/shop_usecases/get_shop_by_id.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/shop.dart';

part 'shop_detail_event.dart';
part 'shop_detail_state.dart';

class ShopDetailBloc extends Bloc<ShopDetailEvent, ShopDetailState> {
  final GetShopDetailsUsecase getShopDetailsUsecase;

  ShopDetailBloc({required this.getShopDetailsUsecase})
      : super(ShopDetailInitial()) {
    on<ShopDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchShopDetails>(_getShopDetail);
  }

  Future<FutureOr<void>> _getShopDetail(
      FetchShopDetails event, Emitter<ShopDetailState> emit) async {
    emit(ShopDetailLoadingState());
    final shop = await getShopDetailsUsecase(Params(shopId: event.shopId));

    shop.fold(
        (failure) => emit(ShopDetailErrorState(getStringByFailure(failure))),
        (shop) => emit(ShopDetailLoadedState(shop)));
  }
}
