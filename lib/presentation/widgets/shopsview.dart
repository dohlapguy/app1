import 'package:app1/data/models/shopmodel.dart';
import 'package:app1/presentation/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../business_logic/blocs/shop_bloc/shop_bloc.dart';

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
