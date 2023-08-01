import 'package:app1/business_logic/blocs/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/shop_detail_bloc/shop_detail_bloc.dart';
import '../../data/models.dart';
import '../widgets.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopId;
  const ShopDetailScreen({super.key, required this.shopId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  // final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ShopDetailBloc>().add(FetchShopDetails(shopId: widget.shopId));
    context.read<ProductBloc>().add(FetchProductsOfShop(shopId: widget.shopId));
    // _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ShopDetailBloc, ShopDetailState>(
          builder: (context, state) {
            return state is ShopDetailLoadedState
                ? Text(state.shop.title)
                : const CircularProgressIndicator();
          },
        ),
      ),
      body: BlocBuilder<ShopDetailBloc, ShopDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ShopDetailLoadedState:
              final currentShopState = state as ShopDetailLoadedState;
              final shop = currentShopState.shop;
              return Column(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          shop.thumbnail,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          shop.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          shop.address,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Rating: ${shop.rating.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        // Add more details as needed
                        const Divider(),
                      ],
                    ),
                  ),
                  ShopProductsView(
                    shopId: widget.shopId,
                  )
                ],
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

//   @override
//   void dispose() {
//     _scrollController
//       ..removeListener(_onScroll)
//       ..dispose();

//     super.dispose();
//   }

//   void _onScroll() {
//     if (_isBottom) {
//       context
//           .read<ProductBloc>()
//           .add(FetchProductsOfShop(shopId: widget.shopId));
//     }
//   }

//   bool get _isBottom {
//     if (!_scrollController.hasClients) return false;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.offset;
//     return currentScroll >= (maxScroll * 0.9);
//   }
}
