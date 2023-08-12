import 'dart:async';

import 'package:app1/data/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../data/models/productmodel.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductListBloc extends Bloc<ProductEvent, ProductListState> {
  ProductListBloc({required this.shopRepo, required this.productRepo})
      : super(const ProductListState()) {
    on<FetchProductsOfShop>(
      _fetchProductsOfShop,
      transformer: throttleDroppable(throttleDuration),
    );
    on<RefreshProductList>(_refreshProductList);
  }
  final ProductRepo productRepo;
  final ShopRepo shopRepo;

  Future<void> _fetchProductsOfShop(
      FetchProductsOfShop event, Emitter<ProductListState> emit) async {
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

  Future<void> _refreshProductList(
      RefreshProductList event, Emitter<ProductListState> emit) async {
    emit(state.copyWith(status: ProductStatus.isloading));
    try {
      final products = await productRepo.getProductsOfShop(event.shopId);
      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: products,
          hasReachedMax: false,
        ),
      );
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
