import 'package:collage_me/views/components/bottom_navbar.dart';
import 'package:collage_me/views/components/collages.dart';
import 'package:collage_me/views/components/fab_button.dart';
import 'package:collage_me/views/profile_screen/friend_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../components/home_screen_grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List friendRequest = [
    'Kullanıcı 1',
    'Kullanıcı 2',
    'Kullanıcı 3',
    'Kullanıcı 4',
    'Kullanıcı 5',
    'Kullanıcı 6',
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      appBar: PreferredSize(
        preferredSize: Size(100.w, 120),
        child: Stack(
          children: [
            Container(
              height: 140,
              width: 100.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              child: Center(
                child: Text(
                  "WallpaperSnap",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                width: 80.w,
                constraints: const BoxConstraints(
                  maxHeight: 55,
                ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Arkadaş Önerileri",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: 3,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      crossAxisCount: 1,
                      childAspectRatio: 0.8),
                  itemBuilder: (context, itemNumber) {
                    return HomeScreenGridView();
                  })),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
