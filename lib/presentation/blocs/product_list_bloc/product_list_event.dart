part of 'product_list_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductEvent {}

class FetchProductsOfShop extends ProductEvent {
  final String shopId;
  const FetchProductsOfShop({required this.shopId});

  @override
  List<Object?> get props => [shopId];
}

class ResetFilterProductsOfShop extends ProductEvent {
  final String shopId;

  const ResetFilterProductsOfShop({required this.shopId});
}

class FetchFilteredProductsOfShop extends ProductEvent {
  final String shopId;
  final FilterProductModel filter;
  const FetchFilteredProductsOfShop(
      {required this.filter, required this.shopId});

  @override
  List<Object?> get props => [shopId, filter];
}

class RefreshProductList extends ProductEvent {
  final String shopId;

  const RefreshProductList({required this.shopId});

  @override
  List<Object> get props => [shopId];
}
