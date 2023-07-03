import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:collage_me/views/components/fab_button.dart';
import '../components/bottom_navbar.dart';
import '../components/collages.dart';

class CollageScreen extends StatelessWidget {
  const CollageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      appBar: PreferredSize(
        preferredSize: Size(100.w, 6.h),
        child: Stack(
          children: [
            Container(
              height: 24.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6.h),
                    bottomRight: Radius.circular(6.h)),
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(0, 4.h, 0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 5.h,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 3.h),
        child: SizedBox(
          width: 100.w,
          height: 70.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Your Collage",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Made with Love, from your friends",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
              const SingleChildScrollView(
                child: Collage1(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
