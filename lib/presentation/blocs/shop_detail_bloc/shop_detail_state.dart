// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shop_detail_bloc.dart';

abstract class ShopDetailState extends Equatable {
  const ShopDetailState();

  @override
  List<Object> get props => [];
}

class ShopDetailInitial extends ShopDetailState {}

class ShopDetailLoadedState extends ShopDetailState {
  final Shop shop;

  const ShopDetailLoadedState(this.shop);

  @override
  List<Object> get props => [shop];

  ShopDetailLoadedState copyWith({
    Shop? shop,
  }) {
    return ShopDetailLoadedState(
      shop ?? this.shop,
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
