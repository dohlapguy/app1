import 'dart:async';

import 'package:app1/domain/usecases/product_usecases/get_products_of_shop_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/models.dart';
import '../../../domain/entities/product.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductListBloc extends Bloc<ProductEvent, ProductListState> {
  final GetProductsOfShopUsecase getProductsOfShopUsecase;
  ProductListBloc({required this.getProductsOfShopUsecase})
      : super(const ProductListState()) {
    on<FetchProductsOfShop>(
      _fetchProductsOfShop,
      transformer: throttleDroppable(throttleDuration),
    );
    on<RefreshProductList>(_refreshProductList);
    on<ResetFilterProductsOfShop>(_resetFilterProductsOfShop);
    // on<FetchFilteredProductsOfShop>(
    //   _fetchFilteredProductsOfShop,
    //   transformer: throttleDroppable(throttleDuration),
    // );
  }

// ** Fetch only the default products of Shops whitout any Filter
  Future<void> _fetchProductsOfShop(
      FetchProductsOfShop event, Emitter<ProductListState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.products.isEmpty) {
        final products = await getProductsOfShopUsecase
            .call(GetProductsOfShopParams(shopId: event.shopId));
        products.fold(
            (failure) =>
                emit(const ProductListState(status: ProductStatus.failure)),
            (products) => emit(ProductListState(
                status: ProductStatus.success, products: products)));
      } else {
        final products = await getProductsOfShopUsecase.call(
          GetProductsOfShopParams(
              shopId: event.shopId, startAfterId: state.products.last.id),
        );
        products.fold(
            (failure) =>
                emit(const ProductListState(status: ProductStatus.failure)),
            (products) => products.isEmpty
                ? emit(state.copyWith(
                    status: ProductStatus.success, hasReachedMax: true))
                : emit(
                    state.copyWith(
                      status: ProductStatus.success,
                      products: List.of(state.products)..addAll(products),
                      hasReachedMax: false,
                    ),
                  ));
      }
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

//**  Fetch only the Filtered Products of Shop Base on Price and Category */
  // FutureOr<void> _fetchFilteredProductsOfShop(
  //     FetchFilteredProductsOfShop event, Emitter<ProductListState> emit) async {
  //   if (state.hasReachedMax) return;
  //   try {
  //     List<ProductModel> products = [];
  //     if (state.products.isEmpty) {
  //       products = await productRepo.getProductsOfShop(
  //           shopId: event.shopId, filter: event.filter);
  //     } else {
  //       products = await productRepo.getProductsOfShop(
  //           shopId: event.shopId,
  //           startAfterId: state.products.last.id,
  //           filter: event.filter);
  //     }

  //     products.isEmpty
  //         ? emit(state.copyWith(hasReachedMax: true))
  //         : emit(
  //             state.copyWith(
  //               status: ProductStatus.success,
  //               products: List.of(state.products)..addAll(products),
  //               filter: event.filter,
  //               isFiltered: true,
  //               hasReachedMax: false,
  //             ),
  //           );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  FutureOr<void> _resetFilterProductsOfShop(
      ResetFilterProductsOfShop event, Emitter<ProductListState> emit) {
    emit(const ProductListState(status: ProductStatus.isloading));
    try {
      emit(const ProductListState(products: [], hasReachedMax: false));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _refreshProductList(
      RefreshProductList event, Emitter<ProductListState> emit) async {
    emit(state.copyWith(status: ProductStatus.isloading));
    try {
      final products = await getProductsOfShopUsecase
          .call(GetProductsOfShopParams(shopId: event.shopId));
      products.fold(
          (failure) =>
              emit(const ProductListState(status: ProductStatus.failure)),
          (products) => emit(
                state.copyWith(
                  status: ProductStatus.success,
                  products: products,
                  hasReachedMax: false,
                  isFiltered: false,
                ),
              ));
    } on Exception catch (e) {
      print(e);
    }
  }
}
