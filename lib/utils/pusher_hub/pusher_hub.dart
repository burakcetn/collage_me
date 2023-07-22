import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collage_me/models/PusherWallpaper.dart';
import 'dart:io' as io;

class PusherHub {
  /*PusherOptions options = PusherOptions(cluster: "eu");

  PusherClient getPusherClient() {
    pusher ??= PusherClient("5ec1a4935cecaccad64d", options,
        autoConnect: false, enableLogging: false);
    return pusher!;
  }

  PusherClient? pusher;
  static String userName = "";
  void onEvent(PusherEvent event) async {
    var json = jsonDecode(event.data ?? "");
    PusherWallpaper _wallpaper = PusherWallpaper.fromJson(json);
    final _byteImage = Base64Decoder().convert(_wallpaper.photoBase64 ?? "");
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/wallpaper.png';

    final file = io.File(filePath);

    try {
      await file.writeAsBytes(_byteImage);
      final result = await WallpaperManager.setWallpaperFromFile(
          filePath, WallpaperManager.BOTH_SCREEN);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  void connect(String userName) {
    getPusherClient();
    debugPrint("connect çalıştı");
    PusherHub.userName = userName;
    debugPrint("usernam ::::: $userName");
    pusher?.connect();
    final channel = pusher?.subscribe('CollageApp');
    channel?.bind(userName, (event) {
      onEvent(event!);
    });
    //await pusher.connect();
  }*/
}
