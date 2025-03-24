import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../main.dart';

class InterstitialAdService {
  InterstitialAd? _interstitialAd;
  bool _isLoaded = false;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print('Interstitial ad failed to load: $error');
          _isLoaded = false;
        },
      ),
    );
  }

  void showAd() {
    if (_isLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _isLoaded = false;
      loadAd(); // Preload next ad
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
