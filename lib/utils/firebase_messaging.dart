import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../core/auth_manager.dart';
import 'package:http/http.dart' as http;
import '../firebase_options.dart';
import '../models/PusherWallpaper.dart';
import 'awesome_notifications_helper.dart';
import 'dart:io' as io;

class FcmHelper {
  FcmHelper._();

  static late FirebaseMessaging messaging;

  static Future<void> initFcm() async {
    try {
      // initialize fcm and firebase core
      await Firebase.initializeApp(
        // TODO: uncomment this line if you connected to firebase via cli
        options: DefaultFirebaseOptions.currentPlatform,
      );

      messaging = FirebaseMessaging.instance;

      await _setupFcmNotificationSettings();

      await _generateFcmToken();
      final topic = await AuthenticationManager().getUsername();
      if (topic != null)
        await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (error) {
      debugPrint(error as String);
    }
  }

  static Future<void> _setupFcmNotificationSettings() async {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );
  }

  static Future<void> _generateFcmToken() async {
    try {
      var token = await messaging.getToken();
      if (token != null) {
        //MySharedPref.setFcmToken(token);
        _sendFcmTokenToServer();
      } else {
        await Future.delayed(const Duration(seconds: 5));
        _generateFcmToken();
      }
    } catch (error) {
      debugPrint(error as String);
    }
  }

  static _sendFcmTokenToServer() {
    // var token = MySharedPref.getFcmToken();
  }

  @pragma('vm:entry-point')
  static Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    AwesomeNotificationsHelper.showNotification(
      id: 1,
      title: message.notification?.title ?? 'Tittle',
      body: message.notification?.body ?? 'Body',
      payload: message.data.cast(),
    );
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

  static Future<void> _fcmForegroundHandler(RemoteMessage message) async {
    AwesomeNotificationsHelper.showNotification(
      id: 1,
      title: message.notification?.title ?? 'Tittle',
      body: message.notification?.body ?? 'Body',
      payload: message.data.cast(),
    );
  }
}
