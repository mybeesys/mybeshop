import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/widgets/riyal_price_text.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';

class CartCheckoutBar extends StatelessWidget {
  const CartCheckoutBar({
    super.key,
    required this.cart,
    this.compact = false,
  });

  final ShoppingCart cart;
  final bool compact;

  String get _totalFormatted {
    final total = cart.subTotal + cart.tax;
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.to.surfaceColor,
        border: Border(top: BorderSide(color: AppTheme.to.borderColor)),
        boxShadow: AppDecorations.elevatedShadow,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SummaryRow(
                label: 'sub_total'.tr,
                amount: cart.subTotalFotmatted,
              ),
              SizedBox(height: 6.h),
              _SummaryRow(
                label: 'tax'.tr,
                amount: cart.taxFormatted,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'total'.tr,
                          style: AppStyles.bodyRegularS.copyWith(
                            color: AppTheme.to.greyColor,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        RiyalPriceText(
                          amount: _totalFormatted,
                          style: AppStyles.heading5.copyWith(
                            color: AppTheme.to.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: compact ? 1 : 2,
                    child: SizedBox(
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(AppRoutes.checkout),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.to.primaryColor,
                          foregroundColor: AppTheme.to.onPrimaryColor,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppDecorations.radiusL),
                          ),
                        ),
                        child: Text(
                          'checkout'.tr,
                          style: AppStyles.bodyBoldM.copyWith(
                            color: AppTheme.to.onPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.amount});

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.bodyRegularS.copyWith(
            color: AppTheme.to.greyColor,
          ),
        ),
        RiyalPriceText(
          amount: amount,
          formatted: true,
          style: AppStyles.bodyMediumS,
        ),
      ],
    );
  }
}
