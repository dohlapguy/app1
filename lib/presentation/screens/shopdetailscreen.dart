import 'package:app1/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/blocs/product_list_bloc/product_list_bloc.dart';
import '../../business_logic/blocs/shop_detail_bloc/shop_detail_bloc.dart';
import '../../data/models.dart';
import '../widgets.dart';

class ShopDetailScreen extends StatefulWidget {
  final String shopId;
  const ShopDetailScreen({super.key, required this.shopId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final _productScrollController = ScrollController();

  Future<void> refreshScreen() async {
    context.read<ShopDetailBloc>().add(FetchShopDetails(shopId: widget.shopId));
    context
        .read<ProductListBloc>()
        .add(RefreshProductList(shopId: widget.shopId));
  }

  @override
  void initState() {
    super.initState();

    context.read<ShopDetailBloc>().add(FetchShopDetails(shopId: widget.shopId));
    context
        .read<ProductListBloc>()
        .add(FetchProductsOfShop(shopId: widget.shopId));
    _productScrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await refreshScreen(),
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (productContext, productState) {
            return CustomScrollView(
              controller: _productScrollController,
              slivers: [
                getAppBarSearch(context),

                // ** Shop Detail View
                SliverToBoxAdapter(
                  child: BlocBuilder<ShopDetailBloc, ShopDetailState>(
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case ShopDetailLoadedState:
                          final currentShopState =
                              state as ShopDetailLoadedState;
                          final shop = currentShopState.shop;
                          return SizedBox(
                            height: 200.h,
                            child: shopDetailWidget(context, shop),
                          );
                        default:
                          return Padding(
                            padding: EdgeInsets.all(40.sp),
                            child: const Center(
                                child: CircularProgressIndicator.adaptive()),
                          );
                      }
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 5.h)),

                // ** 'Product' String Display
                SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 90) / 2,
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: -4,
                            color: Color.fromARGB(137, 158, 158, 158),
                            offset: Offset(3, -3))
                      ],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.r),
                          topLeft: Radius.circular(15.r)),
                    ),
                    child: Text(
                      'Products',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightBlack.withOpacity(0.6)),
                    ),
                  ),
                )),

                // ** Product List View
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (productState.status == ProductStatus.success) {
                      final currentProductState = productState;
                      final products = currentProductState.products;

                      if (currentProductState.products.isEmpty) {
                        return const Center(child: Text('No Products'));
                      }

                      if (index >= products.length) {
                        return const BottomLoader();
                      } else {
                        return ProductTile(
                          product: products[index],
                          ofShop: true,
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                      childCount: BlocProvider.of<ProductListBloc>(context)
                              .state
                              .hasReachedMax
                          ? BlocProvider.of<ProductListBloc>(context)
                              .state
                              .products
                              .length
                          : BlocProvider.of<ProductListBloc>(context)
                                  .state
                                  .products
                                  .length +
                              1),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 100.h)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget shopDetailWidget(BuildContext context, ShopModel shop) {
    return Stack(
      children: [
        Positioned(
            child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: const Color.fromARGB(193, 158, 158, 158),
              image: DecorationImage(
                  image: NetworkImage(shop.thumbnail), fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomRight,
              stops: const [0.2, 0.9],
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.1),
              ],
            )),
          ),
        )),
        Positioned(
          right: 20.w,
          bottom: 25.h,
          child: Row(
            children: [
              Icon(
                Icons.star,
                size: 20,
                color: AppColors.goldenYellow,
                fill: 0.5,
              ),
              SizedBox(width: 1.w),
              Text(
                shop.rating.toStringAsFixed(1),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.white),
                ),
                SizedBox(height: 5.h),
                Text(
                  shop.address,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppColors.white.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _productScrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context
          .read<ProductListBloc>()
          .add(FetchProductsOfShop(shopId: widget.shopId));
    }
  }

  bool get _isBottom {
    if (!_productScrollController.hasClients) return false;
    final maxScroll = _productScrollController.position.maxScrollExtent;
    final currentScroll = _productScrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
