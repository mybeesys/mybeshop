import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AppLoaders {
  static Future<void> showLoading({String? message}) async {
    await Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
          child: AlertDialog(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onVerticalDragStart: (v) {
                    Get.back();
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      "assets/lotties/loader.json",
                      height: 350.h,
                      repeat: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> hideLoading() async {
    if (Get.isDialogOpen!) Get.back();
  }
}
