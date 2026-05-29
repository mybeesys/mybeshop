// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Runs before Flutter/GetX read the browser URL so `/error` never becomes the initial route.
void prepareWebEntryUrl() {
  final path = html.window.location.pathname;
  if (path == '/error') {
    html.window.history.replaceState(null, '', '/');
  }
}
