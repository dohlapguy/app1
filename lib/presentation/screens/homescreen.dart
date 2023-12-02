import 'package:app1/business_logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:app1/presentation/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../business_logic/blocs/shop_bloc/shop_bloc.dart';
import '../../constants/app_colors.dart';
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
    BlocProvider.of<ShopBloc>(context).add(FetchShopsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: BlocBuilder<ShopBloc, ShopState>(
              builder: (context, shopState) {
                return CustomScrollView(
                  slivers: [
                    // ** Custom Home AppBar
                    SliverAppBar(
                        expandedHeight: 100.h,
                        backgroundColor: AppColors.canvasColor,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                padding: EdgeInsets.all(8.sp),
                                child: Text('Mawlai Kynton Massar, Shillong',
                                    style:
                                        Theme.of(context).textTheme.bodySmall)),
                          ),
                        ),
                        actions: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.home_rounded,
                                    color: AppColors.violet.withOpacity(0.7),
                                    size: 40.sp,
                                  ),
                                  Icon(
                                    Icons.account_circle_outlined,
                                    color: AppColors.violet.withOpacity(0.7),
                                    size: 40.sp,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),

                    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                    getSliverAppBarSearch(context, size: 50),

                    // ** Deals List View
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: SizedBox(
                          height: 150.h, // Height of the PageView
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5, // Number of pages
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Container(
                                  padding: EdgeInsets.all(8.sp),
                                  width: 170.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  child: Text('Page $index'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // ** 'Category' String
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Text(
                          'Categories',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),

                    // ** Category Selection View
                    SliverToBoxAdapter(
                        child: Container(
                      padding: EdgeInsets.all(8.sp),
                      height: 202.h,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 12,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(8.sp)),
                            margin: EdgeInsets.all(8.sp),
                            child: Center(
                              child: Text('Item $index'),
                            ),
                          );
                        },
                      ),
                    )),

                    // ** 'Shop' String
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: 4.h,
                          left: 14.w,
                        ),
                        child: Text(
                          'Shops',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),

                    // ** Shop List View
                    if (shopState is ShopsLoadedState)
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        final shop = shopState.shops[index];
                        return ShopTile(shop: shop);
                      }, childCount: shopState.shops.length)),

                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Wrap(
                            spacing: 5.sp,
                            children: [
                              ElevatedButton(
                                  onPressed: () => context
                                      .pushNamed(RouteConstants.dealsRoute),
                                  child: const Text("deals")),
                              ElevatedButton(
                                  onPressed: () => context
                                      .pushNamed(RouteConstants.cartRoute),
                                  child: const Text("cart")),
                              Visibility(
                                visible: shopState is! AuthLoggedInState,
                                child: ElevatedButton(
                                    onPressed: () => context.pushNamed(
                                        RouteConstants.phoneLoginRoute),
                                    child: const Text("Login")),
                              ),
                              ElevatedButton(
                                  onPressed: () => context
                                      .pushNamed(RouteConstants.shopsRoute),
                                  child: const Text("Shops")),
                              ElevatedButton(
                                  onPressed: () => context.pushNamed(
                                      RouteConstants.productDetailRoute),
                                  child: const Text("Product")),
                              ElevatedButton(
                                  onPressed: () => context.pushNamed('mock'),
                                  child: const Text("Mock")),
                              ElevatedButton(
                                  onPressed: () => context.pushNamed('order'),
                                  child: const Text("Order")),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // const Expanded(child: ShopView())
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
