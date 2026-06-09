import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
      init: Get.find<ViewController>(),
      builder: (controller) {
        return NavigationBar(
          selectedIndex: controller.currentIndex,
          onDestinationSelected: controller.onPageChanged,
          height: 64.h,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: const Icon(LineAwesomeIcons.home),
              label: 'home'.tr,
            ),
            NavigationDestination(
              icon: const Icon(LineAwesomeIcons.shopping_cart),
              label: 'cart'.tr,
            ),
            NavigationDestination(
              icon: const Icon(LineAwesomeIcons.boxes),
              label: 'orders'.tr,
            ),
            NavigationDestination(
              icon: const Icon(LineAwesomeIcons.cog),
              label: 'settings'.tr,
            ),
          ],
        );
      },
    );
  }
}
