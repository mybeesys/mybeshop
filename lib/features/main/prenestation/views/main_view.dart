import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/desktop_widget.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/mobile_view.dart';

// import 'dart:js' as js;

class MainView extends GetResponsiveView<MainController> {
  MainView({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  Widget? desktop() {
    return DesktopWidget(skey: _key);
  }

  @override
  Widget? phone() {
    return const MobileView();
  }

  @override
  Widget? tablet() {
    return const MobileView();
  }
}
