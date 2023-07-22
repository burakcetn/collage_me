import 'dart:typed_data';

import 'package:collage_me/core/auth_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart';
import 'package:collage_me/core/cache_manager.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/PusherWallpaper.dart';
import 'package:dio/dio.dart' as dio;

class WallpaperController with CacheManager {
  Future<void> postPusherWallpaper(String imagePath, String userName) async {
    final url = 'https://evliliksitesii.com/sendWallpaper';

    String? token = getToken();

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final file = File(imagePath);
    final imageBytes = await file.readAsBytes();
    final base64string = base64.encode(imageBytes);

    final wallpaper = PusherWallpaper(
      userName: userName,
      token: token,
      photoBase64: base64string,
    );
    debugPrint("base64 ::: $base64string");

    final body = jsonEncode(wallpaper.toJson());

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    debugPrint("yaşıyooooooooor ${response.body}");
    if (response.statusCode == 200) {
      Get.snackbar("Wallpaper", "başarıyla değiştirildi");
      debugPrint('Wallpaper posted successfully!');
    } else {
      Get.snackbar("Wallpaper", "değiştirilemedi tekrar deneyiniz.");
      debugPrint('Failed to post wallpaper. Error: ${response.statusCode}');
    }
  }

  Future<void> postWallpaper(File file) async {
    final url = 'https://evliliksitesii.com/sendWallpaperx';
    final dioService = dio.Dio();
    String fileName = file.path.split('/').last;

    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${AuthenticationManager().getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(file.path, filename: fileName),
      });
      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        debugPrint("Form data gönderildi");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
