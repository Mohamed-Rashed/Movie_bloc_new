import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';

class AdsManager {
  static bool _testMode = false;

  ///
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7568742996187081~1902758620";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7568742996187081~5583322646";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (_testMode == true) {
        return AdmobBanner.testAdUnitId;
    } else if (Platform.isAndroid) {

      return "ca-app-pub-7568742996187081/1260934253";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7568742996187081/2211069753";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (_testMode == true) {
      return AdmobInterstitial.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-7568742996187081/9706416393";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7568742996187081/3312382525";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (_testMode == true) {
      return "ca-app-pub-7568742996187081/5363830790";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-7568742996187081/3048319336";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}