import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models.dart';
import '../../../data/repo.dart';

part 'shop_detail_event.dart';
part 'shop_detail_state.dart';

class ShopDetailBloc extends Bloc<ShopDetailEvent, ShopDetailState> {
  final ShopRepo shopRepo;
  final ProductRepo productRepo;

  ShopDetailBloc({required this.shopRepo, required this.productRepo})
      : super(ShopDetailInitial()) {
    on<ShopDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchShopDetails>(_getShopDetail);
  }

  Future<FutureOr<void>> _getShopDetail(
      FetchShopDetails event, Emitter<ShopDetailState> emit) async {
    try {
      emit(ShopDetailLoadingState());
      final shop = await shopRepo.getShopDetails(event.shopId);

      if (shop != null) {
        emit(ShopDetailLoadedState(shop));
      } else {
        emit(const ShopDetailErrorState('Shop not found.'));
      }
    } catch (e) {
      emit(ShopDetailErrorState('Error getting shop: $e'));
    }
  }
}
