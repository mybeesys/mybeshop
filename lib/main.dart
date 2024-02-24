import 'package:flutter/material.dart';
import 'package:mybeshop/app.dart';
import 'package:mybeshop/core/config/injector_container.dart';

void main() {
  InjectorContainer.init();
  runApp(App());
}
