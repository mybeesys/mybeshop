import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180.w,
              height: 180.w,
              decoration: BoxDecoration(
                color: AppTheme.to.surfaceColor,
                shape: BoxShape.circle,
                boxShadow: AppDecorations.cardShadow,
              ),
              child: Lottie.asset(
                'assets/lotties/empty_cart.json',
                repeat: true,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'your_cart_is_empty'.tr,
              style: AppStyles.heading5,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'cart_empty_hint'.tr,
              style: AppStyles.bodyRegularS.copyWith(
                color: AppTheme.to.greyColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: OutlinedButton(
                onPressed: () {
                  if (Get.isRegistered<ViewController>()) {
                    Get.find<ViewController>().onPageChanged(0);
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.to.primaryColor,
                  side: BorderSide(
                    color: AppTheme.to.primaryColor.withOpacity(0.4),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDecorations.radiusL),
                  ),
                ),
                child: Text(
                  'browse_products'.tr,
                  style: AppStyles.bodyBoldM,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
