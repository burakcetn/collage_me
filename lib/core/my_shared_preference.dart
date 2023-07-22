import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  static Future<void> clear() async => await _sharedPreferences.clear();

  static Future<void> set(String key, String token) =>
      _sharedPreferences.setString(key, token);
  static String? get(String key) => _sharedPreferences.getString(key);
}
