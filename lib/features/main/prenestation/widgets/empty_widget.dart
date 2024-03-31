import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_styles.dart';

class EmptyProductsWidget extends StatelessWidget {
  const EmptyProductsWidget({
    this.message,
    super.key,
  });
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset("assets/lotties/empty_products.json"),
        ),
        SizedBox(height: 20.h),
        Text(
          message ?? "no_products_to_show".tr,
          style: AppStyles.bodyMediumL,
        ),
      ],
    );
  }
}
