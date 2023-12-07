import 'dart:async';

import 'package:app1/core/error/failure.dart';
import 'package:app1/domain/usecases/shop_usecases/get_shops_usecase.dart';
import 'package:app1/domain/usecases/usecase.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/shop.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetShopsUsecase getShopsUsecase;
  ShopBloc({required this.getShopsUsecase}) : super(ShopInitialState()) {
    on<ShopEvent>((event, emit) {});
    on<FetchShopsEvent>(_fetchShops);
  }

  Future<FutureOr<void>> _fetchShops(
      FetchShopsEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final shops = await getShopsUsecase(NoParams());
    shops.fold((failure) => emit(ShopErrorState(getStringByFailure(failure))),
        (shops) => emit(ShopsLoadedState(shops)));
  }
}
