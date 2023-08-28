import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }

  static String? get appOpenAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/3419835294';
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = Get.put(BannerAdListener(
      onAdLoaded: (ad) => debugPrint("ad Loaded"),
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        debugPrint("ad failed to load : $error");
      },
      onAdOpened: (ad) => debugPrint("ad opened"),
      onAdClosed: (ad) => debugPrint("ad closed")));
}
