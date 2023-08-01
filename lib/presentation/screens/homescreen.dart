import 'package:app1/business_logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:app1/business_logic/blocs/product_bloc/product_bloc.dart';
import 'package:app1/presentation/routes/route_constants.dart';
import 'package:app1/presentation/widgets/shopsview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../business_logic/blocs/shop_bloc/shop_bloc.dart';
import '../widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Trigger the event when the screen is built
    BlocProvider.of<AuthBloc>(context).add(CheckAuthStatus());
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    BlocProvider.of<ShopBloc>(context).add(FetchShopsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title: state is AuthLoggedInState
                  ? const Text('Home Loggin')
                  : const Text('Home'),
              actions: [
                IconButton(
                    onPressed: () =>
                        context.pushNamed(RouteConstants.settingsRoute),
                    icon: const Icon(Icons.settings)),
                IconButton(
                    onPressed: () =>
                        context.pushNamed(RouteConstants.cartRoute),
                    icon: const Icon(Icons.shopping_bag_outlined)),
                IconButton(
                    onPressed: () =>
                        context.pushNamed(RouteConstants.orderRoute),
                    icon: const Icon(Icons.list_alt_outlined)),
              ]),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () =>
                          context.pushNamed(RouteConstants.dealsRoute),
                      child: const Text("deals")),
                  Visibility(
                    visible: state is! AuthLoggedInState,
                    child: ElevatedButton(
                        onPressed: () =>
                            context.pushNamed(RouteConstants.phoneLoginRoute),
                        child: const Text("Login")),
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          context.pushNamed(RouteConstants.shopsRoute),
                      child: const Text("Shops")),
                  ElevatedButton(
                      onPressed: () =>
                          context.pushNamed(RouteConstants.productDetailRoute),
                      child: const Text("Product")),
                  ElevatedButton(
                      onPressed: () => context.pushNamed('mock'),
                      child: const Text("Mock")),
                ],
              ),
              const SizedBox(height: 20),
              const Expanded(child: ShopView())
            ],
          ),
        );
      },
    );
  }
}
