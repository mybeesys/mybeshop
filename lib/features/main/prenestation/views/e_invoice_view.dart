import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/e_invoice_desktop_view.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/e_invoice_mobile_view.dart';

class EInoviceView extends GetResponsiveView {
  EInoviceView({super.key});
  final invoiceNo = GlobalController.to.slug;
  @override
  Widget? desktop() {
    return EInvoiceDesktopView(invoiceNo: invoiceNo ?? "");
  }

  @override
  Widget? phone() {
    return EInvoiceMobileView(
      invoiceNo: invoiceNo ?? "",
    );
  }

  @override
  Widget? tablet() {
    return EInvoiceMobileView(
      invoiceNo: invoiceNo ?? "",
    );
  }
}
