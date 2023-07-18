import 'dart:convert';
import 'package:collage_me/models/user_suggest_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserSuggestService {
  static const String apiUrl =
      'https://evliliksitesii.com/api/Friends/GetRandomUsers';

  Future<List<UserSuggestModel>> userSuggest() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<UserSuggestModel> users = [];

        for (var user in responseData) {
          users.add(UserSuggestModel.fromJson(user));
        }

        return users;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }
}
