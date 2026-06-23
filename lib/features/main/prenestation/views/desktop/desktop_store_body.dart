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

  static const double _maxContentWidth = 1280;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DesktopStoreHeader(),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: _maxContentWidth.w),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 240.w,
                      child: DesktopCategorySidebar(controller: controller),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: _ProductsPanel(controller: controller),
                    ),
                    SizedBox(width: 20.w),
                    SizedBox(
                      width: 320.w,
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: AppDecorations.card(),
                          child: const CartWidget(sidebar: true),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductsPanel extends StatelessWidget {
  const _ProductsPanel({required this.controller});

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('products'.tr, style: AppStyles.heading5),
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
        Expanded(
          child: SingleChildScrollView(
            child: _ProductSection(isGrid: controller.isGrid),
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
              ? _ProductGrid(
                  itemCount: 4,
                  itemBuilder: (_, __) => AppShimmerLoader.showShimmerLoader(
                    borderRadius: 12,
                    height: 220.h,
                  ),
                )
              : Column(
                  children: List.generate(
                    3,
                    (_) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: AppShimmerLoader.showShimmerLoader(
                        width: double.infinity,
                        height: 132.h,
                        borderRadius: 12,
                      ),
                    ),
                  ),
                );
        }

        final products = main.selectedCategory?.products ?? [];
        if (products.isEmpty) {
          return SizedBox(
            height: 320.h,
            child: const EmptyProductsWidget(),
          );
        }

        if (isGrid) {
          return _ProductGrid(
            itemCount: products.length,
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

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 720
            ? 3
            : constraints.maxWidth >= 460
                ? 2
                : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: crossAxisCount == 1 ? 2.4 : 0.78,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
