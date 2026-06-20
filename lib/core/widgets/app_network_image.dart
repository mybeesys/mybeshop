import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Remote image loader that works on Flutter web with cross-origin storage URLs.
///
/// [Image.network] fetches bytes via XHR and fails with statusCode 0 when the
/// host (e.g. client.mybeesystem.com) does not send CORS headers. On web we
/// prefer an HTML `<img>` element, which can display those images normally.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.errorBuilder,
    this.loadingBuilder,
    this.filterQuality = FilterQuality.medium,
  });

  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final ImageErrorWidgetBuilder? errorBuilder;
  final ImageLoadingBuilder? loadingBuilder;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
      filterQuality: filterQuality,
      webHtmlElementStrategy: kIsWeb
          ? WebHtmlElementStrategy.prefer
          : WebHtmlElementStrategy.never,
    );
  }
}
