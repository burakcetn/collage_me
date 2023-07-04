import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app.dart';
import 'package:collage_me/controllers/admob_helper.dart';

List<String> testDeviceIds = ['66B56A343F55A457F6B9DDCD976D708B'];

AppOpenAd? _openAd;

Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: AdMobService.appOpenAd!,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
        _openAd = ad;
        _openAd!.show();
      }, onAdFailedToLoad: (err) {
        debugPrint("ad failed to load $err");
      }),
      orientation: AppOpenAd.orientationPortrait);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
  await loadAd();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  //to set the preferred orientation to portrait only
  //TODO: Native kısımları halletmeyi unutma
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}
