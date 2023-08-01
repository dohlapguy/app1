import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/shop_detail_bloc/shop_detail_bloc.dart';
import '../../data/models.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopId;
  const ShopDetailScreen({super.key, required this.shopId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ShopDetailBloc>().add(FetchShopDetails(shopId: widget.shopId));
    _scrollController.addListener(_onScroll);
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
              final currentState = state as ShopDetailLoadedState;
              final shop = currentState.shop;
              final products = currentState.products;

              if (currentState.products.isEmpty) {
                return const Center(child: Text('no posts'));
              }

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
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 8.0, // Spacing between columns
                        mainAxisSpacing: 8.0, // Spacing between rows
                      ),
                      itemCount: currentState.hasReachMax
                          ? currentState.products.length
                          : currentState.products.length + 1,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return index >= products.length
                            ? const BottomLoader()
                            : ProductTile(product: products[index]);
                      },
                    ),
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

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context
          .read<ShopDetailBloc>()
          .add(FetchShopDetails(shopId: widget.shopId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            product.thumbnail,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            product.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
