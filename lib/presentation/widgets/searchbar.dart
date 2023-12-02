import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../routes/route_constants.dart';
import 'package:go_router/go_router.dart';

SliverAppBar searchBar(BuildContext context) {
  return SliverAppBar(
      snap: true,
      expandedHeight: 70.h,
      backgroundColor: AppColors.canvasColor,
      floating: true,
      actions: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: 15.w,
              left: 15.w,
            ),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.sp),
                  fillColor: const Color.fromARGB(255, 232, 232, 232),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black87,
                  ),
                  hintText: "Search what you're looking for ..."),
              onSubmitted: (searchString) => context.pushReplacementNamed(
                  RouteConstants.searchResultRoute,
                  pathParameters: {"search_string": searchString}),
            ),
          ),
        ),
      ]);
}
