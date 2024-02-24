import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class AppStyles {
  AppStyles();

  // Font Styles
  static TextStyle heading1 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 40.sp,
  );
  static TextStyle heading2 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 32.sp,
  );
  static TextStyle heading3 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 24.sp,
  );
  static TextStyle heading4 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 20.sp,
  );
  static TextStyle heading5 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 18.sp,
  );
  static TextStyle heading6 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 16.sp,
  );
  static TextStyle bodyBoldXL = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
  );
  static TextStyle bodyBoldL = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );
  static TextStyle bodyBoldM = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
  );
  static TextStyle bodyBoldS = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
  );
  static TextStyle bodySemiBoldXL = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
  static TextStyle bodySemiBoldL = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );
  static TextStyle bodySemiBoldM = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14.sp,
  );
  static TextStyle bodySemiBoldS = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
  );
  static TextStyle bodyMediumXL = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
  );
  static TextStyle bodyMediumL = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  static TextStyle bodyMediumM = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
  static TextStyle bodyMediumS = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
  );
  static TextStyle bodyRegularXL = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
  );
  static TextStyle bodyRegularL = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );
  static TextStyle bodyRegularM = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );
  static TextStyle bodyRegularS = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  );
  static TextStyle bodyRegularSS = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11.sp,
  );

  // Screen Sizes

  static double deviceWidth(context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double deviceHeight(context) {
    return MediaQuery.sizeOf(context).height;
  }

  static List<Color> randomColor() {
    final random = math.Random();

    while (true) {
      final red = random.nextInt(256); // 0-255
      final green = random.nextInt(256); // 0-255
      final blue = random.nextInt(256); // 0-255

      final brightness = (red * 299 + green * 587 + blue * 114) / 1000;

      if (brightness < 128) {
        var color = Color.fromRGBO(red, green, blue, 1.0);
        return [color, color.withOpacity(0.5)];
      }
    }
  }
}
