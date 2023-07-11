import 'dart:convert';
import 'package:collage_me/core/cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SetCollage with CacheManager {
  int collageId = 0;
  String userId = "String";
  String? collageName = "a";
  int collageStyle = 1;
  int photoCount = 5;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['collageStyle'] = collageStyle;
    data['collageName'] = collageName;
    data['collageSize'] = photoCount;
    data["collageId"] = collageId;
    data["userId"] = userId;

    debugPrint(data.toString());
    return data;
  }

  Future<void> createCollage() async {
    final url = 'https://evliliksitesii.com/addCollage';
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${getToken()}",
    };
    final body = jsonEncode(toJson());

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      debugPrint('Collage created successfully');
    } else {
      debugPrint(
          'Collage creation failed with status code ${response.statusCode}');
    }
  }
}
