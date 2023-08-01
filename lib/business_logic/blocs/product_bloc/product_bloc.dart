import 'dart:async';

import 'package:app1/data/repository/product_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/productmodel.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;

  ProductBloc({required this.productRepo}) : super(ProductInitialState()) {
    on<ProductEvent>((event, emit) {});
    on<FetchProducts>(_fetchProducts);
  }

  Future<FutureOr<void>> _fetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    try {
      final products = await productRepo.getProducts();
      emit(ProductSuccessState(products));
    } catch (e) {
      print(e);
    }
  }
}
