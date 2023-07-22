import 'package:collage_me/core/auth_manager.dart';
import 'package:collage_me/language/languages.dart';
import 'package:collage_me/splah_screen.dart';
import 'package:collage_me/utils/color_schemes.dart';
import 'package:collage_me/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); // private named constructor
  static const MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; //factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale = const Locale("tr");
  AuthenticationManager langCache = Get.put(AuthenticationManager());

  @override
  void initState() {
    if (langCache.getLang() != null) {
      Locale locale = Locale(langCache.getLang()!);
      Get.updateLocale(locale);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: textTheme,
            fontFamily: "Aileron"),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: textTheme,
            fontFamily: "Aileron"),
        themeMode: ThemeMode.light,
        translations: Languages(),
        locale:
            langCache.getLang() != null ? Locale(langCache.getLang()!) : locale,
        fallbackLocale: const Locale("en", "US"),
        home: SplashView(),
      );
    });
  }
}
