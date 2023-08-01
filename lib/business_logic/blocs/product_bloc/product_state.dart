part of 'product_bloc.dart';

enum ProductStatus { initial, success, failure }

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <ProductModel>[],
    this.hasReachedMax = false,
  });

  final ProductStatus status;
  final List<ProductModel> products;
  final bool hasReachedMax;

  ProductState copyWith({
    ProductStatus? status,
    bool? hasReachedMax,
    List<ProductModel>? products,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}
