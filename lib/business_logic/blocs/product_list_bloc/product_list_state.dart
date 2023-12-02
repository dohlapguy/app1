part of 'product_list_bloc.dart';

enum ProductStatus { initial, success, failure, isloading }

class ProductListState extends Equatable {
  const ProductListState({
    this.status = ProductStatus.initial,
    this.products = const <ProductModel>[],
    this.hasReachedMax = false,
    this.isFiltered = false,
    this.filter,
  });

  final ProductStatus status;
  final FilterProductModel? filter;
  final bool isFiltered;

  final List<ProductModel> products;
  final bool hasReachedMax;

  ProductListState copyWith({
    ProductStatus? status,
    bool? hasReachedMax,
    List<ProductModel>? products,
    bool? isFiltered,
    FilterProductModel? filter,
  }) {
    return ProductListState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFiltered: isFiltered ?? this.isFiltered,
      filter: filter ?? this.filter,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${products.length} }''';
  }

  @override
  List<Object?> get props =>
      [status, products, hasReachedMax, isFiltered, filter];
}
