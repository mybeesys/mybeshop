import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/app_shimmer_loader.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/desktop_product_cards.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/empty_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/store/desktop_category_sidebar.dart';
import 'package:mybeshop/features/main/prenestation/widgets/store/desktop_store_header.dart';

class DesktopStoreBody extends StatelessWidget {
  const DesktopStoreBody({super.key, required this.controller});

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DesktopStoreHeader(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: DesktopCategorySidebar(controller: controller),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text('products'.tr, style: AppStyles.heading6),
                            const Spacer(),
                            Text(
                              controller.selectedCategory?.name ?? 'none'.tr,
                              style: AppStyles.bodyRegularM.copyWith(
                                color: AppTheme.to.greyColor,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            IconButton(
                              tooltip: controller.isGrid ? 'List' : 'Grid',
                              onPressed: controller.changeProductsLayout,
                              icon: Icon(
                                controller.isGrid
                                    ? LineAwesomeIcons.list
                                    : LineAwesomeIcons.th_large,
                                color: AppTheme.to.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        _ProductSection(isGrid: controller.isGrid),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: AppDecorations.card(),
                      child: const CartWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductSection extends StatelessWidget {
  const _ProductSection({required this.isGrid});

  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController.to,
      builder: (_) {
        final main = Get.find<MainController>();
        if (main.categoriesLoading.value) {
          return isGrid
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemBuilder: (_, __) => AppShimmerLoader.showShimmerLoader(
                    borderRadius: 12,
                    height: 180.h,
                  ),
                )
              : Column(
                  children: List.generate(
                    3,
                    (_) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: AppShimmerLoader.showShimmerLoader(
                        width: double.infinity,
                        height: 120.h,
                        borderRadius: 12,
                      ),
                    ),
                  ),
                );
        }

        final products = main.selectedCategory?.products ?? [];
        if (products.isEmpty) {
          return const EmptyProductsWidget();
        }

        if (isGrid) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemBuilder: (_, index) =>
                DesktopGridProductCard(product: products[index]),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (_, index) =>
              DesktopListProductCard(product: products[index]),
        );
      },
    );
  }
}
