import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/track_orders_desktop_view.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/track_orders_mobile_view.dart';

class TrackOrdersView extends GetResponsiveView {
  TrackOrdersView({super.key});

  @override
  Widget? desktop() {
    return const TrackOrdersDesktopView();
  }

  @override
  Widget? phone() {
    return const TrackOrdersMobileView();
  }

  @override
  Widget? tablet() {
    return const TrackOrdersDesktopView();
  }
}
