import '../../constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../routes/route_constants.dart';
import '../widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //**App Bar */
      appBar: generalAppBar(context, 'KFC'),

      //**Body */
      body: CustomScrollView(slivers: [
        //**Sliver AppBar for Deliver details */
        SliverAppBar(
          automaticallyImplyLeading: false,
          snap: true,
          floating: true,
          expandedHeight: 20.h,
          backgroundColor: AppColors.canvasColor,
          title: Row(
            children: [
              Text(
                'Deliver to: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  'Mawlai Kynton Massar',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppColors.grey.withOpacity(1)),
                ),
              ),
            ],
          ),
          centerTitle: false,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0.r),
              bottomRight: Radius.circular(40.0.r),
            ),
          ),
          elevation: 4,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                child: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.black,
                ),
              ),
            )
          ],
        ),

        //**Cart Item Tile */
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
                padding: EdgeInsets.all(10.sp),
                child: Stack(
                  children: [
                    Container(
                      height: 280.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: AppColors.canvasColor,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ]),
                      child: Row(
                        children: [
                          //**Right Column of Row */
                          SizedBox(
                            width: 160.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 140.w,
                                  height: 160.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://images.unsplash.com/photo-1518390643573-66f352c5492e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80",
                                          ))),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(140.w, 20.h),
                                        elevation: 0,
                                        backgroundColor: AppColors.canvasColor,
                                        side: const BorderSide(
                                            width: 0.5, color: AppColors.red),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r))),
                                    onPressed: () {},
                                    child: Text(
                                      "Delete",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: AppColors.red
                                                  .withOpacity(0.8)),
                                    ))
                              ],
                            ),
                          ),

                          //**Left Column of Row */
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fresh Tomatoes 1kg',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 16.sp),
                              ),
                              Gap(10.h),
                              Text(
                                '\$29',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Gap(15.h),
                              Text(
                                'Not Returnable',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.grey.withOpacity(1),
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 20.w,
                      child: Container(
                        height: 44.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                            color: AppColors.canvasColor,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove_outlined)),
                            ),
                            Expanded(
                              child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "1",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Expanded(
                              child: IconButton(
                                  color: AppColors.green,
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_outlined)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          }, childCount: 2),
        ),

        //**Divider */
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Divider(
              color: AppColors.black.withOpacity(0.6),
            ),
          ),
        ),

        //**Bill Detail String */
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Text(
              "Bill Details",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),

        //** Billing Details */
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                decoration: BoxDecoration(
                    color: AppColors.canvasColor,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Item Total"),
                        Text(
                          "\$140.0",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.black.withOpacity(0.4)),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Delivery fee"),
                        Text(
                          "\$3.0",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.black.withOpacity(0.4)),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Platform fee"),
                        Text(
                          "\$1.0",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.black.withOpacity(0.4)),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("GST and Packaging Charges"),
                        Text(
                          "\$5.0",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.black.withOpacity(0.4)),
                    Gap(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "To Pay",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                        Text(
                          "\$203.00",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),

        SliverGap(100.h)
      ]),

      //**FAB */
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RouteConstants.paymentRoute),
        backgroundColor: AppColors.green,
        child: const Text('Pay'),
      ),
    );
  }
}
