import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:collage_me/utils/awesome_notifications_helper.dart';
import 'package:collage_me/utils/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:collage_me/core/auth_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:android_power_manager/android_power_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'package:collage_me/controllers/admob_helper.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'core/my_shared_preference.dart';
import 'models/PusherWallpaper.dart';

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

@pragma('vm:entry-point')
Future<void> onStart(service) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  debugPrint(await AuthenticationManager().getUsername());

  //SignalrHub().connect();
  //PusherHub().connect(await AuthenticationManager().getUsername() ?? "");
}

Future<void> fcmHandler() async {
  await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert:
        true, // Show an alert notification when a message is received in the foreground.
    badge:
        false, // Set the app's badge count when a message is received in the foreground.
    sound: false, // Play a sound when a message is received in the foreground.
  );

  // Add a listener for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle the foreground message here
    debugPrint(message.data.toString());

    if (message.notification != null) {
      print('Notification Title: ${message.notification?.title}');
      print('Notification Body: ${message.notification?.body}');
    }

    // Your custom logic for handling the foreground message
    // For example, you can show a local notification, update UI, etc.
    // Here, I'll call the existing _firebaseMessagingBackgroundHandler to reuse the code:
    _firebaseMessagingBackgroundHandler(message);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());

  if (message.notification != null) {
    print('Notification Title: ${message.notification?.title}');
    print('Notification Body: ${message.notification?.body}');
  }

  var json = (message.data);
  PusherWallpaper _wallpaper = PusherWallpaper.fromJson(json);
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/wallpaper.png';

  final file = io.File(filePath);

  try {
    final http.Response responseData =
        await http.get(Uri.parse(_wallpaper.photoBase64 ?? ""));
    var uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    io.File file = await io.File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    final result = await WallpaperManager.setWallpaperFromFile(
        file.path, WallpaperManager.BOTH_SCREEN);
    print(result);
  } catch (e) {
    print(e);
  }
  print("Handling a background message: ${message.messageId}");
}

void batteryHandler() async {
  var status = await Permission.ignoreBatteryOptimizations.status;
  print("status: $status");
  if (status.isGranted) {
    print(
        "isIgnoring: ${(await AndroidPowerManager.isIgnoringBatteryOptimizations)}");
    if ((await AndroidPowerManager.isIgnoringBatteryOptimizations)!) {
      AndroidPowerManager.requestIgnoreBatteryOptimizations();
    }
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.ignoreBatteryOptimizations,
    ].request();
    print(
        "permission value: ${statuses[Permission.ignoreBatteryOptimizations]}");
    if (statuses[Permission.ignoreBatteryOptimizations]!.isGranted) {
      AndroidPowerManager.requestIgnoreBatteryOptimizations();
    } else {
      exit(0);
    }
  }
}

void openAutoStartActivity() async {
  final deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidDeviceInfo;

  try {
    androidDeviceInfo = await deviceInfo.androidInfo;
  } on PlatformException catch (e) {
    print('Error getting device info: $e');
    return; // Handle platform exceptions, if any
  }

  try {
    final manufacturer = androidDeviceInfo.manufacturer.toLowerCase();

    AndroidIntent intent;

    switch (manufacturer) {
      case "xiaomi":
        intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          package: 'com.miui.securitycenter',
          componentName:
              'com.miui.permcenter.autostart.AutoStartManagementActivity',
        );
        break;

      case "oppo":
        intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          package: 'com.coloros.safecenter',
          componentName:
              'com.coloros.safecenter.permission.startup.StartupAppListActivity',
        );
        break;

      case "vivo":
        intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          package: 'com.vivo.permissionmanager',
          componentName:
              'com.vivo.permissionmanager.activity.BgStartUpManagerActivity',
        );
        break;

      case "letv":
        intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          package: 'com.letv.android.letvsafe',
          componentName: 'com.letv.android.letvsafe.AutobootManageActivity',
        );
        break;

      case "honor":
      case "huawei":
        intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          package: 'com.huawei.systemmanager',
          componentName:
              'com.huawei.systemmanager.optimize.process.ProtectActivity',
        );
        break;

      case "asus":
        intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          package: 'com.asus.mobilemanager',
          componentName: 'com.asus.mobilemanager.powersaver.PowerSaverSettings',
        );
        break;

      case "nokia":
        intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          package: 'com.evenwell.powersaving.g3',
          componentName:
              'com.evenwell.powersaving.g3.exception.PowerSaverExceptionActivity',
        );
        break;

      default:
        // Handle cases for other manufacturers or show an error message
        return;
    }

    intent.launch();
  } on PlatformException catch (e) {
    print('Error launching intent: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  batteryHandler();
  await MySharedPref.init();
  await GetStorage.init();
  //await Firebase.initializeApp();
  openAutoStartActivity();
  // fcmHandler();
  // inti fcm services
  await FcmHelper.initFcm();
  // initialize local notifications service
  await AwesomeNotificationsHelper.init();

  final service = FlutterBackgroundService();
  service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: false, autoStart: true));
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
