import '../routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';

SliverAppBar getSliverAppBarSearch(BuildContext context,
    {double size = 15, String? searchString}) {
  return SliverAppBar(
    elevation: 0,
    automaticallyImplyLeading: true,
    expandedHeight: 50.h,
    backgroundColor: AppColors.canvasColor,
    floating: true,
    snap: false,
    flexibleSpace: Padding(
      padding:
          EdgeInsets.only(right: size.w, left: size.w, top: 2.h, bottom: 10),
      child: GestureDetector(
        onTap: () => context.pushNamed(RouteConstants.searchRoute),
        child: Container(
          height: 60.h,
          width: 360.w,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 232, 232),
              borderRadius: BorderRadius.circular(15.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Icon(
                  Icons.search,
                  size: 22.sp,
                  color: AppColors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: searchString != null
                      ? Text(
                          searchString,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppColors.black.withOpacity(0.6)),
                        )
                      : Text(
                          "Search what you're looking for ...",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppColors.black.withOpacity(0.6)),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
