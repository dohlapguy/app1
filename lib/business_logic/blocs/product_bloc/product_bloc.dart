import 'dart:async';

import 'package:app1/data/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../data/models/productmodel.dart';

part 'product_event.dart';
part 'product_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.shopRepo, required this.productRepo})
      : super(const ProductState()) {
    on<FetchProductsOfShop>(
      _fetchProductsOfShop,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  final ProductRepo productRepo;
  final ShopRepo shopRepo;

  Future<void> _fetchProductsOfShop(
      FetchProductsOfShop event, Emitter<ProductState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProductStatus.initial) {
        final products = await productRepo.getProductsOfShop(event.shopId);
        return emit(
          state.copyWith(
            status: ProductStatus.success,
            products: products,
            hasReachedMax: false,
          ),
        );
      }
      final products = await productRepo.getProductsOfShop(event.shopId,
          startAfterId: state.products.last.id);
      products.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ProductStatus.success,
                products: List.of(state.products)..addAll(products),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

  @override
  Future<void> close() {
    // Close any resources like stream controllers here
    // Call the super close method to complete the process
    return super.close();
  }
}
