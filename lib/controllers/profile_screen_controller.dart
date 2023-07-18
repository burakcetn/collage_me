import 'dart:async';
import 'package:collage_me/core/auth_manager.dart';
import 'package:collage_me/views/login_screen/onboard.dart';
import 'package:get/get.dart';
import 'package:collage_me/core/cache_manager.dart';
import 'package:collage_me/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class LoginUserController with CacheManager {
  final apiUrl = Uri.parse('https://evliliksitesii.com/userInformation');
  final http.Client client = http.Client();
  final AuthenticationManager _authenticationManager =
      Get.put(AuthenticationManager());

  Future<UserModel> getProfileData() async {
    final token = getToken();

    try {
      final response = await client.get(
        apiUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return UserModel.fromJson(responseData);
      } else {
        _authenticationManager.logOut();
        Get.off(() => const OnBoard());
        debugPrint('Server returned status code: ${response.statusCode}');
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      _authenticationManager.logOut();
      Get.off(() => const OnBoard());
      throw Exception('Error during user search: $e');
    }
  }

  void dispose() {
    client.close();
  }
}
