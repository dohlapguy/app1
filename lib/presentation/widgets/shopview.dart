import 'package:app1/business_logic/blocs/product_bloc/product_bloc.dart';
import 'package:app1/data/models/shopmodel.dart';
import 'package:app1/presentation/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../business_logic/blocs/shop_bloc/shop_bloc.dart';
import '../widgets.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShopsLoadedState) {
          return ListView.builder(
            itemCount: state.shops.length,
            itemBuilder: (context, index) {
              final shop = state.shops[index];
              return ShopTile(shop: shop);
            },
          );
        } else if (state is ShopErrorState) {
          return Center(child: Text(state.message));
        } else {
          return Container(); // Placeholder, you can customize as needed
        }
      },
    );
  }
}

class ShopTile extends StatelessWidget {
  const ShopTile({
    super.key,
    required this.shop,
  });

  final ShopModel shop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(shop.title),
      subtitle: Text('Rating: ${shop.rating.toStringAsFixed(2)}'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(shop.thumbnail),
      ),
      onTap: () {
        context.pushNamed(RouteConstants.shopDetailRoute,
            pathParameters: {'shopId': shop.id});
      },
    );
  }
}

class ShopProductsView extends StatefulWidget {
  final String shopId;

  const ShopProductsView({
    super.key,
    required this.shopId,
  });

  @override
  State<ShopProductsView> createState() => _ShopProductsViewState();
}

class _ShopProductsViewState extends State<ShopProductsView> {
  final _productScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productScrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.success) {
          final currentProductState = state;
          final products = currentProductState.products;

          if (currentProductState.products.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return Expanded(
            child: Stack(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //Number of columns in the grid
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                  ),
                  itemCount: currentProductState.hasReachedMax
                      ? currentProductState.products.length
                      : currentProductState.products.length + 1,
                  controller: _productScrollController,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= products.length) {
                      return null;
                    } else {
                      return ProductTile(product: products[index]);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void dispose() {
    _productScrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context
          .read<ProductBloc>()
          .add(FetchProductsOfShop(shopId: widget.shopId));
    }
  }

  bool get _isBottom {
    if (!_productScrollController.hasClients) return false;
    final maxScroll = _productScrollController.position.maxScrollExtent;
    final currentScroll = _productScrollController.offset;
    return currentScroll >= (maxScroll * 0.5);
  }
}
