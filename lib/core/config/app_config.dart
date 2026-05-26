class AppConfig {
  static const String baseURL = "https://admin.mybeesystem.com/api/";

  /// Used when running on localhost without a `/{slug}` URL.
  /// Pass at run time: `--dart-define=STORE_SLUG=your-store-slug`
  static const String defaultStoreSlug = String.fromEnvironment(
    'STORE_SLUG',
    defaultValue: 'apple',
  );
}
