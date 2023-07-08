import 'package:collage_me/core/cache_manager.dart';

import '../core/cache_manager.dart';
import '../core/cache_manager.dart';
import '../core/cache_manager.dart';

class FriendRequestModel {
  String? token;

  FriendRequestModel({this.token});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['token'] = token;
    return data;
  }
}
