// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shop_detail_bloc.dart';

abstract class ShopDetailState extends Equatable {
  const ShopDetailState();

  @override
  List<Object> get props => [];
}

class ShopDetailInitial extends ShopDetailState {}

class ShopDetailLoadedState extends ShopDetailState {
  final ShopModel shop;
  final List<ProductModel> products;
  final bool hasReachMax;

  const ShopDetailLoadedState(this.shop, this.products, this.hasReachMax);

  @override
  List<Object> get props => [shop];

  ShopDetailLoadedState copyWith({
    ShopModel? shop,
    List<ProductModel>? products,
    bool? hasReachMax,
  }) {
    return ShopDetailLoadedState(
      shop ?? this.shop,
      products ?? this.products,
      hasReachMax ?? this.hasReachMax,
    );
  }
}

// class ShopProductLoadedState extends ShopDetailState {
//   final List<ProductModel> products;
//   final bool hasReachMax;
// }

class ShopDetailLoadingState extends ShopDetailState {}

class ShopDetailErrorState extends ShopDetailState {
  final String message;

  const ShopDetailErrorState(this.message);

  @override
  List<Object> get props => [message];
}
