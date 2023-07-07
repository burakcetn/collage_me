import 'dart:convert';
import 'package:collage_me/core/cache_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter/material.dart';

class LoginUserId with CacheManager {
  static const String apiUrl = 'https://evliliksitesii.com/api/Login/GetUser';

  Future<String> logUserId() async {
    String token = getToken()!;
    debugPrint("token = $token");
    try {
      final response = await http.get(
        Uri.parse(
          apiUrl,
        ),
      );

      if (response.statusCode == 200) {
        debugPrint("response:${response.statusCode}");
        final String responseData = jsonDecode(response.body);

        return responseData;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }
}
