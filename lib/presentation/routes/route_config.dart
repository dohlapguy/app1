import 'package:app1/data/repo.dart';
import 'package:app1/presentation/screens/mock/mockscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/shop_detail_bloc/shop_detail_bloc.dart';
import '../screens.dart';
import 'route_constants.dart';
import 'package:go_router/go_router.dart';

class Routes {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/login",
        name: RouteConstants.phoneLoginRoute,
        builder: (context, state) => const PhoneLoginScreen(),
      ),
      GoRoute(
        path: "/",
        name: RouteConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "/shops",
        name: RouteConstants.shopsRoute,
        builder: (context, state) => const ShopScreen(),
      ),
      GoRoute(
        path: "/shop_details/:shopId",
        name: RouteConstants.shopDetailRoute,
        builder: (context, state) {
          final shopId = state.pathParameters['shopId'] as String;
          return BlocProvider(
            create: (context) => ShopDetailBloc(
                shopRepo: RepositoryProvider.of<ShopRepo>(context),
                productRepo: RepositoryProvider.of<ProductRepo>(context)),
            child: ShopDetailScreen(shopId: shopId),
          );
        },
      ),
      GoRoute(
        path: "/user_account",
        name: RouteConstants.userAccountRoute,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: "/deals",
        name: RouteConstants.dealsRoute,
        builder: (context, state) => const DealsScreen(),
      ),
      GoRoute(
        path: "/order_history",
        name: RouteConstants.orderHistoryRoute,
        builder: (context, state) => const OrderHistoryScreen(),
      ),
      GoRoute(
        path: "/orders",
        name: RouteConstants.orderRoute,
        builder: (context, state) => const OrderScreen(),
      ),
      GoRoute(
        path: "/payment",
        name: RouteConstants.paymentRoute,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: "/product_details",
        name: RouteConstants.productDetailRoute,
        builder: (context, state) => const ProductScreen(),
      ),
      GoRoute(
        path: "/settings",
        name: RouteConstants.settingsRoute,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: "/cart",
        name: RouteConstants.cartRoute,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: "/mock",
        name: 'mock',
        builder: (context, state) => const MockScreen(),
      ),
    ],
  );
}
