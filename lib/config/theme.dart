import 'package:app1/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData theme() {
  return ThemeData(
      primaryColor: AppColors.white,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.grey),
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 20.sp),
        // titleSmall: TextStyle(fontSize: ),
        // titleSmall: TextStyle(fontSize: ),
        // titleSmall: TextStyle(fontSize: ),
      ));
}
