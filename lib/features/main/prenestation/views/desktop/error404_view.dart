import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_styles.dart';

class Error404View extends GetResponsiveView {
  Error404View({super.key});
  final arguments = Get.arguments;
  @override
  Widget? desktop() {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 50.w),
      child: Column(
        children: [
          Expanded(child: Lottie.asset("assets/lotties/404.json")),
          SizedBox(
            height: 20.h,
          ),
          Text(
            arguments == null ? "Error" : "${arguments?["message"]}",
            style: AppStyles.heading2,
          ),
          // SizedBox(height: 40.h),
          // MaterialButton(onPressed: (){},child: Text("data"),)
        ],
      ),
    ));
  }

  @override
  Widget? phone() {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/lotties/404.json", height: 130.h),
          SizedBox(
            height: 20.h,
          ),
          Text(
            arguments == null ? "Error" : "${arguments?["message"]}",
            style: AppStyles.heading2,
          ),
          // SizedBox(height: 40.h),
          // MaterialButton(onPressed: (){},child: Text("data"),)
        ],
      ),
    ));
  }

  @override
  Widget? tablet() {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 50.w),
      child: Column(
        children: [
          Expanded(child: Lottie.asset("assets/lotties/404.json")),
          SizedBox(
            height: 20.h,
          ),
          Text(
            arguments == null ? "Error" : "${arguments?["message"]}",
            style: AppStyles.heading2,
          ),
          // SizedBox(height: 40.h),
          // MaterialButton(onPressed: (){},child: Text("data"),)
        ],
      ),
    ));
  }
}
