import 'dart:convert';
import 'package:collage_me/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  final String userRequestUrl = 'https://reqres.in/api/users/2';
  UserModel? userModel;
  var isDataLoading = false.obs;

  getUserInformationApi() async {
    try {
      isDataLoading(true);
      http.Response response = await http.get(Uri.tryParse(userRequestUrl)!);

      if (response.statusCode == 200) {
        ///data succesfully

        var result = jsonDecode(response.body);
        userModel = UserModel.fromJson(result);
      }
    } catch (e) {
      print("error geetting data");
    } finally {
      isDataLoading(false);
    }
  }
}
