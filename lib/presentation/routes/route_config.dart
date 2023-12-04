import 'package:app1/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/blocs/product_detail_bloc/product_detail_bloc.dart';
import '../../presentation/blocs/product_list_bloc/product_list_bloc.dart';
import '../../presentation/blocs/shop_detail_bloc/shop_detail_bloc.dart';
import '../screens.dart';
import '../screens/mock/mockscreen.dart';
import 'route_constants.dart';

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
        path: "/shop_detail/:shop_id",
        name: RouteConstants.shopDetailRoute,
        builder: (context, state) {
          final shopId = state.pathParameters['shop_id']!;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => locator<ShopDetailBloc>()),
              BlocProvider(
                create: (context) => locator<ProductListBloc>(),
              ),
            ],
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
        path: "/order",
        name: RouteConstants.orderRoute,
        builder: (context, state) => const OrderScreen(),
      ),
      GoRoute(
        path: "/payment",
        name: RouteConstants.paymentRoute,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: "/product_details/:product_id",
        name: RouteConstants.productDetailRoute,
        builder: (context, state) {
          final productId = state.pathParameters['product_id'];
          return BlocProvider(
            create: (context) => locator<ProductDetailBloc>(),
            child: ProductScreen(productId: productId!),
          );
        },
      ),
      GoRoute(
        path: "/search",
        name: RouteConstants.searchRoute,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: "/search_result/:search_string",
        name: RouteConstants.searchResultRoute,
        builder: (context, state) {
          final searchString = state.pathParameters['search_string'];
          return SearchResultScreen(
            searchString: searchString!,
          );
        },
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
