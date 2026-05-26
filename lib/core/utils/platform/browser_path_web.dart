// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void replaceBrowserPath(String path) {
  final normalized = path.startsWith('/') ? path : '/$path';
  html.window.history.replaceState(null, '', normalized);
}
