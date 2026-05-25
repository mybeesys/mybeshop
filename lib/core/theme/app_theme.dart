import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
// import 'package:mybee/features/main/presentation/controllers/account_controller.dart';
// import 'package:mybee/features/main/presentation/controllers/settings_controller.dart';

class AppTheme extends GetxController {
  static AppTheme get to => Get.find();

  Color primaryColor = const Color.fromARGB(255, 17, 29, 48);
  Color yellowColor = const Color(0xffFFCA42);
  Color blueGreyColor = const Color(0xffB4C7E7);
  Color greyColor = const Color(0xff8A8A8A);

  // Color primaryColor = const Color(0xffFFCA42);
  // Color yellowColor = const Color(0xff1B3764);
  // Color blueGreyColor = const Color(0xffB4C7E7);
  // Color greyColor = const Color(0xff8A8A8A);

  MaterialColor primarySwitch = Colors.amber;

  ThemeData appTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: primaryColor,
      primarySwatch: primarySwitch,
      fontFamily: "Alexandria",
      inputDecorationTheme: InputDecorationTheme(
        focusColor: primaryColor,
        filled: true,
        fillColor: Colors.grey.shade100,
        labelStyle: AppStyles.bodyMediumXL,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ));
}
