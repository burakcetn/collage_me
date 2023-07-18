import 'dart:convert';
import 'package:collage_me/core/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_collage_model.dart';

class UserCollageController with CacheManager {
  final apiUrl = Uri.parse('https://evliliksitesii.com/GetCollageWithUserId');
  final http.Client client = http.Client();

  Future<CollageModel> userCollage() async {
    CollageModel parseCollageModel(String responseBody) {
      final parsedJson = jsonDecode(responseBody);

      List<CollageDtoList>? collageDtoList =
          (parsedJson['collageDtoList'] as List<dynamic>?)
              ?.map((collageDto) => CollageDtoList(
                    collageId: collageDto['collageId'],
                    userId: collageDto['userId'],
                    collageName: collageDto['collageName'],
                    collageStyle: collageDto['collageStyle'],
                    collageSize: collageDto['collageSize'],
                  ))
              .toList();

      List<CollagePhoto>? collagePhotos =
          (parsedJson['collagePhotos'] as List<dynamic>?)
              ?.map((collagePhoto) => CollagePhoto(
                    collageId: collagePhoto['collageId'],
                    index: collagePhoto['index'],
                    photoUrl: collagePhoto['photoUrl'],
                  ))
              .toList();

      return CollageModel(
        collageDtoList: collageDtoList,
        collagePhotos: collagePhotos,
      );
    }

    try {
      final response = await client.get(
        apiUrl,
        headers: {
          "Authorization": "Bearer ${getToken()}",
        },
      );

      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        debugPrint("girdi");
        debugPrint(response.body);

        final collageModel = parseCollageModel(response.body);
        return collageModel;
      } else {
        debugPrint(response.statusCode.toString());
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
