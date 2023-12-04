part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchProductById extends ProductDetailEvent {
  final String productId;

  const FetchProductById({required this.productId});

  @override
  List<Object> get props => [productId];
}
