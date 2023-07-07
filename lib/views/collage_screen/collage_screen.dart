import 'package:collage_me/views/collage_screen/comment_view.dart';
import 'package:collage_me/views/components/banner_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:collage_me/views/components/fab_button.dart';
import '../../controllers/admob_helper.dart';
import '../components/bottom_navbar.dart';
import '../components/collages.dart';
import '../components/home_screen_grid_view.dart';

class CollageScreen extends StatelessWidget {
  const CollageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 2 * screenW,
                  width: screenW,
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          crossAxisCount: 1,
                          childAspectRatio: 0.5),
                      itemBuilder: (context, itemnumber) {
                        return Collage1();
                      })),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BannerAdmob(),
              ),
              Container(
                width: 90.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: CommentScreen(),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
