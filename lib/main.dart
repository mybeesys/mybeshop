import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/app.dart';
import 'package:mybeshop/core/config/injector_container.dart';
import 'package:mybeshop/core/utils/platform/web_entry_redirect.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prepareWebEntryUrl();
  await InjectorContainer.init();
  await Get.find<GlobalController>().bootstrap();
  runApp(const App());
}
