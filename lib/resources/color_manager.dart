import 'package:flutter/material.dart';


/*

   Flutter bize direkt olarak hex kod kullanmayı desteklemediği için bu class ve fonksiyon oluşturuldu.

   Oluşturulan ColorManager classında tanımlanan hex kodlar .fromHex sayesinde flutterda kullanılabilir
   formata dönüştürülüyor.

 */



class ColorManager {
  static Color base00 = HexColor.fromHex("#FAFAFA");
  
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}