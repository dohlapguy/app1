import 'package:app1/data/models/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/product_bloc/product_bloc.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccessState) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ProductTile(product: product);
            },
          );
        } else if (state is ProductErrorState) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text(product.description),
    );
  }
}
