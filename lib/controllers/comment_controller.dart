import 'dart:async';
import 'package:collage_me/core/cache_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/comment_model.dart';

class CommentController with CacheManager {
  final http.Client client = http.Client();

  Future<List<CommentModel>> getComment(String? userName) async {
    final apiUrl = Uri.parse('https://evliliksitesii.com/GetComment/$userName');
    final token = getToken();
    debugPrint(token);
    debugPrint(apiUrl.toString());
    debugPrint("comment");
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
        debugPrint(response.body);

        List<CommentModel> parseComments(String responseBody) {
          final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
          return parsed
              .map<CommentModel>((json) => CommentModel.fromJson(json))
              .toList();
        }

        return parseComments(response.body);
      } else {
        debugPrint('Server returned status code: ${response.statusCode}');
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }

  Future sendComment(String comment, String userName) async {
    final apiUrl = Uri.parse('https://evliliksitesii.com/AddComment/$userName');
    try {
      final response = await client
          .post(apiUrl, body: jsonEncode({"content": comment}), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${getToken()}",
      });
      debugPrint("yorummmm ${response.statusCode}");
      debugPrint(response.body);
      if (response.statusCode == 200) {
        debugPrint("yorum atıldı :${response.body}");

        return true;
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }

  Future deleteComment(int commentId) async {
    final apiUrl =
        Uri.parse('https://evliliksitesii.com/deleteComment/$commentId');
    try {
      final response = await client.post(apiUrl,
          //body: jsonEncode({"content": "mobilden yorum attım"}),
          headers: {
            //'Content-Type': 'application/json',
            "Authorization": "Bearer ${getToken()}",
          });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }

  void dispose() {
    client.close();
  }
}
