import 'dart:async';

import '../../../domain/usecases/product_usecases/get_product_by_id_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/product.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductByIdUsecase getProductByIdUsecase;
  ProductDetailBloc({required this.getProductByIdUsecase})
      : super(ProductDetailInitial()) {
    on<FetchProductById>(_fetchProductById);
  }

  Future<FutureOr<void>> _fetchProductById(
      FetchProductById event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      final productResult =
          await getProductByIdUsecase.call(Params(event.productId));
      productResult.fold(
          (failure) => emit(ProductDetailError(getStringByFailure(failure))),
          (product) => emit(ProductDetailLoaded(product)));
    } catch (e) {
      emit(const ProductDetailError('Error fetching product details'));
    }
  }
}
