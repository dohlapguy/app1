import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';

SliverAppBar getAppBarSearch(context, {double size = 15}) {
  return SliverAppBar(
      snap: true,
      expandedHeight: 70.h,
      backgroundColor: AppColors.canvasColor,
      floating: true,
      actions: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              // top: 5.h,
              // bottom: 5.h,
              right: size.w,
              left: size.w,
            ),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.sp),
                  fillColor: const Color.fromARGB(255, 232, 232, 232),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black87,
                  ),
                  hintText: "Search what you're looking for"),
            ),
          ),
        ),
      ]);
}
