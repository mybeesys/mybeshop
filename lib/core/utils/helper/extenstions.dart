extension StringExtensions on String {
  /// Removes HTML tags from the string.
  String removeHtmlTags() {
    final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return replaceAll(regex, '');
  }
}
