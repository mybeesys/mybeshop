import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/app_dialogs.dart';
import 'package:mybeshop/core/widgets/app_network_image.dart';
import 'package:mybeshop/core/widgets/riyal_price_text.dart';
import 'package:mybeshop/features/main/domain/entities/cart_item.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart/cart_quantity_stepper.dart';

const _placeholderImage =
    'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    this.busy = false,
    this.compact = false,
  });

  final CartItem item;
  final bool busy;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final imageSize = compact ? 72.w : 88.w;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: compact ? 10.h : 12.h),
          decoration: AppDecorations.card(),
          child: Padding(
            padding: EdgeInsets.all(compact ? 10.w : 12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDecorations.radiusM),
                  child: Container(
                    width: imageSize,
                    height: imageSize,
                    color: AppTheme.to.backgroundColor,
                    child: AppNetworkImage(
                      imageUrl: item.image ?? _placeholderImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: AppStyles.bodyBoldM,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          _DeleteButton(
                            enabled: !busy,
                            onTap: () =>
                                CartController.to.deleteItemFromCart(item.id),
                          ),
                        ],
                      ),
                      if (item.extras.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        _ExtrasRow(item: item, enabled: !busy),
                      ],
                      SizedBox(height: 10.h),
                      if (compact)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: RiyalPriceText(
                                amount: item.priceFormatted,
                                formatted: true,
                                style: AppStyles.bodyBoldM.copyWith(
                                  color: AppTheme.to.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CartQuantityStepper(
                              qty: item.qty,
                              compact: compact,
                              enabled: !busy,
                              onDecrease: item.qty > 1
                                  ? () => CartController.to.updateCart(
                                        item,
                                        isIncrease: false,
                                      )
                                  : () => CartController.to.deleteItemFromCart(
                                        item.id,
                                      ),
                              onIncrease: () => CartController.to.updateCart(
                                item,
                                isIncrease: true,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RiyalPriceText(
                              amount: item.priceFormatted,
                              formatted: true,
                              style: AppStyles.bodyBoldM.copyWith(
                                color: AppTheme.to.primaryColor,
                              ),
                            ),
                            const Spacer(),
                            CartQuantityStepper(
                              qty: item.qty,
                              compact: compact,
                              enabled: !busy,
                              onDecrease: item.qty > 1
                                  ? () => CartController.to.updateCart(
                                        item,
                                        isIncrease: false,
                                      )
                                  : () => CartController.to.deleteItemFromCart(
                                        item.id,
                                      ),
                              onIncrease: () => CartController.to.updateCart(
                                item,
                                isIncrease: true,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (busy)
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.only(bottom: compact ? 10.h : 12.h),
              decoration: BoxDecoration(
                color: AppTheme.to.surfaceColor.withOpacity(0.82),
                borderRadius: BorderRadius.circular(AppDecorations.radiusL),
              ),
              child: Center(
                child: SizedBox(
                  width: 28.w,
                  height: 28.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppTheme.to.primaryColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.onTap, required this.enabled});

  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: AppTheme.to.saleColor.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            LineAwesomeIcons.trash,
            size: 16.sp,
            color: enabled
                ? AppTheme.to.saleColor
                : AppTheme.to.greyColor.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}

class _ExtrasRow extends StatelessWidget {
  const _ExtrasRow({required this.item, required this.enabled});

  final CartItem item;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
          },
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: item.extras.length,
          separatorBuilder: (_, __) => SizedBox(width: 6.w),
          itemBuilder: (context, index) {
            final extra = item.extras[index];
            return _ExtraChip(
              extra: extra,
              enabled: enabled,
              onRemove: () {
                Get.dialog(
                  AppDialogs.customDialog(
                    isLottie: true,
                    isLooping: false,
                    icon: 'delete.json',
                    title: 'warning'.tr,
                    okButtonText: 'yes'.tr,
                    cancelText: 'no'.tr,
                    message: 'are_you_sure_this_extra_will_be_deleted'.tr,
                    showCancelButton: true,
                    onPressed: () {
                      Get.back();
                      CartController.to.deleteItemFromCart(
                        item.id,
                        extraId: extra.id,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ExtraChip extends StatelessWidget {
  const _ExtraChip({
    required this.extra,
    required this.onRemove,
    required this.enabled,
  });

  final ProductExtra extra;
  final VoidCallback onRemove;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onRemove : null,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: AppDecorations.pill(selected: true),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                extra.name,
                style: AppStyles.bodyRegularS.copyWith(
                  color: AppTheme.to.textColor,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                LineAwesomeIcons.times,
                size: 10.sp,
                color: AppTheme.to.greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
