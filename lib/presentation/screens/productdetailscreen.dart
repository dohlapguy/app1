import 'package:app1/business_logic/blocs/product_detail_bloc/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ProductDetailBloc>()
        .add(FetchProductById(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            return state is ProductDetailLoaded
                ? Text(state.product.title)
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
          },
        ),
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductDetailLoaded:
              state as ProductDetailLoaded;
              return SingleChildScrollView(
                  child: Column(
                children: [
                  buildImageCarousel(state.product.images),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.product.title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.product.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '\$${state.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        state.product.stock != 0
                            ? Text(
                                'In Stock: ${state.product.stock}',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 101, 101, 101)),
                              )
                            : const Text(
                                'Currently out of Stock',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 101, 101, 101)),
                              )
                      ],
                    ),
                  )
                ],
              ));
            case ProductDetailError:
              state as ProductDetailError;
              return Center(
                child: Text(state.errorMessage),
              );
            default:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
          }
        },
      ),
    );
  }

  Widget buildImageCarousel(List<String> images) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.network(
            images[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
