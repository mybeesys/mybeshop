import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_add_utils.dart';

/// Marks the product as in-cart and refreshes product list UI.
void markProductInCartState(Product product, {bool inCart = true}) {
  if (product.type == 'basic') {
    product.inCart = inCart;
  } else {
    CartController.to.variantDetails?.inCart = inCart;
  }
  refreshProductListUi();
}

void refreshProductListUi() {
  if (Get.isRegistered<MainController>()) {
    Get.find<MainController>().update();
  }
  CartController.to.update();
}

/// Haptic + snackbar shown after a successful add-to-cart.
void showAddedToCartFeedback(Product product) {
  HapticFeedback.mediumImpact();

  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }

  Get.rawSnackbar(
    message: 'added_to_cart_success'.tr,
    backgroundColor: AppTheme.to.successColor,
    margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
    borderRadius: 12.r,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 2),
    icon: Icon(
      LineAwesomeIcons.check_circle,
      color: Colors.white,
      size: 22.sp,
    ),
    shouldIconPulse: true,
    mainButton: TextButton(
      onPressed: () {
        Get.closeAllSnackbars();
        openCartTab();
      },
      child: Text(
        'view_cart'.tr,
        style: AppStyles.bodyBoldS.copyWith(color: Colors.white),
      ),
    ),
  );
}

void openCartTab() {
  if (Get.isRegistered<ViewController>()) {
    Get.find<ViewController>().onPageChanged(1);
  }
}

void onProductAddedSuccessfully(Product product) {
  markProductInCartState(product);
  showAddedToCartFeedback(product);
}

bool isProductInCart(Product product) => checkIsInCart(product);
