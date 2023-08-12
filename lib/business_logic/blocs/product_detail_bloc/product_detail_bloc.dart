import 'dart:async';

import 'package:app1/data/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepo productRepo;
  ProductDetailBloc({required this.productRepo})
      : super(ProductDetailInitial()) {
    on<FetchProductById>(_fetchProductById);
  }

  Future<FutureOr<void>> _fetchProductById(
      FetchProductById event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      final product = await productRepo.getProductById(event.productId);
      if (product != null) {
        emit(ProductDetailLoaded(product));
      } else {
        emit(const ProductDetailError('Product not found'));
      }
    } catch (e) {
      emit(const ProductDetailError('Error fetching product details'));
    }
  }
}
