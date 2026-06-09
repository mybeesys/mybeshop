import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_theme.dart';

class AppDecorations {
  AppDecorations._();

  static double get radiusS => 8.r;
  static double get radiusM => 12.r;
  static double get radiusL => 16.r;
  static double get radiusXL => 24.r;

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static BoxDecoration card({Color? color, double? radius}) => BoxDecoration(
        color: color ?? AppTheme.to.surfaceColor,
        borderRadius: BorderRadius.circular(radius ?? radiusL),
        border: Border.all(color: AppTheme.to.borderColor),
        boxShadow: cardShadow,
      );

  static BoxDecoration heroBanner() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.to.primaryColor,
            AppTheme.to.primaryColor.withOpacity(0.88),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusXL),
        boxShadow: elevatedShadow,
      );

  static BoxDecoration pill({bool selected = false}) => BoxDecoration(
        color: selected
            ? AppTheme.to.primaryColor
            : AppTheme.to.surfaceColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: selected
              ? AppTheme.to.primaryColor
              : AppTheme.to.borderColor,
        ),
      );
}
