import 'package:flutter/widgets.dart';

class RegisterRequestModel {
  String? email;

  String? password;
  String? rePassword;
  String? userName;

  RegisterRequestModel({
    this.email,
    this.password,
    this.userName,
    this.rePassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = userName;
    data['password'] = password;
    data['rePassword'] = rePassword;
    data['email'] = email;

    debugPrint(data.toString());
    return data;
  }
}
