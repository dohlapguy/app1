part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitialState extends ShopState {}

class ShopLoadingState extends ShopState {}

class ShopsLoadedState extends ShopState {
  final List<Shop> shops;

  const ShopsLoadedState(this.shops);

  @override
  List<Object> get props => [shops];
}

class ShopErrorState extends ShopState {
  final String message;

  const ShopErrorState(this.message);

  @override
  List<Object> get props => [message];
}
