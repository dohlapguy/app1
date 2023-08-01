part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  final List<ProductModel> products;

  const ProductSuccessState(this.products);

  @override
  List<Object> get props => [products];
}

class ProductErrorState extends ProductState {}
