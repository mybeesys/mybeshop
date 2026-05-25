import 'package:flutter/material.dart';
import 'package:mybeshop/app.dart';
import 'package:mybeshop/core/config/injector_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectorContainer.init();
  runApp(const App());
}
