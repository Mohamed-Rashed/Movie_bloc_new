import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_blocd/ads_manager.dart';

Widget bannerAd() {
  return AdmobBanner(
    adUnitId: AdsManager.bannerAdUnitId,
    adSize: AdmobBannerSize.BANNER,
  );
}