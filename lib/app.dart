import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/lang/languages.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 2720),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: GlobalController.to.currentLocale,
          translations: Languages(),
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.checkout,
          theme: AppTheme.to.appTheme(),
        );
      },
    );
  }
}
