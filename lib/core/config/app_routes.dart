import 'package:get/get.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/checkout_view.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/error404_view.dart';
import 'package:mybeshop/features/main/prenestation/views/main_view.dart';
import 'package:mybeshop/features/main/prenestation/views/settings_view.dart';

class AppRoutes {
  static const String main = '/';
  static const String settings = '/settings';
  static const String error = '/error';
  static const String checkout = '/checkout';

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
      page: () => const CheckoutView(),
    ),
  ];
}
