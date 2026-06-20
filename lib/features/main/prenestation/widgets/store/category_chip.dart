import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final Category category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: AppDecorations.pill(selected: selected),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) ...[
                  Icon(Icons.check_rounded,
                      size: 16.sp, color: AppTheme.to.textColor),
                  SizedBox(width: 6.w),
                ],
                Text(
                  category.name,
                  style: AppStyles.bodyMediumS.copyWith(
                    color: selected
                        ? AppTheme.to.textColor
                        : AppTheme.to.greyColor,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                if (category.productsCount > 0) ...[
                  SizedBox(width: 6.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppTheme.to.primaryColor.withOpacity(0.15)
                          : AppTheme.to.backgroundColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${category.productsCount}',
                      style: AppStyles.bodyRegularSS.copyWith(
                        color: selected
                            ? AppTheme.to.textColor
                            : AppTheme.to.greyColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
