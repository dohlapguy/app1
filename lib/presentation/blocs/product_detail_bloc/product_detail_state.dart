part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;

  const ProductDetailLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailError extends ProductDetailState {
  final String errorMessage;

  const ProductDetailError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
