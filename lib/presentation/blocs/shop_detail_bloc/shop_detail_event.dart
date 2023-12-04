part of 'shop_detail_bloc.dart';

abstract class ShopDetailEvent extends Equatable {
  const ShopDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchShopDetails extends ShopDetailEvent {
  final String shopId;

  const FetchShopDetails({required this.shopId});

  @override
  List<Object> get props => [shopId];
}
