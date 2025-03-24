import 'package:flutter/foundation.dart' show kIsWeb;

class WebConfig {
  static bool get isWeb => kIsWeb;

  static String get adUnitId {
    if (isWeb) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Test ad unit ID for web
    }
    return 'ca-app-pub-3940256099942544/6300978111'; // Test ad unit ID for mobile
  }

  static String get interstitialAdUnitId {
    if (isWeb) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Test interstitial ad unit ID for web
    }
    return 'ca-app-pub-3940256099942544/1033173712'; // Test interstitial ad unit ID for mobile
  }

  static String get bannerAdUnitId {
    if (isWeb) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Test banner ad unit ID for web
    }
    return 'ca-app-pub-3940256099942544/6300978111'; // Test banner ad unit ID for mobile
  }
}
