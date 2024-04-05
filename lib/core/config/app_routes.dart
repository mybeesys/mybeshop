import 'package:get/get.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/checkout_view.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/error404_view.dart';
import 'package:mybeshop/features/main/prenestation/views/e_invoice_view.dart';
import 'package:mybeshop/features/main/prenestation/views/main_view.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/checkout_completed_view.dart';
import 'package:mybeshop/features/main/prenestation/views/price_offer_view.dart';
import 'package:mybeshop/features/main/prenestation/views/settings_view.dart';
import 'package:mybeshop/features/main/prenestation/views/supply_order_view.dart';
import 'package:mybeshop/features/main/prenestation/views/track_orders.dart';

class AppRoutes {
  static const String main = '/';
  static const String settings = '/settings';
  static const String error = '/error';
  static const String checkout = '/checkout';
  static const String trackOrders = '/track_orders';
  static const String checkoutCompleted = '/checkout_completed';
  static const String einvoice = '/einvoice';
  static const String priceOffer = '/price-offers';
  static const String supplyOrder = '/supply-orders';

  static final List<GetPage> routes = [
    GetPage(
      name: main,
      page: () => MainView(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsView(),
    ),
    GetPage(
      name: error,
      page: () => Error404View(),
    ),
    GetPage(
      name: checkout,
      page: () => CheckoutView(),
    ),
    GetPage(
      name: trackOrders,
      page: () => TrackOrdersView(),
    ),
    GetPage(
      name: checkoutCompleted,
      page: () => const CheckoutCompletedView(),
    ),
    GetPage(
      name: einvoice,
      page: () => EInoviceView(),
    ),
    GetPage(
      name: priceOffer,
      page: () => PriceOfferView(),
    ),
    GetPage(
      name: supplyOrder,
      page: () => SupplyOrderView(),
    ),
  ];
}
