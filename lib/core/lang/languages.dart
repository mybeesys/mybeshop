import 'package:mybeshop/core/lang/ar.dart';
import 'package:mybeshop/core/lang/en.dart';
import 'package:get/get.dart';

class Languages implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_SA': ArLang.keys,
        'en_US': EnLang.keys,
      };
}
