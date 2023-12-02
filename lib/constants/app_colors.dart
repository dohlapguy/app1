import 'package:flutter/material.dart';

@immutable
class AppColors {
  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static const orange = Color.fromARGB(255, 255, 119, 0);
  static final canvasColor = ThemeData().canvasColor;
  static const black = Colors.black;
  static const lightBlack = Color.fromARGB(130, 0, 0, 0);
  static const green = Color.fromARGB(255, 86, 201, 90);
  static const darkGreen = Color.fromARGB(255, 27, 148, 33);
  static final yellow = Color.fromARGB(255, 255, 225, 0);
  static final goldenYellow = Colors.yellow.shade600;
  static const violet = Color.fromARGB(255, 102, 0, 255);
  static const grey = Color.fromARGB(158, 144, 144, 144);
  static final lightGrey =
      const Color.fromARGB(158, 144, 144, 144).withOpacity(0.3);
  static const red = Color.fromARGB(255, 249, 0, 0);
  static const blue = Color.fromARGB(255, 0, 191, 255);

  const AppColors();
}
