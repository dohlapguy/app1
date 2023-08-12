import 'package:flutter/material.dart';

@immutable
class AppColors {
  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static final canvasColor = ThemeData().canvasColor;
  static const black = Colors.black;
  static const lightBlack = Colors.black87;
  static const green = Color.fromARGB(255, 86, 201, 90);
  static const darkGreen = Color.fromARGB(255, 27, 148, 33);
  static final goldenYellow = Colors.yellow.shade600;
  static const purple = Color.fromARGB(255, 102, 0, 255);
  static const grey = Color.fromARGB(158, 144, 144, 144);
  static const red = Color.fromARGB(0, 249, 0, 0);
  static const blue = Color.fromARGB(0, 0, 191, 255);

  const AppColors();
}
