import '../constants/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.grey,
      iconTheme: IconThemeData(
        color: AppColors.black, // Change the color here
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(fontSize: 15),
      bodyMedium: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.8)),
      bodySmall: const TextStyle(fontSize: 12),
      titleLarge: const TextStyle(fontSize: 24),
      titleMedium: const TextStyle(fontSize: 21),
      titleSmall: const TextStyle(fontSize: 18),
    ),
  );
}
