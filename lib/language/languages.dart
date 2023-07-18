import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          "language": "en",
          "login": "Login",
          "back": "Back",
          "register": "Register",
          "suggestion": "Friend Suggestions",
          "request": "Friend Requests",
          "friends": "Friends :",
          "layout": "Choose Your Layout",
        },
        "tr_TR": {
          "language": "Tr",
          "login": "Giriş",
          "register": "Kayıt",
          "back": "Geri",
          "friends": "Takipçi :",
          "suggestion": "Arkadaş Önerilerin",
          "request": "Arkadaş İsteklerin",
          "layout": "Şablonunu Seç"
        }
      };
}
