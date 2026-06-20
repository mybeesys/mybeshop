import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/extenstions.dart';
import 'package:mybeshop/core/widgets/app_network_image.dart';
import 'package:mybeshop/core/widgets/riyal_price_text.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/domain/entities/variant_option.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_select_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_add_feedback.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_add_utils.dart';

const _placeholderImage =
    'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png';

/// Opens a bottom sheet to configure quantity / variants / extras before adding.
Future<void> showProductAddSheet(Product product) async {
  await CartController.to.onProductSelected(product);
  var canAdd = checkCanAdd(product);
  var isInCart = checkIsInCart(product);

  await Get.bottomSheet(
    GetBuilder<CartController>(
      builder: (controller) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            void refresh() => setSheetState(() {
                  canAdd = checkCanAdd(product);
                  isInCart = checkIsInCart(product);
                });

            final imageUrl = product.type == 'basic'
                ? (product.images.isNotEmpty
                    ? product.images.first
                    : _placeholderImage)
                : controller.variantDetails?.image ?? _placeholderImage;

            final maxQty = product.type == 'basic'
                ? (product.qty ?? 99)
                : (controller.variantDetails?.qty ?? 99);

            return Container(
              constraints: BoxConstraints(maxHeight: 0.9.sh),
              decoration: BoxDecoration(
                color: AppTheme.to.surfaceColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppDecorations.radiusXL),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8.h),
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppTheme.to.borderColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                      onPressed: Get.back,
                      icon: Icon(Icons.close_rounded, color: AppTheme.to.greyColor),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppDecorations.radiusM),
                            child: Container(
                              width: double.infinity,
                              height: 180.h,
                              color: AppTheme.to.backgroundColor,
                              child: AppNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(product.name, style: AppStyles.bodyBoldL),
                          if (product.description?.isNotEmpty == true) ...[
                            SizedBox(height: 6.h),
                            Text(
                              product.description!.removeHtmlTags(),
                              style: AppStyles.bodyRegularS.copyWith(
                                color: AppTheme.to.greyColor,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              RiyalPriceText(
                                amount: product.price ?? '0',
                                currency: product.currency,
                                style: AppStyles.bodyBoldM.copyWith(
                                  color: AppTheme.to.primaryColor,
                                ),
                              ),
                              if (product.hasDiscount == true) ...[
                                SizedBox(width: 8.w),
                                RiyalPriceText(
                                  amount: product.originalPrice ?? '',
                                  currency: product.currency,
                                  style: AppStyles.bodyRegularS.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppTheme.to.saleColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (product.type == 'variants') ...[
                            SizedBox(height: 16.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                for (final variantOption
                                    in product.variantsOptions)
                                  CustomSelectWidget(
                                    width: double.infinity,
                                    textStyle: AppStyles.bodyMediumS,
                                    name: variantOption.libraryName,
                                    onSelected: (v) async {
                                      await controller.onOptionSelected(v);
                                      refresh();
                                    },
                                    items: variantOption.options
                                        .map(
                                          (e) => DropdownMenuEntry(
                                            value: e,
                                            label: e.name,
                                          ),
                                        )
                                        .toList(),
                                  ),
                              ],
                            ),
                          ],
                          if (product.extras.isNotEmpty) ...[
                            SizedBox(height: 16.h),
                            Text('extras'.tr, style: AppStyles.bodyBoldM),
                            SizedBox(height: 8.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                for (final extra in product.extras)
                                  _ExtraChip(
                                    extra: extra,
                                    selected:
                                        controller.extras.contains(extra),
                                    onChanged: () {
                                      controller.onExtraSelected(extra);
                                      refresh();
                                    },
                                  ),
                              ],
                            ),
                          ],
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Text('qty'.tr, style: AppStyles.bodyMediumM),
                              const Spacer(),
                              _QtyStepper(
                                value: controller.qty,
                                min: 1,
                                max: maxQty > 0 ? maxQty : 99,
                                onChanged: (val) {
                                  controller.onQtyChanged(val);
                                  refresh();
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          if (controller.variantProductDetailsLoading.value)
                            Text('loading'.tr, style: AppStyles.bodyMediumM)
                          else
                            Row(
                              children: [
                                Text(
                                  '${'final_price'.tr} ',
                                  style: AppStyles.bodyMediumM,
                                ),
                                RiyalPriceText(
                                  amount: getTotalPriceAsText(product),
                                  currency: product.currency,
                                  style: AppStyles.bodyBoldM.copyWith(
                                    color: AppTheme.to.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: !canAdd || controller.isAddingToCart.value
                              ? null
                              : () => _onSubmit(
                                    product: product,
                                    isInCart: isInCart,
                                    refresh: refresh,
                                  ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isInCart
                                ? AppTheme.to.saleColor
                                : AppTheme.to.primaryColor,
                            foregroundColor: AppTheme.to.onPrimaryColor,
                            disabledBackgroundColor: AppTheme.to.greyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDecorations.radiusM),
                            ),
                            elevation: 0,
                          ),
                          child: controller.isAddingToCart.value
                              ? SizedBox(
                                  width: 22.w,
                                  height: 22.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppTheme.to.onPrimaryColor,
                                  ),
                                )
                              : Text(
                                  isInCart
                                      ? 'remove_from_cart'.tr
                                      : canAdd
                                          ? 'add_to_cart'.tr
                                          : 'out_of_stock'.tr,
                                  style: AppStyles.bodyBoldM,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
  );
}

Future<void> _onSubmit({
  required Product product,
  required bool isInCart,
  required VoidCallback refresh,
}) async {
  final controller = CartController.to;

  if (isInCart) {
    final cartItemId = _findCartItemId(product);
    if (cartItemId != null) {
      controller.deleteItemFromCart(cartItemId, withBack: false);
      _markProductNotInCart(product);
      Get.back();
    }
    return;
  }

  final added = await controller.addToCart();
  if (added) {
    _markProductInCart(product);
    Get.back();
    onProductAddedSuccessfully(product);
  }
}

String? _findCartItemId(Product product) {
  final items = CartController.to.shoppingCart?.items;
  if (items == null) {
    return null;
  }
  if (product.type == 'basic') {
    for (final item in items) {
      if (item.productId == product.id) {
        return item.id;
      }
    }
  } else {
    final variantId = CartController.to.variantDetails?.id;
    if (variantId == null) {
      return null;
    }
    for (final item in items) {
      if (item.productId == variantId) {
        return item.id;
      }
    }
  }
  return null;
}

void _markProductInCart(Product product) {
  if (product.type == 'basic') {
    product.inCart = true;
  } else {
    CartController.to.variantDetails?.inCart = true;
  }
}

void _markProductNotInCart(Product product) {
  if (product.type == 'basic') {
    product.inCart = false;
  } else {
    CartController.to.variantDetails?.inCart = false;
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.to.borderColor),
        borderRadius: BorderRadius.circular(AppDecorations.radiusM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            icon: Icons.remove_rounded,
            enabled: value > min,
            onTap: () => onChanged(value - 1),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 36.w),
            alignment: Alignment.center,
            child: Text('$value', style: AppStyles.bodyBoldM),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            enabled: value < max,
            onTap: () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(AppDecorations.radiusM),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Icon(
          icon,
          size: 20.sp,
          color: enabled ? AppTheme.to.primaryColor : AppTheme.to.greyColor,
        ),
      ),
    );
  }
}

class _ExtraChip extends StatelessWidget {
  const _ExtraChip({
    required this.extra,
    required this.selected,
    required this.onChanged,
  });

  final ProductExtra extra;
  final bool selected;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(extra.name, style: AppStyles.bodyMediumS),
          SizedBox(width: 6.w),
          RiyalPriceText(
            amount: extra.priceFormatted,
            formatted: true,
            style: AppStyles.bodyRegularSS.copyWith(
              color: selected ? AppTheme.to.textColor : AppTheme.to.greyColor,
            ),
          ),
        ],
      ),
      selected: selected,
      onSelected: (_) => onChanged(),
      selectedColor: AppTheme.to.primaryColor.withOpacity(0.25),
      checkmarkColor: AppTheme.to.textColor,
      backgroundColor: AppTheme.to.backgroundColor,
      side: BorderSide(
        color: selected
            ? AppTheme.to.primaryColor
            : AppTheme.to.borderColor,
      ),
    );
  }
}

/// Adds a simple product (no variants/extras) directly with qty 1.
Future<bool> quickAddBasicProduct(Product product) async {
  if (product.type != 'basic' ||
      product.extras.isNotEmpty ||
      product.inStock != true) {
    return false;
  }

  await CartController.to.onProductSelected(product);
  CartController.to.qty = 1;

  final added = await CartController.to.addToCart();
  if (added) {
    onProductAddedSuccessfully(product);
  }
  return added;
}

/// True when the product can be added in one tap without opening the sheet.
bool canQuickAdd(Product product) {
  return product.type == 'basic' &&
      product.extras.isEmpty &&
      product.inStock == true;
}
