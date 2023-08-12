part of 'product_list_bloc.dart';

enum ProductStatus { initial, success, failure, isloading }

class ProductListState extends Equatable {
  const ProductListState({
    this.status = ProductStatus.initial,
    this.products = const <ProductModel>[],
    this.hasReachedMax = false,
  });

  final ProductStatus status;
  final List<ProductModel> products;
  final bool hasReachedMax;

  ProductListState copyWith({
    ProductStatus? status,
    bool? hasReachedMax,
    List<ProductModel>? products,
  }) {
    return ProductListState(
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
