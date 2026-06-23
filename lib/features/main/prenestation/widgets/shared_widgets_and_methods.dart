// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_add_feedback.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_add_bottom_sheet.dart';

String? getHasExtrasOrVariantsText(Product product) {
  if (product.type == "variants" && product.extras.isEmpty) {
    return "the_product_has_variants".tr;
  } else if (product.type == "variant" && product.extras.isNotEmpty) {
    return "the_product_has_variants_and_extras".tr;
  } else if (product.type == "basic" && product.extras.isNotEmpty) {
    return "the_product_has_extras".tr;
  } else {
    return null;
  }
}

Widget addToCartButton(
  Product product, {
  height = 140,
  width = double.infinity,
}) {
  return GetBuilder<MainController>(
    builder: (_) {
      return GetBuilder<CartController>(
        builder: (cart) {
          final inCart = isProductInCart(product);
          final loading = cart.productSelectedLoading.value &&
              product == cart.selectedProduct;

          return MaterialButton(
            height: height,
            clipBehavior: Clip.none,
            disabledColor: AppTheme.to.primaryColor.withOpacity(0.4),
            onPressed: loading
                ? null
                : () async {
                    if (inCart) {
                      openCartTab();
                      return;
                    }
                    await addToCartAction(product);
                  },
            minWidth: width,
            color: inCart
                ? AppTheme.to.successColor
                : AppTheme.to.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: loading
                ? SizedBox(
                    width: 22.h,
                    height: 22.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: inCart
                          ? Colors.white
                          : AppTheme.to.onPrimaryColor,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        inCart
                            ? LineAwesomeIcons.check_circle
                            : LineAwesomeIcons.shopping_cart,
                        size: 16.sp,
                        color: inCart
                            ? Colors.white
                            : AppTheme.to.onPrimaryColor,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        inCart ? 'in_cart'.tr : 'add_to_cart'.tr,
                        style: AppStyles.bodyBoldM.copyWith(
                          color: inCart
                              ? Colors.white
                              : AppTheme.to.onPrimaryColor,
                        ),
                      ),
                    ],
                  ),
          );
        },
      );
    },
  );
}

Widget addToCartMobileButton(Product product) {
  return _ProductAddMobileButton(product: product);
}

class _ProductAddMobileButton extends StatefulWidget {
  const _ProductAddMobileButton({required this.product});

  final Product product;

  @override
  State<_ProductAddMobileButton> createState() =>
      _ProductAddMobileButtonState();
}

class _ProductAddMobileButtonState extends State<_ProductAddMobileButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _pulseScale = Tween<double>(begin: 1, end: 1.14).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    final product = widget.product;
    if (isProductInCart(product)) {
      openCartTab();
      return;
    }
    if (canQuickAdd(product)) {
      final added = await quickAddBasicProduct(product);
      if (added && mounted) {
        await _pulseController.forward(from: 0);
        _pulseController.reverse();
      }
      return;
    }
    await showProductAddSheet(product);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (_) {
        return GetBuilder<CartController>(
          builder: (cart) {
            final product = widget.product;
            final inCart = isProductInCart(product);
            final loading = cart.productSelectedLoading.value &&
                product == cart.selectedProduct;
            final adding = cart.isAddingToCart.value &&
                product == cart.selectedProduct;

            final bgColor =
                inCart ? AppTheme.to.successColor : AppTheme.to.primaryColor;
            final iconColor =
                inCart ? Colors.white : AppTheme.to.onPrimaryColor;

            return ScaleTransition(
              scale: _pulseScale,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: (loading || adding) ? null : _handleTap,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    width: 44.h,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: bgColor.withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: loading || adding
                        ? Padding(
                            padding: EdgeInsets.all(10.r),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: iconColor,
                            ),
                          )
                        : Icon(
                            inCart
                                ? LineAwesomeIcons.check
                                : LineAwesomeIcons.plus,
                            color: iconColor,
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Future<void> addToCartAction(Product product) async {
  if (canQuickAdd(product)) {
    await quickAddBasicProduct(product);
    return;
  }
  await showProductAddSheet(product);
}
