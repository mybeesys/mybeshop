import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';

/// Shown on localhost when no store slug is in the URL or saved storage.
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
                  'Store slug required',
                  style: AppStyles.heading2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Local Chrome has no store in the URL. Enter your store slug (e.g. apple), or open:\n'
                  'http://localhost:<port>/your-slug',
                  style: AppStyles.bodyBoldL,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Store slug',
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
                      : const Text('Open store'),
                ),
                if (kDebugMode) ...[
                  SizedBox(height: 12.h),
                  Text(
                    'Or run: flutter run -d chrome --dart-define=STORE_SLUG=your-slug',
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
  }
}
