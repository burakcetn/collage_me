import 'package:collage_me/models/collage_set_request_model.dart';
import 'package:collage_me/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/bottom_navbar.dart';
import '../components/collages.dart';
import '../components/fab_button.dart';

class CollageSelection extends StatefulWidget {
  const CollageSelection({Key? key}) : super(key: key);

  @override
  State<CollageSelection> createState() => _CollageSelectionState();
}

class _CollageSelectionState extends State<CollageSelection> {
  final SetCollage _setCollage = Get.put(SetCollage());

  @override
  void initState() {
    super.initState();
  }

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
        title: Text("layout".tr),
      ),
      body: SafeArea(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8),
          children: [
            GestureDetector(
              onTap: () async {
                await _setCollage.createCollage(1);
                Get.snackbar("Collage", "Your collage layout updated");
                Get.off(() => ProfileScreen());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/buton1.png"),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await _setCollage.createCollage(2);
                Get.snackbar("Collage", "Your collage layout updated");
                Get.off(() => ProfileScreen());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/buton2.png"),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await _setCollage.createCollage(3);
                Get.snackbar("Collage", "Your collage layout updated");
                Get.off(() => ProfileScreen());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/buton3.png"),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await _setCollage.createCollage(4);
                Get.snackbar("Collage", "Your collage layout updated");
                Get.off(() => ProfileScreen());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/buton4.png"),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await _setCollage.createCollage(5);
                Get.snackbar("Collage", "Your collage layout updated");
                Get.off(() => ProfileScreen());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/buton5.png"),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await _setCollage.createCollage(6);
                Get.snackbar("Collage", "Your collage layout updated");
                Get.off(() => ProfileScreen());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/buton6.png"),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await _setCollage.createCollage(7);
                Get.snackbar("Collage", "Your collage layout updated");
                Get.off(() => ProfileScreen());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/buton7.png"),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () async {
                await _setCollage.createCollage(8);
                Get.snackbar("Collage", "Your collage layout updated");
                Get.off(() => ProfileScreen());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/buton8.png"),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
