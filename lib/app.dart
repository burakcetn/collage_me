import 'package:collage_me/resources/color_schemes.dart';
import 'package:collage_me/resources/theme_manager.dart';
import 'package:collage_me/splah_screen.dart';
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
        home: SplashView(),
      );
    });
  }
}
