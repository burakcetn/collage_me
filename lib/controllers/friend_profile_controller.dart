import 'dart:async';
import 'dart:convert';
import 'package:collage_me/core/cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/friend_profile_model.dart';

class FriendUserController with CacheManager {
  final http.Client client = http.Client();

  Future<FriendUserModel> getFriendProfile(String userName) async {
    final token = getToken();
    debugPrint(token);
    final apiUrl = Uri.parse('https://evliliksitesii.com/profile/$userName');
    debugPrint(apiUrl.toString());

    FriendUserModel parseFriendUserModel(Map<String, dynamic> response) {
      CollageDtoList? collageDtoList = CollageDtoList(
        collageId: response['collageDtoList']['collageId'] as int?,
        userId: response['collageDtoList']['userId'],
        collageName: response['collageDtoList']['collageName'],
        collageStyle: response['collageDtoList']['collageStyle'] as int?,
        photos: response['collageDtoList']['photos'],
      );

      List<String?>? listProfile = (response['listProfile'] as List<dynamic>?)
          ?.map((profile) => profile.toString())
          .toList();

      List<CollageFriendPhoto>? collageFriendPhotos = [];
      if (response['collagePhotos'] != null) {
        collageFriendPhotos = (response['collagePhotos'] as List<dynamic>?)
            ?.map((collagePhoto) => CollageFriendPhoto(
                  collageId: collagePhoto['collageId'] as int?,
                  index: collagePhoto['index'] as int?,
                  photoUrl: collagePhoto['photoUrl'],
                ))
            .toList();
      }

      int? friendsCount = response['friendsCount'] as int?;
      bool? checkFriend = response['checkFriend'] as bool?;
      bool? checkRequest = response['checkRequest'] as bool?;

      List<Comment>? comments = (response['comments'] as List<dynamic>?)
          ?.map((comment) => Comment(
                id: comment['id'] as int?,
                content: comment['content'],
                writer: comment['writer'],
                createdAt: DateTime.parse(comment['createdAt']),
              ))
          .toList();

      return FriendUserModel(
        collageDtoList: collageDtoList,
        listProfile: listProfile,
        collageFriendPhotos: collageFriendPhotos,
        friendsCount: friendsCount,
        checkFriend: checkFriend,
        checkRequest: checkRequest,
        comments: comments,
      );
    }

    try {
      final response = await client.post(
        apiUrl,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        debugPrint("get Friend Profile: ${response.body.toString()}");
        debugPrint(response.statusCode.toString());

        return parseFriendUserModel(jsonResponse);
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
