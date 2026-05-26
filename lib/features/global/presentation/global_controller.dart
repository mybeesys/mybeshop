import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mybeshop/core/config/app_config.dart';
import 'package:mybeshop/core/utils/platform/browser_location.dart';
import 'package:mybeshop/core/utils/platform/browser_path.dart';
import 'package:mybeshop/core/utils/store_slug_parser.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/errors/exceptions.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';
import 'package:mybeshop/features/global/domain/usecases/get_store_info_use_case.dart';
import 'package:mybeshop/features/global/domain/usecases/get_store_uuid_use_case.dart';
import 'package:mybeshop/core/utils/services/local_storage_service/local_storage_service.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

class GlobalController extends SuperController {
  static GlobalController get to => Get.find();
  static const _storeSlugStorageKey = 'store_slug';

  Locale currentLocale = const Locale('ar', 'SA');

  String? slug = "";
  String? storeUUID = "";
  String? baseURL;
  StoreInfo? storeInfo;
  RxBool isLoading = true.obs;
  String? storeLoadError;

  /// True when the web URL has no store slug (show slug entry instead of 404).
  bool get needsStoreSlug =>
      kIsWeb && (slug == null || slug!.isEmpty);

  Future<void> resolveStoreSlug() async {
    if (!kIsWeb) {
      baseURL = '';
      return;
    }
    baseURL = getBrowserHref() ?? '';
    final slugFromUrl = StoreSlugParser.parseFromHref(baseURL!) ?? '';
    slug = slugFromUrl;

    if (slug!.isEmpty) {
      slug = Get.find<LocalStorageService>().getString(_storeSlugStorageKey) ?? '';
    }
    if (slug!.isEmpty &&
        StoreSlugParser.isLocalDevHost(baseURL!) &&
        AppConfig.defaultStoreSlug.isNotEmpty) {
      slug = AppConfig.defaultStoreSlug;
    }
    if (slug!.isNotEmpty) {
      await Get.find<LocalStorageService>()
          .setString(_storeSlugStorageKey, slug!);
    }
  }

  Future<void> applyStoreSlug(String newSlug) async {
    slug = newSlug.trim();
    if (slug!.isEmpty) {
      return;
    }
    storeLoadError = null;
    await Get.find<LocalStorageService>()
        .setString(_storeSlugStorageKey, slug!);
    isLoading(true);
    update();
    await getStoreInfo();
    if (kIsWeb) {
      replaceBrowserPath(StoreSlugParser.storePath(slug!));
      baseURL = getBrowserHref() ?? baseURL;
    }
    if (Get.isRegistered<MainController>()) {
      Get.find<MainController>().getCategories();
    }
    if (Get.currentRoute == AppRoutes.error) {
      Get.offAllNamed(AppRoutes.main);
    }
    update();
  }

  void navigateAfterCheck() {
    if (!kIsWeb) {
      return;
    }
    log("THE SLUG IS : $slug");
    if (slug == null || slug!.isEmpty) {
      if (Get.currentRoute == AppRoutes.error) {
        Get.offAllNamed(AppRoutes.main);
      }
      return;
    }
    if (Get.currentRoute == AppRoutes.error) {
      Get.offAllNamed(AppRoutes.main);
    }
    if (baseURL!.contains("price-offers")) {
      Get.offAllNamed("${AppRoutes.priceOffer}/${slug ?? ""}");
    } else if (baseURL!.contains("supply-orders")) {
      Get.offAllNamed("${AppRoutes.supplyOrder}/${slug ?? ""}");
    } else {
      if (baseURL!.contains("envoice")) {
        Get.offAllNamed(AppRoutes.einvoice);
      }
    }
  }

  Future<void> getStoreInfo() async {
    if (slug == null || slug!.isEmpty) {
      isLoading(false);
      return;
    }
    final GetStoreInfoUseCase getStoreInfoUseCase =
        Get.find<GetStoreInfoUseCase>();
    final response = await getStoreInfoUseCase();

    response.fold((failure) {
      isLoading(false);
      if (kIsWeb) {
        storeLoadError = failure.message;
        if (failure.exception is NotFoundException) {
          slug = '';
          Get.find<LocalStorageService>().remove(_storeSlugStorageKey);
        }
        if (Get.currentRoute == AppRoutes.error) {
          Get.offAllNamed(AppRoutes.main);
        }
        update();
        return;
      }
      if (failure.exception is NotFoundException) {
        Get.toNamed(AppRoutes.error, arguments: {"message": failure.message});
      }
      update();
    }, (success) {
      storeInfo = success;
      storeLoadError = null;
      log(storeInfo.toString());
      isLoading(false);
      update();
      if (Get.isRegistered<MainController>()) {
        Get.find<MainController>().update();
      }
      if (Get.isRegistered<ViewController>()) {
        Get.find<ViewController>().update();
      }
    });
  }

  void changeCurrentLanguage(String code) {
    currentLocale = Locale(code);
    Get.updateLocale(currentLocale);
    Get.find<MainController>().onInit();
    update();
  }

  Future<void> getStoreUUID() async {
    final GetStoreUUIDUseCase getStoreUUIDUseCase =
        GetStoreUUIDUseCase(Get.find());
    storeUUID = await getStoreUUIDUseCase();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await resolveStoreSlug();
    await getStoreUUID();
    await getStoreInfo();
    navigateAfterCheck();
  }

  void slugSetter(s) {
    slug = s;
    update();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}

// 1 phones exp
// 2 reveraw
// 3 review client - einvoice
// 4 trview back
// 5. add barcode price offer
// 6. store logo all
// 7. show links tooltip