import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_styles.dart';

class AppTheme extends GetxController {
  static AppTheme get to => Get.find();

  // Brand palette — clean global e-commerce look
  Color primaryColor = const Color(0xFF0F172A);
  Color accentColor = const Color(0xFF2563EB);
  Color yellowColor = const Color(0xFFF59E0B);
  Color blueGreyColor = const Color(0xFF94A3B8);
  Color greyColor = const Color(0xFF64748B);
  Color surfaceColor = const Color(0xFFFFFFFF);
  Color backgroundColor = const Color(0xFFF8FAFC);
  Color borderColor = const Color(0xFFE2E8F0);
  Color saleColor = const Color(0xFFEF4444);
  Color successColor = const Color(0xFF10B981);

  MaterialColor primarySwitch = Colors.blue;

  ThemeData appTheme() => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: accentColor,
          surface: surfaceColor,
          error: saleColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: primaryColor,
        ),
        fontFamily: 'Alexandria',
        dividerColor: borderColor,
        cardTheme: CardThemeData(
          color: surfaceColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(color: borderColor),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            textStyle: AppStyles.bodyBoldM.copyWith(color: Colors.white),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: BorderSide(color: borderColor),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceColor,
          labelStyle: AppStyles.bodyMediumM.copyWith(color: greyColor),
          hintStyle: AppStyles.bodyRegularM.copyWith(color: greyColor),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: accentColor, width: 1.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: borderColor),
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: surfaceColor,
          foregroundColor: primaryColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: AppStyles.bodyBoldL.copyWith(color: primaryColor),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: surfaceColor,
          indicatorColor: accentColor.withOpacity(0.12),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return AppStyles.bodyMediumS.copyWith(
              color: selected ? accentColor : greyColor,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              color: selected ? accentColor : greyColor,
              size: 22.sp,
            );
          }),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceColor,
          selectedItemColor: accentColor,
          unselectedItemColor: greyColor.withOpacity(0.6),
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
      );
}
