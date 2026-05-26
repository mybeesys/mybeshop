import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/utils/store_slug_parser.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';

/// Shown on web when the URL has no store slug (e.g. `/` or `/error`).
class DevStoreSlugSetup extends StatefulWidget {
  const DevStoreSlugSetup({super.key});

  @override
  State<DevStoreSlugSetup> createState() => _DevStoreSlugSetupState();
}

class _DevStoreSlugSetupState extends State<DevStoreSlugSetup> {
  final _controller = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      return;
    }
    setState(() => _submitting = true);
    await GlobalController.to.applyStoreSlug(value);
    if (mounted) {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      init: Get.find<GlobalController>(),
      builder: (global) {
        final host = Uri.tryParse(global.baseURL ?? '')?.host ?? '';
        final exampleUrl = host.isNotEmpty
            ? 'https://$host${StoreSlugParser.storePath('apple')}'
            : 'https://mybeshop.mybeeerp.workers.dev/apple';

        return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 480.w),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'معرّف المتجر مطلوب',
                  style: AppStyles.heading2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  'افتح رابط المتجر بهذا الشكل:\n$exampleUrl\n\nأو أدخل slug المتجر (مثل apple) هنا:',
                  style: AppStyles.bodyBoldL,
                  textAlign: TextAlign.center,
                ),
                if (global.storeLoadError != null) ...[
                  SizedBox(height: 16.h),
                  Text(
                    global.storeLoadError!,
                    style: AppStyles.bodyBoldL.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: 24.h),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Store slug',
                    hintText: 'apple',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submitting ? null : _submit(),
                ),
                SizedBox(height: 16.h),
                FilledButton(
                  onPressed: _submitting ? null : _submit,
                  child: _submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('فتح المتجر'),
                ),
                if (kDebugMode) ...[
                  SizedBox(height: 12.h),
                  Text(
                    'تطوير محلي: flutter run -d chrome --dart-define=STORE_SLUG=apple',
                    style: AppStyles.bodyBoldL.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
      },
    );
  }
}
