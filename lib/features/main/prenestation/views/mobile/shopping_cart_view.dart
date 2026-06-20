import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart/cart_checkout_bar.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart/cart_empty_state.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart/cart_item_card.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      final cart = controller.shoppingCart;
      final hasItems = cart != null && cart.items.isNotEmpty;
      final itemCount = cart?.items.length ?? 0;

      return Scaffold(
        backgroundColor: AppTheme.to.backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppTheme.to.primaryColor,
          foregroundColor: AppTheme.to.onPrimaryColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'shopping_cart'.tr,
                style: AppStyles.bodyBoldM.copyWith(
                  color: AppTheme.to.onPrimaryColor,
                ),
              ),
              if (hasItems)
                Text(
                  'cart_items_count'.trParams({'count': '$itemCount'}),
                  style: AppStyles.bodyRegularS.copyWith(
                    color: AppTheme.to.onPrimaryColor.withOpacity(0.75),
                  ),
                ),
            ],
          ),
          actions: [
            if (hasItems)
              TextButton.icon(
                onPressed: controller.clearShoppingCart,
                icon: Icon(
                  LineAwesomeIcons.trash,
                  size: 16.sp,
                  color: AppTheme.to.onPrimaryColor.withOpacity(0.85),
                ),
                label: Text(
                  'clear_shopping_cart'.tr,
                  style: AppStyles.bodyRegularS.copyWith(
                    color: AppTheme.to.onPrimaryColor.withOpacity(0.85),
                  ),
                ),
              ),
            SizedBox(width: 4.w),
          ],
        ),
        body: controller.shopingCartLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppTheme.to.primaryColor,
                ),
              )
            : !hasItems
                ? const CartEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                    itemCount: cart!.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return CartItemCard(
                        item: item,
                        busy: controller.isCartItemBusy(item.id),
                      );
                    },
                  ),
        bottomNavigationBar: !controller.shopingCartLoading.value && hasItems
            ? CartCheckoutBar(cart: cart!)
            : null,
      );
    });
  }
}
