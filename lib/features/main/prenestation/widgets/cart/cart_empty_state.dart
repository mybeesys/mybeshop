import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({super.key, this.dense = false});

  /// Smaller layout for desktop sidebar (narrow column).
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final illustrationSize = dense ? 88.w : 180.w;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 12.w : 32.w,
        vertical: dense ? 8.h : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: illustrationSize,
            height: illustrationSize,
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
          SizedBox(height: dense ? 12.h : 24.h),
          Text(
            'your_cart_is_empty'.tr,
            style: dense ? AppStyles.bodyBoldM : AppStyles.heading5,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: dense ? 4.h : 8.h),
          Text(
            'cart_empty_hint'.tr,
            style: AppStyles.bodyRegularS.copyWith(
              color: AppTheme.to.greyColor,
              fontSize: dense ? 11.sp : null,
            ),
            textAlign: TextAlign.center,
            maxLines: dense ? 3 : null,
            overflow: dense ? TextOverflow.ellipsis : null,
          ),
          if (!dense) ...[
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
        ],
      ),
    );
  }
}
