import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/supply_order_desktop_view.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/supply_order_mobile_view.dart';

class SupplyOrderView extends GetResponsiveView {
  SupplyOrderView({super.key});

  final supplyOrderNo = GlobalController.to.slug;

  @override
  Widget? desktop() {
    return SupplyOrderDesktopView(supplyOrderNo: supplyOrderNo ?? "");
  }

  @override
  Widget? phone() {
    return SupplyOrderMobileView(supplyOrderNo: supplyOrderNo ?? "");
  }

  @override
  Widget? tablet() {
    return SupplyOrderMobileView(supplyOrderNo: supplyOrderNo ?? "");
  }
}
