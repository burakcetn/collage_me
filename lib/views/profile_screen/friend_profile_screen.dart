import 'dart:typed_data';

import 'package:collage_me/controllers/friend_request_controller.dart';
import 'package:collage_me/controllers/wallpaper_controller.dart';
import 'package:collage_me/views/components/fab_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import '../../comment_screen.dart';
import '../../controllers/friend_profile_controller.dart';
import '../../controllers/profile_screen_controller.dart';
import '../../core/auth_manager.dart';
import '../../models/friend_profile_model.dart';
import '../../models/user_model.dart';
import '../components/bottom_navbar.dart';
import '../components/collages.dart';

class FriendProfileScreen extends StatefulWidget {
  FriendProfileScreen({Key? key, this.arguments}) : super(key: key);
  String? arguments;

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  final FriendUserController friendUserController = FriendUserController();
  final FriendRequestController _requestController =
      Get.put(FriendRequestController());
  FriendUserController _friendUserController = Get.put(FriendUserController());
  UserModel? _userModel;
  LoginUserController _loginUserController = Get.put(LoginUserController());
  ScreenshotController screenshotController = ScreenshotController();
  WallpaperController wallpaperController = Get.put(WallpaperController());

  @override
  void initState() {
    userInformationFunction();
    super.initState();
  }

  Future<void> userInformationFunction() async {
    _userModel = await _loginUserController.getProfileData();
  }

  @override
  void dispose() {
    _friendUserController.dispose();
    _loginUserController.dispose();
    _requestController.dispose();
    super.dispose();
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kolajın"),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () async {
                    final directory = await getApplicationDocumentsDirectory();
                    final filePath = '${directory.path}/output.png';

                    final file = io.File(filePath);
                    await file.writeAsBytes(capturedImage);

                    try {
                      await wallpaperController.postWallpaper(file);
                      final result =
                          await WallpaperManager.setWallpaperFromFile(
                              filePath,
                              widget.arguments != null
                                  ? widget.arguments
                                  : Get.arguments);
                      print(result);
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(
                    Icons.wallpaper_outlined,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
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
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.arguments != null ? widget.arguments : Get.arguments,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<FriendUserModel>(
              future: friendUserController.getFriendProfile(
                  widget.arguments == null ? Get.arguments : widget.arguments),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final friendUserModel = snapshot.data!;
                  debugPrint(
                      "data ::: ${friendUserModel.collageFriendPhotos.toString()}");

                  print(
                      'collageStyle: ${friendUserModel.collageDtoList?.collageStyle}');

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 16),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 36,
                            child: const Icon(Icons.person),
                            foregroundImage:
                                NetworkImage(friendUserModel.listProfile![3]!),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 70,
                          width: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).colorScheme.onInverseSurface,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "friends".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceTint),
                              ),
                              Text(
                                friendUserModel.friendsCount.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceTint),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (friendUserModel.checkFriend == false)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              _requestController.sendFriendRequest(
                                  widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments);
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).colorScheme.primary),
                              child: Center(child: Text("+")),
                            ),
                          ),
                        ),
                      Screenshot(
                        controller: screenshotController,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            crossAxisCount: 1,
                            childAspectRatio: 0.5,
                          ),
                          itemBuilder: (context, itemnumber) {
                            final collageId =
                                friendUserModel.collageDtoList?.collageStyle;
                            debugPrint(collageId.toString());
                            Widget collageWidget;

                            switch (collageId) {
                              case 1:
                                collageWidget = Collage0(
                                  collagePhotos: null,
                                  collageFriendPhotos:
                                      friendUserModel.collageFriendPhotos,
                                  friendUsername: widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                );
                                break;
                              case 2:
                                collageWidget = Collage1(
                                  //collagePhotos: null,
                                  collageFriendPhotos:
                                      snapshot.data!.collageFriendPhotos,
                                  friendUsername: widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                );
                                break;
                              case 3:
                                collageWidget = Collage2(
                                  collagePhotos: null,
                                  collageFriendPhotos:
                                      friendUserModel.collageFriendPhotos,
                                  friendUsername: widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                );
                                break;
                              case 4:
                                collageWidget = Collage3(
                                  collagePhotos: null,
                                  collageFriendPhotos:
                                      friendUserModel.collageFriendPhotos,
                                  friendUsername: widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                );
                                break;
                              case 5:
                                collageWidget = Collage4(
                                  collagePhotos: null,
                                  collageFriendPhotos:
                                      friendUserModel.collageFriendPhotos,
                                  friendUsername: widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                );
                                break;
                              case 6:
                                collageWidget = Collage5(
                                  collagePhotos: null,
                                  collageFriendPhotos:
                                      friendUserModel.collageFriendPhotos,
                                  friendUsername: widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                );
                                break;
                              case 7:
                                collageWidget = Collage6(
                                  collagePhotos: null,
                                  collageFriendPhotos:
                                      friendUserModel.collageFriendPhotos,
                                  friendUsername: widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                );
                                break;
                              case 8:
                                collageWidget = Collage7(
                                  collagePhotos: null,
                                  collageFriendPhotos:
                                      friendUserModel.collageFriendPhotos,
                                  friendUsername: widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                );
                                break;
                              default:
                                collageWidget =
                                    Container(); // Default widget when collageId is not recognized
                            }

                            return collageWidget;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (friendUserModel.checkFriend == true)
                              ElevatedButton(
                                onPressed: () {
                                  // captureScreenshot();
                                  screenshotController
                                      .capture(
                                          delay: Duration(milliseconds: 10))
                                      .then((capturedImage) async {
                                    ShowCapturedWidget(context, capturedImage!);
                                  }).catchError((onError) {
                                    print(onError);
                                  });
                                },
                                child: Icon(Icons.camera_alt_outlined),
                              ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => CommentScreen(), arguments: [
                                  widget.arguments != null
                                      ? widget.arguments
                                      : Get.arguments,
                                  1
                                ]);
                              },
                              child: Icon(Icons.comment_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(
              height: 12,
            ),
            FutureBuilder<FriendUserModel>(
              future: friendUserController.getFriendProfile(
                  widget.arguments != null ? widget.arguments : Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final comments = snapshot.data?.comments;

                  if (comments != null && comments.isNotEmpty) {
                    return Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        comment.writer ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text(
                                      "- ${comment.content} " ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }
              },
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

// The remaining classes and widgets remain the same.
