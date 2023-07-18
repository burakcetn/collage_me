import 'dart:convert';
import 'package:collage_me/core/cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SetCollage with CacheManager {
  Map<String, dynamic> toJson(int style) {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    int collageStyle = style;
    data['collageStyle'] = collageStyle;

    debugPrint(data.toString());
    return data;
  }

  Future<void> createCollage(int style) async {
    final url = 'https://evliliksitesii.com/changeCollageStyle/$style';
    final headers = {
      "Authorization": "Bearer ${getToken()}",
    };
    final body = jsonEncode(toJson(style));
    debugPrint(url);
    final response = await http.post(
      Uri.parse(url),
      headers: headers, /*body: body*/
    );

    if (response.statusCode == 200) {
      debugPrint('collage updated succesfully');
    } else {
      debugPrint(
          'Collage creation failed with status code ${response.statusCode}');
    }
  }
}
