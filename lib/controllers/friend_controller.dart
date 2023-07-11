import 'dart:async';
import 'package:collage_me/core/cache_manager.dart';
import 'package:collage_me/models/friend_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class FriendController with CacheManager {
  final apiUrl = Uri.parse('https://evliliksitesii.com/GetMyfriends');
  final http.Client client = http.Client();

  Future<List<FriendModel>> getFriend() async {
    final token = getToken();
    debugPrint(token);

    try {
      final response = await client.get(
        apiUrl,
        headers: {
          //"Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        debugPrint("getfriend : ${response.body.toString()}");
        debugPrint(response.statusCode.toString());
        final List<dynamic> responseData = jsonDecode(response.body);
        var users = <FriendModel>[];

        for (var user in responseData) {
          users.add(FriendModel.fromJson(user));
        }

        return users;
      } else {
        debugPrint('Server returned status code: ${response.statusCode}');
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }

  void dispose() {
    client.close();
  }
}
