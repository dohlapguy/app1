import 'dart:io';

import 'package:app1/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await refreshScreen(),
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (productContext, productState) {
              return CustomScrollView(
                controller: _productScrollController,
                slivers: [
                  getSliverAppBarSearch(context),

                  const SliverGap(10),

                  // ** Shop Detail View
                  SliverToBoxAdapter(
                    child: BlocBuilder<ShopDetailBloc, ShopDetailState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case ShopDetailLoadedState:
                            final currentShopState =
                                state as ShopDetailLoadedState;
                            final shop = currentShopState.shop;
                            return shopDetailWidget(context, shop);
                          default:
                            return const Padding(
                              padding: EdgeInsets.all(40),
                              child: Center(
                                  child: CircularProgressIndicator.adaptive()),
                            );
                        }
                      },
                    ),
                  ),

                  const SliverGap(20),
                  SliverToBoxAdapter(
                    child: Divider(
                      thickness: 1.7,
                      indent: 40.w,
                      endIndent: 40.w,
                    ),
                  ),

                  const SliverGap(20),
                  // ** 'Product' String Display
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Products',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lightBlack),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                final filter = FilterProductModel(
                                    category: Category.categories
                                        .where((element) => element.id == 2)
                                        .toList());
                                context.read<ProductListBloc>().add(
                                    ResetFilterProductsOfShop(
                                        shopId: widget.shopId));
                                context.read<ProductListBloc>().add(
                                      FetchFilteredProductsOfShop(
                                          shopId: widget.shopId,
                                          filter: filter),
                                    );
                              },
                              child: const Text(
                                'Filter',
                                style: TextStyle(color: AppColors.lightBlack),
                              ))
                        ],
                      ),
                    ),
                  ),

                  // ** Product List View
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (productState.status == ProductStatus.success) {
                        final currentProductState = productState;
                        final products = currentProductState.products;

                        print(BlocProvider.of<ProductListBloc>(context)
                            .state
                            .hasReachedMax);

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
                  const SliverGap(100),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget shopDetailWidget(BuildContext context, ShopModel shop) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 5.h),
      child: Container(
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h, bottom: 20.h),
          decoration: BoxDecoration(
            color: AppColors.canvasColor,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.lightGrey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    shop.title,
                    style: GoogleFonts.pacifico(
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.arrowUpFromBracket,
                          color: AppColors.lightBlack,
                        ),
                        iconSize: 17,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.heart,
                          color: AppColors.lightBlack,
                        ),
                        iconSize: 19,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: AppColors.darkGreen,
                    size: 10,
                  ),
                  const Gap(2),
                  Text(
                    shop.rating.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(2),
                  const Text(
                    '(1k ratings)',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightBlack),
                  )
                ],
              ),
              const Gap(10),
              Divider(
                thickness: 1.4.sp,
                indent: 40.w,
                endIndent: 40.w,
              ),
              const Gap(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                    child: Image.asset(
                      'assets/icons/route.png',
                      color: AppColors.grey.withOpacity(0.5),
                      width: 10,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Outlet',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Text(
                                shop.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: AppColors.lightBlack),
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '35 min',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(10),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Deliver to Home',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(color: AppColors.lightBlack),
                                  ),
                                  const Gap(6),
                                  FaIcon(
                                    FontAwesomeIcons.caretDown,
                                    size: 20.sp,
                                    color: AppColors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
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
      final productBloc = BlocProvider.of<ProductListBloc>(context);

      if (!productBloc.state.isFiltered) {
        if (!productBloc.state.hasReachedMax) {
          context
              .read<ProductListBloc>()
              .add(FetchProductsOfShop(shopId: widget.shopId));
        }
      } else {
        if (!productBloc.state.hasReachedMax) {
          context.read<ProductListBloc>().add(FetchFilteredProductsOfShop(
              shopId: widget.shopId, filter: productBloc.state.filter!));
        }
      }
    }
  }

  bool get _isBottom {
    if (!_productScrollController.hasClients) return false;
    final maxScroll = _productScrollController.position.maxScrollExtent;
    final currentScroll = _productScrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
