import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_styles.dart';

class Error404View extends StatelessWidget {
  Error404View({super.key});
  final arguments = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Lottie.asset("assets/lotties/404.json"),
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
