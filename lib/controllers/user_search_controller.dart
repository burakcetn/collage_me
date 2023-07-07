import 'dart:async';
import 'dart:convert';
import 'package:collage_me/models/user_search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserSearchService {
  static const String apiUrl =
      'https://evliliksitesii.com/api/Friends/getUserList';
  List<UserSearchModel> users = [];

  StreamController<List<UserSearchModel>> _userSearchStreamController =
      StreamController<List<UserSearchModel>>();
  Stream<List<UserSearchModel>> get userSearchStream =>
      _userSearchStreamController.stream;

  Future<void> searchUsers(String query) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        users = [];

        for (var user in responseData) {
          users.add(UserSearchModel.fromJson(user));
        }

        final filteredResults = users
            .where((user) =>
                user.userName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _userSearchStreamController.sink.add(filteredResults);
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to fetch user search results');
      }
    } catch (e) {
      throw Exception('Error during user search: $e');
    }
  }

  String? findUserIdByUsername(String username) {
    final user = users.firstWhere(
      (user) => user.userName.toLowerCase() == username.toLowerCase(),
      orElse: () => UserSearchModel(
        userName: '',
        firstName: '',
        lastName: '',
        userId: '',
      ),
    );
    debugPrint(user.userName);
    debugPrint(user.userId);
    return user.userId.isNotEmpty ? user.userId : null;
  }

  void dispose() {
    _userSearchStreamController.close();
  }
}
