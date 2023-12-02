import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';

Widget getBestsellerText(
    {double topLeftRadius = 15, double bottomLeftRadius = 10, bool? visible}) {
  return Visibility(
    visible: visible ?? true,
    child: Container(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.orange,
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius.r),
          bottomRight: Radius.circular(bottomLeftRadius.r),
        ),
      ),
      child: Text(
        'Best Seller',
        style: GoogleFonts.pacifico(
            textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                fontSize: 12.sp)),
      ),
    ),
  );
}

Widget getTodayOfferText({bool? visible}) {
  return Visibility(
      visible: visible ?? true,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: const Color.fromARGB(255, 167, 42, 42)),
        child: const Text(
          "Today's offer",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ));
}
