import 'dart:convert';
import 'dart:io';
import 'package:collage_me/core/cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:collage_me/models/loged_user_model.dart';
import 'package:flutter/material.dart';

import '../models/friend_model.dart';

class FriendController with CacheManager {
  final apiUrl = Uri.parse('https://evliliksitesii.com/api/Friends');

  Future<FriendModel> getFriend() async {
    final token = getToken()!;
    debugPrint(token);
    try {
      final response =
          await http.get(apiUrl, headers: {'Authorization': 'Bearer $token'});

      debugPrint("arkadaş listesi ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        return FriendModel.fromJson(responseData);
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }
}
