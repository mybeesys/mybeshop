import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/global/presentation/widgets/dev_store_slug_setup.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/mobile/custom_bottom_navigation_bar.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 841),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetBuilder<GlobalController>(
              init: Get.find<GlobalController>(),
              builder: (_) {
                if (GlobalController.to.needsStoreSlug) {
                  return const DevStoreSlugSetup();
                }
                if (GlobalController.to.isLoading.value) {
                  return Scaffold(
                    backgroundColor: AppTheme.to.backgroundColor,
                    body: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.to.primaryColor,
                      ),
                    ),
                  );
                }
                return GetBuilder<ViewController>(
                  init: Get.find<ViewController>(),
                  builder: (controller) {
                    return Scaffold(
                      backgroundColor: AppTheme.to.backgroundColor,
                      body: controller.views[controller.currentIndex],
                      bottomNavigationBar: const CustomBottomNavigationBar(),
                    );
                  },
                );
              });
        });
  }
}
