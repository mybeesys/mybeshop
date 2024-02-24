import 'dart:developer';
import 'dart:js' as js;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/errors/exceptions.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';
import 'package:mybeshop/features/global/domain/usecases/get_store_info_use_case.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';

class GlobalController extends SuperController {
  static GlobalController get to => Get.find();

  Locale currentLocale = const Locale('ar', 'SA');

  String? slug = "apple";
  StoreInfo? storeInfo;
  RxBool isLoading = true.obs;

  void getSlugFromURL() {
    var baseURL = (js.context["location"]["href"]);
    var segment = baseURL.toString().split("/");
    slug = segment.lastWhere((segment) => segment.isNotEmpty, orElse: () => '');
    if (slug == null || slug == "") {
      Get.toNamed(AppRoutes.error,
          arguments: {"message": "the_page_not_found".tr});
    }
  }

  Future<void> getStoreInfo() async {
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
      Get.find<MainController>().update();
    });
  }

  void changeCurrentLanguage(String code) {
    currentLocale = Locale(code);
    Get.updateLocale(currentLocale);
    Get.find<MainController>().onInit();
    update();
  }

  @override
  void onInit() async {
    getSlugFromURL();
    await getStoreInfo();
    super.onInit();
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
