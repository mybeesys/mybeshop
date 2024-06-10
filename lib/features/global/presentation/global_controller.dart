import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/errors/exceptions.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';
import 'package:mybeshop/features/global/domain/usecases/get_store_info_use_case.dart';
import 'package:mybeshop/features/global/domain/usecases/get_store_uuid_use_case.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

class GlobalController extends SuperController {
  static GlobalController get to => Get.find();

  Locale currentLocale = const Locale('ar', 'SA');

  String? slug = "";
  String? storeUUID = "";
  String? baseURL;
  StoreInfo? storeInfo;
  RxBool isLoading = true.obs;

  void getSlugFromURL() {
    baseURL = "${js.context["location"]["href"]}";
    var segment = baseURL.toString().split("/");
    slug = segment.lastWhere((segment) => segment.isNotEmpty, orElse: () => '');
    if (!(baseURL!.contains("shop") ||
        baseURL!.contains("einvoice") ||
        baseURL!.contains("price-offers") ||
        baseURL!.contains("supply-orders"))) {
      slug = "";
    }
  }

  void navigateAfterCheck() {
    log("THE SLUG IS : $slug");
    if (slug == null || slug == "") {
      Get.toNamed(AppRoutes.error,
          arguments: {"message": "the_page_not_found".tr});
    } else if (baseURL!.contains("price-offers")) {
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
    if (baseURL!.contains("shop")) {
      final GetStoreInfoUseCase getStoreInfoUseCase =
          Get.find<GetStoreInfoUseCase>();
      final response = await getStoreInfoUseCase();

      response.fold((failure) {
        if (failure.exception is NotFoundException) {
          Get.toNamed(AppRoutes.error, arguments: {"message": failure.message});
        }
      }, (success) {
        storeInfo = success;
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
  void onInit() async {
    getSlugFromURL();
    await getStoreUUID();

    await getStoreInfo();
    super.onInit();
  }

  @override
  void onReady() {
    navigateAfterCheck();
    super.onReady();
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