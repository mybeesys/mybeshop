import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/app_shimmer_loader.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart/cart_checkout_bar.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart/cart_empty_state.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart/cart_item_card.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    this.compact = true,
    this.sidebar = false,
  });

  /// Mobile / full-width cart layout.
  final bool compact;

  /// Narrow desktop sidebar — compact item rows, full checkout bar.
  final bool sidebar;

  bool get _itemCompact => compact || sidebar;

  bool get _checkoutCompact => compact && !sidebar;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.find<CartController>(),
      builder: (controller) {
        final cart = controller.shoppingCart;
        final hasItems = cart != null && cart.items.isNotEmpty;
        final itemCount = cart?.items.length ?? 0;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sidebar ? 14.w : 20.w,
            vertical: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('shopping_cart'.tr, style: AppStyles.heading5),
                        if (hasItems)
                          Text(
                            'cart_items_count'
                                .trParams({'count': '$itemCount'}),
                            style: AppStyles.bodyRegularS.copyWith(
                              color: AppTheme.to.greyColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (hasItems)
                    sidebar
                        ? IconButton(
                            tooltip: 'clear_shopping_cart'.tr,
                            onPressed: controller.clearShoppingCart,
                            icon: Icon(
                              LineAwesomeIcons.trash,
                              size: 18.sp,
                              color: AppTheme.to.saleColor,
                            ),
                          )
                        : TextButton.icon(
                            onPressed: controller.clearShoppingCart,
                            icon: Icon(
                              LineAwesomeIcons.trash,
                              size: 16.sp,
                              color: AppTheme.to.saleColor,
                            ),
                            label: Text(
                              'clear_shopping_cart'.tr,
                              style: AppStyles.bodyMediumS.copyWith(
                                color: AppTheme.to.saleColor,
                              ),
                            ),
                          ),
                ],
              ),
              SizedBox(height: 16.h),
              if (controller.shopingCartLoading.value)
                ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => AppShimmerLoader.showShimmerLoader(
                    width: double.infinity,
                    height: 110.h,
                    borderRadius: AppDecorations.radiusL,
                    bottomMargin: 12.h,
                  ),
                )
              else if (!hasItems)
                CartEmptyState(dense: sidebar || !compact)
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return CartItemCard(
                      item: item,
                      busy: controller.isCartItemBusy(item.id),
                      compact: _itemCompact,
                    );
                  },
                ),
              if (!controller.shopingCartLoading.value && hasItems) ...[
                SizedBox(height: 8.h),
                CartCheckoutBar(cart: cart, compact: _checkoutCompact),
              ],
            ],
          ),
        );
      },
    );
  }
}
