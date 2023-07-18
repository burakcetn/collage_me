import 'dart:async';

import 'package:collage_me/core/cache_manager.dart';
import 'package:get/get.dart';
import 'package:collage_me/models/friend_request_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class FriendRequestController with CacheManager {
  final apiUrl = Uri.parse('https://evliliksitesii.com/GetFriendRequest');

  final http.Client client = http.Client();

  Future<List<FriendRequestModel>> getFriendRequest() async {
    final token = getToken();
    debugPrint("friend request");

    try {
      final response = await client.get(
        apiUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      debugPrint("get friend response body : ${response.body.toString()}");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final friendRequestList = jsonResponse
            .map<FriendRequestModel>(
                (userId) => FriendRequestModel.fromJson(userId))
            .toList();
        return friendRequestList;
      } else {
        debugPrint('Server returned status code: ${response.statusCode}');
        throw Exception('Failed to fetch friend requests');
      }
    } catch (e) {
      throw Exception('Error during friend request retrieval: $e');
    }
  }

  Future sendFriendRequest(String userName) async {
    final token = getToken();
    final sendFriendUrl = Uri.parse('https://evliliksitesii.com/addFriend');

    try {
      final response = await client.post(
        sendFriendUrl,
        body: jsonEncode({'user2': userName}),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.snackbar("Friend Request", "Send");
        return true;
      } else if (response.statusCode == 400) {
        Get.snackbar("Friend Request", "already sent");
        return true;
      } else {
        debugPrint('Server returned status code: ${response.statusCode}');
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }

  Future confirmFriend(String userName) async {
    final token = getToken();
    final sendFriendUrl = Uri.parse('https://evliliksitesii.com/ConfirmFriend');

    try {
      final response = await client.post(
        sendFriendUrl,
        body: jsonEncode({'userId2': userName}),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        debugPrint("arkadaş istediği onaylandı");
        return true;
      } else {
        debugPrint('Server returned status code: ${response.statusCode}');
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }

  Future declineFriend(String userName) async {
    final token = getToken();
    final declineFriendUrl =
        Uri.parse('https://evliliksitesii.com/declineFriend/$userName');

    try {
      final response = await client.post(
        declineFriendUrl,
        //body: jsonEncode({'userId2': userName}),
        headers: {
          // "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 204) {
        debugPrint("arkadaş onayı reddedildi");
        return true;
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
