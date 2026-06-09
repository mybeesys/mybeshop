import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/navbar_social_media_buttons_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_list_card.dart';
import 'package:mybeshop/features/main/prenestation/widgets/store/category_chip.dart';
import 'package:mybeshop/features/main/prenestation/widgets/store/store_hero_banner.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(Get.find(), Get.find()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppTheme.to.backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: AppTheme.to.surfaceColor,
                surfaceTintColor: Colors.transparent,
                title: Row(
                  children: [
                    if (GlobalController.to.storeInfo?.logo != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          GlobalController.to.storeInfo!.logo!,
                          width: 32.w,
                          height: 32.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _storeIcon(),
                        ),
                      )
                    else
                      _storeIcon(),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        GlobalController.to.storeInfo?.name ?? '',
                        style: AppStyles.bodyBoldL,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                actions: _socialActions(),
              ),
              SliverToBoxAdapter(child: const StoreHeroBanner()),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 44.h,
                  child: controller.categoriesLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            final category = controller.categories[index];
                            return CategoryChip(
                              category: category,
                              selected: controller.selectedCategory?.id ==
                                  category.id,
                              onTap: () =>
                                  controller.onCategorySelected(category),
                            );
                          },
                        ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('products'.tr, style: AppStyles.heading6),
                      Text(
                        controller.selectedCategory != null
                            ? controller.selectedCategory!.name
                            : 'none'.tr,
                        style: AppStyles.bodyRegularM.copyWith(
                          color: AppTheme.to.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 12.h)),
              if (controller.categoriesLoading.value)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (controller.selectedCategory == null ||
                  controller.selectedCategory!.products.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LineAwesomeIcons.box_open,
                          size: 48.sp,
                          color: AppTheme.to.greyColor.withOpacity(0.5),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'no_products_to_show'.tr,
                          style: AppStyles.bodyMediumM.copyWith(
                            color: AppTheme.to.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ProductListCard(
                        product: controller.selectedCategory!.products[index],
                      ),
                      childCount:
                          controller.selectedCategory!.products.length,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _storeIcon() {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: AppTheme.to.backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        LineAwesomeIcons.store,
        size: 18.sp,
        color: AppTheme.to.primaryColor,
      ),
    );
  }

  List<Widget> _socialActions() {
    final social = GlobalController.to.storeInfo?.social ?? {};
    final items = <({IconData icon, String? key})>[
      (icon: LineAwesomeIcons.facebook_f, key: 'facebook'),
      (icon: LineAwesomeIcons.instagram, key: 'instagram'),
      (icon: LineAwesomeIcons.twitter, key: 'twitter'),
      (icon: LineAwesomeIcons.what_s_app, key: 'whatsapp'),
    ];

    return items
        .where((e) => social[e.key] != null && '${social[e.key]}'.isNotEmpty)
        .map(
          (e) => NavBarSocialMediaButtonWidget(
            compact: true,
            icon: e.icon,
            onPressed: () => launchUrlString('${social[e.key]}'),
          ),
        )
        .toList();
  }
}
