part of 'product_list_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class FetchProductsOfShop extends ProductEvent {
  final String shopId;

  const FetchProductsOfShop({required this.shopId});

  @override
  List<Object> get props => [shopId];
}

class RefreshProductList extends ProductEvent {
  final String shopId;

  const RefreshProductList({required this.shopId});

  @override
  List<Object> get props => [shopId];
}