part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class FetchShopsEvent extends ShopEvent {}

class GetShopById extends ShopEvent {
  final String shopId;

  const GetShopById(this.shopId);

  @override
  List<Object> get props => [shopId];
}
