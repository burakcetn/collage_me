import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import '../models/login_request_model.dart';
import '../models/login_response_manager.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class LoginService extends GetConnect {
  final String loginUrl = 'https://evliliksitesii.com/password/email';
  final String registerUrl = 'https://evliliksitesii.com/api/Login/Register';
  final content = 'application/json';

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());
    debugPrint(model.toJson().toString());

    debugPrint("login ${response.statusCode}");

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      print(response.statusCode.toString());
      return null;
    }
  }

  Future<RegisterResponseModel?> register(
      RegisterRequestModel registerRequestModel) async {
    //final url = 'https://evliliksitesii.com/api/Account/Register';

    final headers = {
      'Content-Type': 'application/json',
    };

    final jsonBody = jsonEncode(registerRequestModel);

    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return RegisterResponseModel.fromJson(responseData);
      } else {
        debugPrint('Registration failed. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error during registration: $e');
      return null;
    }
  }
}
