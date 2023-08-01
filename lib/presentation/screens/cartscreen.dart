import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/route_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => context.pushNamed(RouteConstants.paymentRoute),
                child: const Text('Pay')),
          ],
        ),
      ),
    );
  }
}
