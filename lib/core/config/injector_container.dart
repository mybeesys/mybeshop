import 'package:dio/dio.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:get/get.dart';
import 'package:mybeshop/core/api/dio_consumer.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/services/local_storage_service/local_storage_service.dart';
import 'package:mybeshop/core/utils/services/local_storage_service/local_storage_service_shared_preferences_impl.dart';
import 'package:mybeshop/features/global/data/datasources/global_remote_data_source.dart';
import 'package:mybeshop/features/global/data/repositories/global_repository_impl.dart';
import 'package:mybeshop/features/global/domain/repositories/global_repository.dart';
import 'package:mybeshop/features/global/domain/usecases/get_store_info_use_case.dart';
import 'package:mybeshop/features/main/data/datasources/main_local_data_source.dart';
import 'package:mybeshop/features/main/data/repositories/main_repository_impl.dart';
import 'package:mybeshop/features/main/domain/usecases/add_to_cart_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/apply_coupon_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/checkout_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/clear_shopping_cart_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/delete_item_from_cart_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_areas_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_categories_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_cities_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_e_invoice_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_orders_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_products_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_shopping_cart_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_states_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_variant_product_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/update_cart_use_case.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/global/presentation/global_controller.dart';
import '../../features/main/data/datasources/main_remote_data_source.dart';
import '../../features/main/domain/repositories/main_repository.dart';
import '../api/api_consumer.dart';

class InjectorContainer {
  static Future<void> init() async {
    if (GetPlatform.isWeb) {
      setUrlStrategy(PathUrlStrategy());
      // Get.putAsync(() => DeviceInfoService().init());
    }
    Get.put(AppTheme());
    // Externals
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // Globals
    // try {
    //   await FirebaseServices().dependencies();
    // } catch (e) {
    //   log(e.toString());
    // }
    // Services
    Get.lazyPut(() => Dio(), fenix: true);
    Get.lazyPut<ApiConsumer>(() => DioConsumer(client: Get.find()),
        fenix: true);
    Get.lazyPut<LocalStorageService>(
        () => LocalStorageServiceSharedPreferencesImpl(preferences),
        fenix: true);

    // Get.put(HomeController());
    GlobalInjector.init();
    MainFeatureInjector.init();
  }
}

class GlobalInjector {
  static void init() {
    // Core
    // Get.put(NetworkCheckerController());

    // Data Sources
    Get.lazyPut<GlobalRemoteDataSource>(
        () => GlobalRemoteDataSourceImpl(Get.find()),
        fenix: true);
    // // Repositories
    Get.lazyPut<GlobalRepository>(
        () => GlobalRepositoryImpl(globalRemoteDataSource: Get.find()),
        fenix: true);
    // UseCases
    Get.lazyPut(() => GetStoreInfoUseCase(Get.find()), fenix: true);
    // Get.lazyPut(() => GetCountriesUseCase(Get.find()), fenix: true);
    // Get.lazyPut(() => GetUserInfoUseCase(Get.find()), fenix: true);

    // Contorllers
    // Get.put(AppStartController(Get.find()));
    Get.put(GlobalController());
    Get.put(ViewController());
  }
}

class MainFeatureInjector {
  static void init() {
    // Data Dources
    Get.lazyPut<MainRemoteDataSource>(
        () => MainRemoteDataSourceImpl(Get.find()),
        fenix: true);

    Get.lazyPut<MainLocalDataSource>(() => MainLocalDataSourceImpl(Get.find()),
        fenix: true);
    // Repositories
    Get.lazyPut<MainRepository>(
        () => MainRepositoryImpl(
            mainRemoteDataSource: Get.find(), mainLocalDataSource: Get.find()),
        fenix: true);
    // UseCases
    Get.lazyPut(() => GetCategoriesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetProductsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetVariantProductUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetShoppingCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => ClearShoppingCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddToCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateCartUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteItemFromCartUseCase(Get.find()), fenix: true);
    // Locations
    Get.lazyPut(() => GetStatesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetCitiesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetAreasUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => CheckoutUseCase(Get.find()), fenix: true);
    // Track Orders
    Get.lazyPut(() => GetOrdersUseCase(Get.find()), fenix: true);
    // EInvoices
    Get.lazyPut(() => GetEInvoiceUseCase(Get.find()), fenix: true);
    // ApplyCoupon
    Get.lazyPut(() => ApplyCouponUseCase(Get.find()), fenix: true);

    // Controllers
    Get.put(CartController());
  }
}
