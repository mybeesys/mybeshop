import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/price_offer_desktop_view.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/price_offer_mobile_view.dart';

class PriceOfferView extends GetResponsiveView {
  PriceOfferView({super.key});
  final priceOfferNo = GlobalController.to.slug;

  @override
  Widget? desktop() {
    return PriceOfferDesktopView(priceOfferNo: priceOfferNo ?? "");
  }

  @override
  Widget? phone() {
    return PriceOfferMobileView(
      priceOfferNo: priceOfferNo ?? "",
    );
  }

  @override
  Widget? tablet() {
    return PriceOfferMobileView(
      priceOfferNo: priceOfferNo ?? "",
    );
  }
}
