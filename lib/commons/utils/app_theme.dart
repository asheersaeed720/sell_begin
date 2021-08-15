import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color COLOR_PRIMARY = Color(0xFFF7B301);
  static const Color NEAR_BLACK = Color(0xFF213333);
  static const Color GREY_COLOR = Color(0xff43464B);
  // static const Color COLOR_GREY_CHATEAU = Color(0xffA0A4A8);
  static const Color COLOR_SCREEN_BG = Color(0xffF4F7FC);

  static const String fontName = 'Poppins';

  static const TextTheme textTheme = TextTheme(
    headline1: headline1,
    headline2: headline2,
  );

  static const TextStyle headline1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 26.0,
    color: NEAR_BLACK,
  );
  static const TextStyle headline2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: GREY_COLOR,
  );
}
