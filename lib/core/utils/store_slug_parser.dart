/// Extracts the store slug from a web URL path or query string.
class StoreSlugParser {
  static const _routeMarkers = [
    'shop',
    'einvoice',
    'envoice',
    'price-offers',
    'supply-orders',
  ];

  static String? parseFromHref(String href) {
    final uri = Uri.tryParse(href);
    if (uri == null) {
      return null;
    }

    final fromQuery = uri.queryParameters['store'] ?? uri.queryParameters['slug'];
    if (fromQuery != null && fromQuery.isNotEmpty) {
      return fromQuery;
    }

    final segments =
        uri.pathSegments.where((segment) => segment.isNotEmpty).toList();
    for (final marker in _routeMarkers) {
      final index = segments.indexOf(marker);
      if (index != -1 && index + 1 < segments.length) {
        return segments[index + 1];
      }
    }

    return null;
  }

  static bool hrefHasStoreRoute(String href) {
    final lowerHref = href.toLowerCase();
    return _routeMarkers.any((marker) => lowerHref.contains(marker));
  }

  static bool isLocalDevHost(String href) {
    final host = Uri.tryParse(href)?.host ?? '';
    return host == 'localhost' || host == '127.0.0.1';
  }
}
