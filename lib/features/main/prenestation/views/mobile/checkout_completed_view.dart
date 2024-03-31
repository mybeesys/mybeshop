import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

class CheckoutCompletedView extends StatelessWidget {
  const CheckoutCompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 107.h,
                child: Lottie.asset("assets/lotties/checkout_completed.json"),
              ),
              SizedBox(height: 10.h),
              Text(
                "checkout_completed".tr,
                style: AppStyles.bodyMediumM.copyWith(color: Colors.red),
              ),
              SizedBox(height: 30.h),
              MaterialButton(
                onPressed: () {
                  if (Get.isRegistered<ViewController>()) {
                    ViewController.to.onPageChanged(0);
                    Get.back();
                  }
                },
                height: 55.h,
                minWidth: double.infinity,
                color: AppTheme.to.primaryColor,
                child: Text(
                  "back_to_home".tr,
                  style: AppStyles.bodyMediumM.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
