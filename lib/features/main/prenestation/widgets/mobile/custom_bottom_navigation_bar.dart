import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
        init: Get.find<ViewController>(),
        builder: (controller) {
          return BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: AppTheme.to.primaryColor,
              unselectedItemColor: AppTheme.to.greyColor.withOpacity(0.5),
              currentIndex: controller.currentIndex,
              onTap: (index) => controller.onPageChanged(index),
              items: [
                BottomNavigationBarItem(
                  label: "home".tr,
                  icon: const Icon(LineAwesomeIcons.home),
                ),
                BottomNavigationBarItem(
                  label: "cart".tr,
                  icon: const Icon(LineAwesomeIcons.shopping_cart),
                ),
                BottomNavigationBarItem(
                  label: "orders".tr,
                  icon: const Icon(LineAwesomeIcons.boxes),
                ),
                BottomNavigationBarItem(
                  label: "settings".tr,
                  icon: const Icon(LineAwesomeIcons.cog),
                )
              ]);
        });
  }
}
