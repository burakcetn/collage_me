import 'package:collage_me/controllers/profile_screen_controller.dart';
import 'package:collage_me/core/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  Future<void> login(String? token) async {
    isLogged.value = true;
    // Token is cached
    await saveToken(token);
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}
