import 'dart:io' as io;
import 'dart:typed_data';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:collage_me/comment_screen.dart';
import 'package:collage_me/controllers/comment_controller.dart';
import 'package:collage_me/controllers/friend_profile_controller.dart';
import 'package:collage_me/controllers/user_collage_controller.dart';
import 'package:collage_me/controllers/wallpaper_controller.dart';
import 'package:collage_me/models/comment_model.dart';
import 'package:collage_me/models/friend_profile_model.dart';
import 'package:collage_me/models/user_collage_model.dart';
import 'package:collage_me/models/user_model.dart';
import 'package:collage_me/views/components/banner_admob.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:collage_me/views/components/fab_button.dart';
import '../../controllers/profile_screen_controller.dart';
import '../../core/auth_manager.dart';
import '../components/bottom_navbar.dart';
import '../components/collages.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as img;

class CollageScreen extends StatefulWidget {
  const CollageScreen({Key? key}) : super(key: key);

  @override
  State<CollageScreen> createState() => _CollageScreenState();
}

class _CollageScreenState extends State<CollageScreen> {
  UserCollageController _collageController = Get.put(UserCollageController());
  FriendUserController _friendUserController = Get.put(FriendUserController());
  CommentController _commentController = Get.put(CommentController());
  LoginUserController _loginUserController = Get.put(LoginUserController());
  ScreenshotController screenshotController = ScreenshotController();
  List<CommentModel> commentList = [];
  UserModel? _userModel;
  WallpaperController wallpaperController = Get.put(WallpaperController());

  @override
  void initState() {
    super.initState();
    userInformationFunction();
  }

  Future<void> userInformationFunction() async {
    _userModel = await _loginUserController.getProfileData();
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage, String? username) {
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
                              filePath, WallpaperManager.BOTH_SCREEN);

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Unfocus the text field when tapping outside of it
        FocusScope.of(context).unfocus();
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const FabButton(),
          bottomNavigationBar: const BottomNavbar(),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<CollageModel>(
                    future: _collageController.userCollage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final bool userCollage = snapshot.hasData;
                        if (userCollage) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Screenshot(
                                  controller: screenshotController,
                                  child: SizedBox(
                                    height: 2 * screenW,
                                    width: screenW,
                                    child: GridView.builder(
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
                                        final collageId = snapshot.data
                                            ?.collageDtoList?[0].collageStyle;

                                        Widget collageWidget;

                                        switch (collageId) {
                                          case 1:
                                            collageWidget = Collage0(
                                              collagePhotos:
                                                  snapshot.data!.collagePhotos,
                                            );
                                            break;
                                          case 2:
                                            collageWidget = Collage1(
                                              collagePhotos:
                                                  snapshot.data!.collagePhotos,
                                            );
                                            break;
                                          case 3:
                                            collageWidget = Collage2(
                                              collagePhotos:
                                                  snapshot.data!.collagePhotos,
                                            );
                                            break;
                                          case 4:
                                            collageWidget = Collage3(
                                              collagePhotos:
                                                  snapshot.data!.collagePhotos,
                                            );
                                            break;
                                          case 5:
                                            collageWidget = Collage4(
                                              collagePhotos:
                                                  snapshot.data!.collagePhotos,
                                            );
                                            break;
                                          case 6:
                                            collageWidget = Collage5(
                                              collagePhotos:
                                                  snapshot.data!.collagePhotos,
                                            );
                                            break;
                                          case 7:
                                            collageWidget = Collage6(
                                              collagePhotos:
                                                  snapshot.data!.collagePhotos,
                                            );
                                            break;
                                          case 8:
                                            collageWidget = Collage7(
                                              collagePhotos:
                                                  snapshot.data!.collagePhotos,
                                            );
                                            break;
                                          default:
                                            collageWidget = Container();
                                        }

                                        return collageWidget;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // captureScreenshot();
                                          screenshotController
                                              .capture(
                                                  delay: Duration(
                                                      milliseconds: 10))
                                              .then((capturedImage) async {
                                            ShowCapturedWidget(
                                                context,
                                                capturedImage!,
                                                _userModel?.username);
                                          }).catchError((onError) {
                                            print(onError);
                                          });
                                        },
                                        child: Icon(Icons.camera_alt_outlined),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => CommentScreen(),
                                              arguments: [
                                                _userModel!.username!,
                                                0
                                              ]);
                                        },
                                        child: Icon(Icons.comment_rounded),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BannerAdmob(),
                                ),
                                FutureBuilder<FriendUserModel>(
                                  future:
                                      _friendUserController.getFriendProfile(
                                          _userModel?.username ?? ''),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(
                                        'Yorumlara ulaşılamadı tekrar deneyiniz',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      );
                                    } else {
                                      final comments = snapshot.data?.comments;

                                      if (comments != null &&
                                          comments.isNotEmpty) {
                                        return Container(
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: comments.length,
                                            itemBuilder: (context, index) {
                                              final comment = comments[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            comment.writer ??
                                                                '',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleLarge,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _commentController
                                                                    .deleteComment(
                                                                        comment
                                                                            .id!);
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 12),
                                                        child: Text(
                                                          "- ${comment.content} " ??
                                                              '',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          18),
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
                                  height: 12,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Text('No collages found.');
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
