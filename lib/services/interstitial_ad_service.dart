import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../config/web_config.dart';

class InterstitialAdService {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  Future<void> loadAd() async {
    if (kIsWeb) {
      _isAdLoaded = true;
      return;
    }

    await InterstitialAd.load(
      adUnitId: WebConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print('Interstitial ad failed to load: ${error.message}');
          _isAdLoaded = false;
        },
      ),
    );
  }

  Future<void> showAd() async {
    if (kIsWeb) {
      print('Interstitial ad would be shown on web');
      return;
    }

    if (!_isAdLoaded) {
      print('Interstitial ad not loaded yet');
      return;
    }

    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _isAdLoaded = false;
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _isAdLoaded = false;
        loadAd();
      },
    );

    await _interstitialAd?.show();
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
