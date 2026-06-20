import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class AppStyles {
  AppStyles._();

  // Use getters so .sp is resolved inside the active ScreenUtilInit (mobile/desktop).
  // [height] is a line-height multiplier — never use .h here.

  static TextStyle get heading1 => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 34.sp,
        height: 1.25,
      );
  static TextStyle get heading2 => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 27.sp,
        height: 1.25,
      );
  static TextStyle get heading3 => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        height: 1.25,
      );
  static TextStyle get heading4 => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 17.sp,
        height: 1.25,
      );
  static TextStyle get heading5 => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15.sp,
        height: 1.25,
      );
  static TextStyle get heading6 => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        height: 1.25,
      );
  static TextStyle get bodyBoldXL => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15.sp,
        height: 1.3,
      );
  static TextStyle get bodyBoldL => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        height: 1.3,
      );
  static TextStyle get bodyBoldM => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 13.sp,
        height: 1.3,
      );
  static TextStyle get bodyBoldS => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 11.sp,
        height: 1.3,
      );
  static TextStyle get bodySemiBoldXL => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15.sp,
        height: 1.3,
      );
  static TextStyle get bodySemiBoldL => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        height: 1.3,
      );
  static TextStyle get bodySemiBoldM => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
        height: 1.3,
      );
  static TextStyle get bodySemiBoldS => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 11.sp,
        height: 1.3,
      );
  static TextStyle get bodyMediumXL => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15.sp,
        height: 1.3,
      );
  static TextStyle get bodyMediumL => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        height: 1.3,
      );
  static TextStyle get bodyMediumM => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 13.sp,
        height: 1.3,
      );
  static TextStyle get bodyMediumS => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11.sp,
        height: 1.3,
      );
  static TextStyle get bodyRegularXL => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        height: 1.3,
      );
  static TextStyle get bodyRegularL => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        height: 1.3,
      );
  static TextStyle get bodyRegularM => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
        height: 1.3,
      );
  static TextStyle get bodyRegularS => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11.sp,
        height: 1.3,
      );
  static TextStyle get bodyRegularSS => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        height: 1.3,
      );

  static double deviceWidth(context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double deviceHeight(context) {
    return MediaQuery.sizeOf(context).height;
  }

  static List<Color> randomColor() {
    final random = math.Random();

    while (true) {
      final red = random.nextInt(256);
      final green = random.nextInt(256);
      final blue = random.nextInt(256);

      final brightness = (red * 299 + green * 587 + blue * 114) / 1000;

      if (brightness < 128) {
        var color = Color.fromRGBO(red, green, blue, 1.0);
        return [color, color.withOpacity(0.5)];
      }
    }
  }
}
