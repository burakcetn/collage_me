import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/bottom_navbar.dart';
import '../components/collages.dart';
import '../components/fab_button.dart';

class CollageSelection extends StatelessWidget {
  const CollageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Choose Your Layout"),
      ),
      body: SafeArea(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 0.5,
          ),
          children: [
            Collage0(),
            Collage1(),
            Collage2(),
            Collage2(),
            Collage2(),
            Collage2(),
            Collage2(),
            Collage2(),
          ],
        ),
      ),
    );
  }
}
