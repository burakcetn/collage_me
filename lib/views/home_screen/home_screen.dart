import 'dart:async';
import 'package:collage_me/controllers/friend_controller.dart';
import 'package:collage_me/controllers/user_collage_controller.dart';
import 'package:collage_me/controllers/user_suggest_controller.dart';
import 'package:collage_me/views/components/bottom_navbar.dart';
import 'package:collage_me/views/components/fab_button.dart';
import 'package:collage_me/views/home_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/banner_admob.dart';
import '../components/home_screen_grid_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController userSearch = TextEditingController();
  final UserSuggestService _userSuggestService = Get.put(UserSuggestService());
  final StreamController _streamController = Get.put(StreamController());
  final UserCollageController _controller = Get.put(UserCollageController());
  final FriendController _friendController = Get.put(FriendController());

  @override
  initState() {
    debugPrint(_controller.getToken());
    _friendController.getFriend();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(() => UserSearchScreen());
            },
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 32,
            )),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "WallpaperSnap",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "suggestion".tr,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BannerAdmob(),
          ),
          Expanded(
              child: FutureBuilder(
            future: _userSuggestService.userSuggest(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        crossAxisCount: 1,
                        childAspectRatio: 0.8),
                    itemBuilder: (context, itemNumber) {
                      return HomeScreenGridView(
                        suggestionsList: snapshot.data!,
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()));
            },
          )),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
