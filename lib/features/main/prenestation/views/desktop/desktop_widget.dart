import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/global/presentation/widgets/dev_store_slug_setup.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/desktop_store_body.dart';

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({
    super.key,
    required GlobalKey<ScaffoldState> skey,
  }) : _key = skey;

  final GlobalKey<ScaffoldState> _key;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: false,
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
            return GetBuilder<MainController>(
              builder: (controller) {
                return Scaffold(
                  key: _key,
                  backgroundColor: AppTheme.to.backgroundColor,
                  body: DesktopStoreBody(controller: controller),
                );
              },
            );
          },
        );
      },
    );
  }
}
