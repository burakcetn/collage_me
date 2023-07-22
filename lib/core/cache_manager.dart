import 'package:collage_me/core/my_shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controllers/profile_screen_controller.dart';
import '../models/user_model.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    if (token == null) {
      return false;
    }
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  Future<bool> saveUsername(String? userName) async {
    final box = GetStorage();
    await box.write(username, userName);
    return true;
  }

  Future<void> removeUsername() async {
    final box = GetStorage();
    await box.remove(username);
  }

  Future<void> cacheUsername() async {
    try {
      UserModel userModel = await LoginUserController().getProfileData();
      // Cache the username
      await saveUsername(userModel.username);
      await MySharedPref.set(username, userModel.username ?? "");
      debugPrint("username kaydedildi:::::${userModel.username}");
      await FirebaseMessaging.instance
          .subscribeToTopic(userModel.username ?? "");
    } catch (e) {
      // Handle the error
      debugPrint('Error caching username: $e');
    }
  }

  Future<String?> getUsername() async {
    await MySharedPref.init();
    return MySharedPref.get(username);
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

  void changeLang(String lang) {
    Locale locale = Locale(lang);
    Get.updateLocale(locale);
  }

  String? getLang() {
    final box = GetStorage();
    return box.read('lang');
  }

  Future<bool> saveLanguage(String? lang) async {
    final box = GetStorage();
    await box.write('lang', lang);
    return true;
  }
}

const String username = "username";

enum CacheManagerKey { TOKEN }
