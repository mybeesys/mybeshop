import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
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
          return GetBuilder<ViewController>(
              init: Get.find<ViewController>(),
              builder: (controller) {
                if (GlobalController.to.isLoading.value) {
                  return Scaffold(
                    body: Center(
                      child: Lottie.asset("assets/lotties/loader.json",
                          height: 200.h),
                    ),
                  );
                } else {
                  return Scaffold(
                    body: controller.views[controller.currentIndex],
                    bottomNavigationBar: const CustomBottomNavigationBar(),
                  );
                }
              });
        });
  }
}
