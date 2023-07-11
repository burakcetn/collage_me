import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
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

enum CacheManagerKey { TOKEN }
