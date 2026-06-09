import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/app_shimmer_loader.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';

class DesktopCategorySidebar extends StatelessWidget {
  const DesktopCategorySidebar({super.key, required this.controller});

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('categories'.tr, style: AppStyles.heading6),
          SizedBox(height: 12.h),
          if (controller.categoriesLoading.value)
            ...List.generate(
              4,
              (_) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: AppShimmerLoader.showShimmerLoader(
                  width: double.infinity,
                  height: 44.h,
                  borderRadius: 10,
                ),
              ),
            )
          else
            ...controller.categories.map(
              (category) => _CategoryTile(
                category: category,
                selected: controller.selectedCategory?.id == category.id,
                onTap: () => controller.onCategorySelected(category),
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
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
      padding: EdgeInsets.only(bottom: 6.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDecorations.radiusM),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: selected
                  ? AppTheme.to.accentColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppDecorations.radiusM),
              border: Border.all(
                color: selected
                    ? AppTheme.to.accentColor
                    : AppTheme.to.borderColor,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    category.name,
                    style: AppStyles.bodyMediumM.copyWith(
                      color: selected
                          ? AppTheme.to.accentColor
                          : AppTheme.to.primaryColor,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppTheme.to.backgroundColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${category.productsCount}',
                    style: AppStyles.bodyRegularS.copyWith(
                      color: AppTheme.to.greyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
