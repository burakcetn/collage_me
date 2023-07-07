import 'package:collage_me/controllers/admob_helper.dart';
import 'package:collage_me/models/user_suggest_response_model.dart';
import 'package:collage_me/views/components/user_container.dart';
import 'package:collage_me/views/profile_screen/friend_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

class HomeScreenGridView extends StatefulWidget {
  HomeScreenGridView({Key? key, required this.suggestionsList})
      : super(key: key);

  List<UserSuggestModel> suggestionsList;

  @override
  State<HomeScreenGridView> createState() => _HomeScreenGridViewState();
}

class _HomeScreenGridViewState extends State<HomeScreenGridView> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 12,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: HomeScreenUserContainer(
              userName: widget.suggestionsList[0].userName,
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: HomeScreenUserContainer(
              userName: widget.suggestionsList[1].userName,
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: HomeScreenUserContainer(
              userName: widget.suggestionsList[2].userName,
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: HomeScreenUserContainer(
              userName: widget.suggestionsList[3].userName,
            ),
          ),
          if (_bannerAd != null)
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 1,
              child: AdWidget(
                ad: _bannerAd!,
              ),
            ),
        ],
      ),
    );
  }
}
