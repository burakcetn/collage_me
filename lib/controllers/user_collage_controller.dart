import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserCollageController {
  static const String apiUrl =
      'https://evliliksitesii.com/api/Collage/GetCollegeWithUserId';

  Future<NetworkImage> userCollage() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      debugPrint(response.body);

      if (response.statusCode == 200) {
        debugPrint("girdi");
        debugPrint(response.body);
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<NetworkImage> usersCollage = [];

        /*for (var user in responseData) {
          usersCollage.add(NetworkImage(url).fromJson(user));
        }*/

        return NetworkImage("wwww.burak.com");
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }
}
