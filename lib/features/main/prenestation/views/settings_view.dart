import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr),
      ),
      body: Column(
        children: [
          RadioListTile(
            value: "ar",
            groupValue: GlobalController.to.currentLocale.languageCode,
            onChanged: (v) {
              GlobalController.to.changeCurrentLanguage(v!);
            },
            title: Text("arabic".tr),
          ),
          RadioListTile(
            value: "en",
            groupValue: GlobalController.to.currentLocale.languageCode,
            onChanged: (v) {
              GlobalController.to.changeCurrentLanguage(v!);
            },
            title: Text("english".tr),
          ),
        ],
      ),
    );
  }
}
