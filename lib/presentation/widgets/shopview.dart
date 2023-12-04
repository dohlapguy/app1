// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:app1/presentation/routes/route_constants.dart';

import '../../domain/entities/shop.dart';
import '../../presentation/blocs/shop_bloc/shop_bloc.dart';
import '../../constants/app_colors.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShopsLoadedState) {
          return ListView.builder(
            itemCount: state.shops.length,
            itemBuilder: (context, index) {
              final shop = state.shops[index];
              return ShopTile(shop: shop);
            },
          );
        } else if (state is ShopErrorState) {
          return Center(child: Text(state.message));
        } else {
          return Container(); // Placeholder, you can customize as needed
        }
      },
    );
  }
}

class ShopTile extends StatelessWidget {
  const ShopTile({
    super.key,
    required this.shop,
  });

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: GestureDetector(
        onTap: () => context.pushNamed(RouteConstants.shopDetailRoute,
            pathParameters: {'shop_id': shop.id}),
        child: Container(
          height: 150.h,
          width: (MediaQuery.of(context).size.width - 50) / 2,
          decoration: BoxDecoration(
            color: AppColors.canvasColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color.fromARGB(68, 130, 130, 130)),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: -3,
                  color: Color.fromARGB(137, 158, 158, 158),
                  offset: Offset(3, 3))
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: 150.w,
                  height: 190.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    image: DecorationImage(
                        image: NetworkImage(shop.thumbnail),
                        fit: BoxFit.fitWidth),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          stops: const [0.1, 0.9],
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.1),
                          ],
                        )),
                  ),
                ),
              ),
              Positioned(
                  top: -5.h,
                  left: 105.w,
                  // right: 215.w,
                  child: IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(Icons.favorite_border,
                        color: AppColors.white),
                    onPressed: () {},
                  )),
              Positioned(
                top: 5.h,
                left: 160.w,
                child: Container(
                  width: 190.w,
                  height: 180.h,
                  padding: EdgeInsets.all(5.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            size: 20.sp,
                            color: AppColors.darkGreen,
                            fill: 0.5,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            shop.rating.toStringAsFixed(1),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: AppColors.darkGreen,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
