import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/utils/enums/theme_enum.dart';

class AppTheme extends GetxController {
  static AppTheme get to => Get.find();

  static const Color _amberPrimary = Color(0xFFFFBD59);

  Color primaryColor = _amberPrimary;
  Color accentColor = _amberPrimary;
  Color yellowColor = _amberPrimary;
  Color blueGreyColor = const Color(0xFF94A3B8);
  Color greyColor = const Color(0xFF64748B);
  Color surfaceColor = Colors.white;
  Color backgroundColor = const Color(0xFFF5F5F5);
  Color borderColor = const Color(0xFFEEF2F7);
  Color saleColor = const Color(0xFFEF4444);
  Color successColor = const Color(0xFF10B981);
  Color textColor = const Color(0xFF1E293B);
  /// Text and icons on [primaryColor] backgrounds.
  Color onPrimaryColor = Colors.black;

  MaterialColor primarySwitch = Colors.amber;

  Rx<ThemeData> appTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    fontFamily: 'Cairo',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  ).obs;

  final ThemeData _lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    fontFamily: 'Cairo',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );

  void _applyPalette(Color primary) {
    primaryColor = primary;
    accentColor = primary;
    yellowColor = primary;
    backgroundColor = const Color(0xFFF5F5F5);
    surfaceColor = Colors.white;
    borderColor = const Color(0xFFEEF2F7);
    textColor = const Color(0xFF1E293B);
    onPrimaryColor = Colors.black;
  }

  void changeTheme(ThemeColor color) {
    switch (color) {
      case ThemeColor.blue:
        _applyPalette(Colors.blue);
        appTheme(_lightTheme);
        appTheme.value = _buildLightTheme(Colors.blue);
        break;
      case ThemeColor.amber:
        _applyPalette(_amberPrimary);
        appTheme(_lightTheme);
        appTheme.value = _buildLightTheme(_amberPrimary);
        break;
      case ThemeColor.red:
        _applyPalette(Colors.red);
        appTheme(_lightTheme);
        appTheme.value = _buildLightTheme(Colors.red);
        break;
      case ThemeColor.crimson:
        _applyPalette(const Color(0xFFDC143C));
        appTheme(_lightTheme);
        appTheme.value = _buildLightTheme(const Color(0xFFDC143C));
        break;
      case ThemeColor.dark:
        _applyPalette(Colors.teal);
        appTheme.value = ThemeData.dark(useMaterial3: false).copyWith(
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Cairo'),
          primaryColor: primaryColor,
          colorScheme: ColorScheme.light(primary: primaryColor),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        break;
    }
    update();
  }

  ThemeData _buildLightTheme(Color primary) {
    return _lightTheme.copyWith(
      primaryColor: primary,
      colorScheme: ColorScheme.light(primary: primary),
      scaffoldBackgroundColor: backgroundColor,
      dividerColor: borderColor,
      cardColor: surfaceColor,
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            color: onPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'Cairo',
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: onPrimaryColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        labelStyle: TextStyle(
          color: greyColor,
          fontSize: 14,
          fontFamily: 'Cairo',
        ),
        hintStyle: TextStyle(
          color: greyColor,
          fontSize: 14,
          fontFamily: 'Cairo',
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primary,
        unselectedItemColor: greyColor.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  @override
  void onInit() {
    changeTheme(ThemeColor.amber);
    super.onInit();
  }
}
