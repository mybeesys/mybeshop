import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';

class Error404View extends StatefulWidget {
  const Error404View({super.key});

  @override
  State<Error404View> createState() => _Error404ViewState();
}

class _Error404ViewState extends State<Error404View> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GlobalController.to.recoverFromErrorRoute();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final message = arguments == null
        ? 'the_page_not_found'.tr
        : '${arguments['message']}';

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 50.w, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Lottie.asset('assets/lotties/404.json')),
            SizedBox(height: 20.h),
            Text(
              message,
              style: AppStyles.heading2,
              textAlign: TextAlign.center,
            ),
            if (kIsWeb) ...[
              SizedBox(height: 24.h),
              FilledButton(
                onPressed: GlobalController.to.recoverFromErrorRoute,
                child: Text('back_to_home'.tr),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
