import '../../constants/app_colors.dart';
import '../widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* AppBar
      appBar: generalAppBar(context, 'Your Orders'),
      //* Body
      body: CustomScrollView(slivers: [
        //* Order Search Box
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.sp),
                    child: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 0, 157, 209),
                    ),
                  ),
                  const Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search all orders',
                        border: InputBorder.none),
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.sp),
                    child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Filter',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),

        //* Order List
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) =>

                    //* Order Tile
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Container(
                          height: 180.h,
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.grey, width: 2.w),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reliance Digital',
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Gap(10.h),
                                          const Text(
                                            'Police Bazzar',
                                            style: TextStyle(
                                                color: AppColors.lightBlack),
                                          ),
                                          Gap(10.h),
                                          const Text(
                                            '\$145',
                                            style: TextStyle(
                                                color: AppColors.lightBlack,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        'On The Way',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkGreen),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Divider(thickness: 1),
                              Gap(10.h),
                              const Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.lightBlack,
                                  ),
                                  "Tooth Brush (1), Tooth Paste (1), Bread (1)"),
                              Gap(10.h),
                              const Text(
                                "December 5, 11:34 AM",
                                style: TextStyle(color: AppColors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                childCount: 3)),

        SliverGap(20.h),

        const SliverToBoxAdapter(
          child: Divider(color: AppColors.grey),
        ),

        //* History String
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: const Text(
              'ORDER HISTORY',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),

        //* History Order List
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) =>

                    //* History Order Tile
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Container(
                          height: 220.h,
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vishal Mart',
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Gap(10.h),
                                          const Text(
                                            'South Four Long Road',
                                            style: TextStyle(
                                                color: AppColors.lightBlack),
                                          ),
                                          Gap(10.h),
                                          const Text(
                                            '\$300',
                                            style: TextStyle(
                                                color: AppColors.lightBlack,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text('Delivered'),
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.darkGreen,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Divider(thickness: 1),
                              Gap(10.h),
                              const Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.lightBlack,
                                  ),
                                  "Fresh Tomatoes (2), Onions (1)"),
                              Gap(10.h),
                              const Text(
                                "November 30, 2:15 PM",
                                style: TextStyle(color: AppColors.grey),
                              ),
                              Gap(5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "You haven't rated this order yet",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.yellow.shade800,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  OutlinedButton(
                                      style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: AppColors.black)),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        "Rate Order",
                                        style:
                                            TextStyle(color: AppColors.black),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                childCount: 3))
      ]),
    );
  }
}
