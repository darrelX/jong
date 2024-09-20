import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFFBA6814);
  static const Color black = Color(0xff212121);
  static const Color white = Color(0xffFAFBFB);
  static const Color surfaceWhite = Color(0xffFFFFFF);
  static const Color green = Color(0xff0AB161);
  static const Color red = Color(0xffD44638);
  static const Color grey = Color(0xFFDADADA);
  static const Color icon = Color(0xFF9E9E9E);
  static const Color transparent = Colors.transparent;

  static const ColorScheme colorScheme = ColorScheme(
    primary: primary,
    secondary: primary,
    surface: surfaceWhite,
    error: red,
    onPrimary: black,
    onSecondary: black,
    onSurface: black,
    onError: white,
    brightness: Brightness.light,
  );
}
