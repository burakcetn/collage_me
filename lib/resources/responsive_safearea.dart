import 'package:flutter/material.dart';

/*
      Uygulamayı responsive ya da adaptive tasarıma ulaştırmak için MediaQuery kullanıldı.
      Safe Area'ya ihtiyaç duyulan yerlerde safeArea'nın size değerlerine ulaşabilmek için
      ResponsiveSafeArea oluşturuldu.

      Kullanımı =>

        SafeArea() yerine ResponsiveSafeArea() tanımlanır.
        responsive safe area builder fonksiyonuna ihtiyaç duyar.
        Bu fonksiyonun da 2 girdisi bulunmaktadır.
          -context
          -size

        Örnek Kullanım

        ResponsiveSafeArea(
          builder: (context,size){
            return Container();
         }

     ****    artık Container içinden SafeArea'nın size.height ve size.width değerlerine MediaQuery değerleri
         tanımlanmadan kullanılabilir.
     ****    Bazı sayfa tasarımlarında MediaQuery ihtiyaç duyulduğundan MediaQuery bilgileri tanımlanmış olabilir.
     genel kullanımları

     ResponsiveSafeArea => size.height
                           size.width
     MediaQuery         => sizeW or screenW
                           sizeH or screenH

  */

typedef ResponsiveBuilder = Widget Function(BuildContext context, Size size);

class ResponsiveSafeArea extends StatelessWidget {
  const ResponsiveSafeArea({
    required this.builder,
    Key? key,
  }) : super(key: key);

  final ResponsiveBuilder builder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return builder(
            context,
            constraints.biggest,
          );
        },
      ),
    );
  }
}