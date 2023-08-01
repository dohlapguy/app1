import 'dart:async';

import 'package:app1/data/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repo.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepo shopRepo;
  ShopBloc({required this.shopRepo}) : super(ShopInitialState()) {
    on<ShopEvent>((event, emit) {});
    on<FetchShopsEvent>(_fetchShops);
  }

  Future<FutureOr<void>> _fetchShops(
      FetchShopsEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    try {
      List<ShopModel> shops = await shopRepo.getShops();
      emit(ShopsLoadedState(shops));
    } catch (e) {
      emit(ShopErrorState('Error getting shops: $e'));
    }
  }
}
