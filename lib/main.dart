import 'package:flutter/material.dart';
import 'package:mybeshop/app.dart';
import 'package:mybeshop/core/config/injector_container.dart';
import 'package:mybeshop/core/utils/platform/web_entry_redirect.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prepareWebEntryUrl();
  await InjectorContainer.init();
  runApp(const App());
}
