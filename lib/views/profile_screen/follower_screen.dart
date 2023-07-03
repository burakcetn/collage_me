import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../components/bottom_navbar.dart';
import '../components/fab_button.dart';
import 'package:get/get.dart';

class FollowerScreen extends StatelessWidget {
  const FollowerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      appBar: PreferredSize(
        preferredSize: Size(100.w, 17.h),
        child: Stack(
          children: [
            Container(
              height: 16.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              child: Center(
                child: Text(
                  "Takipçilerin",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            Transform(
                transform: Matrix4.translationValues(2.w, 5.h, 0),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 8.h,
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
