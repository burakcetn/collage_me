import 'dart:convert';
import 'package:collage_me/core/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserCollageController with CacheManager {
  final apiUrl = Uri.parse('https://evliliksitesii.com/GetCollageWithUserId');
  final http.Client client = http.Client();

  Future<bool> userCollage() async {
    try {
      final response = await client.get(
        apiUrl,
        headers: {
          "Authorization":
              "Bearer ${getToken()}", // Add token parameter to headers
        },
      );

      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        debugPrint("girdi");
        debugPrint(response.body);
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<NetworkImage> usersCollage = [];

        return true;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }
}
