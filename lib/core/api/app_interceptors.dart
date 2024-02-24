import 'package:dio/dio.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:get/get.dart' as getx;

class AppInterceptos implements Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {
      'Access-Control-Allow-Origin': '*',
      'Accept': 'application/json',
      // 'Accept-Language': "${GlobalController.to.currentLocale?.languageCode}",
      'Accept-Language': GlobalController.to.currentLocale.languageCode,
      'Content-Type': 'application/json',
      'Source':
          'TYKREWQTH&^%EWQRFEGRTEHRUTIYHRSDFAF!ETHRBDGFEDAWHYJDTRGSEDFRTYUJTRGFD',
      // 'FcmToken': "${getx.Get.find<FirebaseMessagingService>().token}",
      // 'Store-UUID':
      //     "${DeviceInfoService.to.webBrowserInfo.product}${Random(200).nextInt(9999999)}",
      'Store-UUID': '1234',
      'Store-Slug': "${getx.Get.find<GlobalController>().slug}"
    };
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
