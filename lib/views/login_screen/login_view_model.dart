import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_services.dart';
import '../../core/auth_manager.dart';
import '../../models/login_request_model.dart';
import '../../models/register_request_model.dart';

class LoginViewModel extends GetxController {
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.put(AuthenticationManager());
  }

  Future<void> loginUser(String email, String password) async {
    final response = await _loginService
        .fetchLogin(LoginRequestModel(email: email, password: password));

    debugPrint(response?.token.toString());

    if (response != null) {
      /// Set isLogin to true
      _authManager.login(response.token);
    } else {
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'User not found!',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<void> registerUser(
      String email, String password, String rePassword, String userName) async {
    final response = await _loginService.register(RegisterRequestModel(
      email: email,
      password: password,
      userName: userName,
      rePassword: rePassword,
    ));

    if (response != null) {
      /// Set isLogin to true
      _authManager.checkLoginStatus();
    } else {
      debugPrint(response.toString());

      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Giriş Yapınız',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }
}
