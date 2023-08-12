// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:app1/data/models/productmodel.dart';

import '../../business_logic/blocs/product_list_bloc/product_list_bloc.dart';
import '../routes/route_constants.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final bool ofShop;
  const ProductTile({
    Key? key,
    required this.product,
    this.ofShop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: GestureDetector(
        onTap: () => context.pushNamed(RouteConstants.productDetailRoute,
            pathParameters: {'product_id': product.id}),
        child: Container(
          height: 190.h,
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
                  // width: (MediaQuery.of(context).size.width - 90) / 2,
                  width: 150.w,
                  height: 190.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    image: DecorationImage(
                        image: NetworkImage(product.thumbnail),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          stops: const [0.2, 0.9],
                          colors: [
                            Colors.black.withOpacity(0.8),
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
                        product.title,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10.h),
                      Visibility(
                        visible: ofShop,
                        child: Text(
                          product.shopName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.grey.withOpacity(0.9)),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        " \$${product.price}",
                        style: Theme.of(context).textTheme.titleLarge!,
                        maxLines: 1,
                      ),
                      SizedBox(height: 15.h),
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
                            product.rating.toStringAsFixed(1),
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
              Positioned(
                bottom: 16.h,
                right: 20.w,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(210, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          color: const Color.fromARGB(68, 130, 130, 130)),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: -3,
                            color: Color.fromARGB(137, 158, 158, 158),
                            offset: Offset(3, 3))
                      ],
                    ),
                    child: Center(
                        child: Text(
                      "ADD",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.green, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
