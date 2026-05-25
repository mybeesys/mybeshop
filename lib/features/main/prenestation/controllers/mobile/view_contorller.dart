import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/home_view.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/shopping_cart_view.dart';
import 'package:mybeshop/features/main/prenestation/views/settings_view.dart';
import 'package:mybeshop/features/main/prenestation/views/track_orders.dart';

class ViewController extends GetxController {
  List<Widget> views = [
    const HomeView(),
    const ShoppingCartView(),
    TrackOrdersView(),
    const SettingsView(),
  ];
  static ViewController get to => Get.find();
  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;

    update();
  }

  @override
  void onInit() {
    log("View Controller Is Working Great");
    super.onInit();
  }
}
