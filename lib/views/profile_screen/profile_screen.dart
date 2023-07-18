import 'dart:io';
import 'package:collage_me/controllers/friend_request_controller.dart';
import 'package:collage_me/controllers/image_helper.dart';
import 'package:collage_me/core/auth_manager.dart';
import 'package:collage_me/models/friend_request_model.dart';
import 'package:collage_me/models/user_model.dart';
import 'package:collage_me/splah_screen.dart';
import 'package:collage_me/views/profile_screen/onboard_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:collage_me/views/components/fab_button.dart';
import 'package:collage_me/views/profile_screen/collage_selection.dart';
import 'package:collage_me/views/profile_screen/follower_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/profile_screen_controller.dart';
import '../components/bottom_navbar.dart';
import 'friend_profile_screen.dart';
import 'package:dio/dio.dart' as dio;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  final LoginUserController _loginUserController =
      Get.put(LoginUserController());
  UserModel _userModel = Get.put(UserModel());
  final FriendRequestController _friendRequestControllerController =
      Get.put(FriendRequestController());
  final FriendRequestController _friendRequestController =
      Get.put(FriendRequestController());

  String? uploadedImageUrl;
  bool isImageUploaded = false;
  List<FriendRequestModel> _requestList = [];

  Future<void> userInformationFunction() async {
    _userModel = await _loginUserController.getProfileData();
  }

  Stream<List<FriendRequestModel>> getFriendRequestStream() {
    return _friendRequestController.getFriendRequest().asStream();
  }

  Future<void> uploadImageDio(File imageFile) async {
    final url = 'https://evliliksitesii.com/addAvatar';
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    Get.off(() => OnboardProfile());

    try {
      isImageUploaded = false;
      dioService.options.headers['Authorization'] =
          "Bearer ${_friendRequestControllerController.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });
      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        uploadedImageUrl = response.data['imageUrl'];
        setState(() {
          isImageUploaded = true;
        });
        Get.off(() => ProfileScreen());
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    userInformationFunction();
  }

  File? _image;
  final imageHelper = Get.put(ImageHelper());
  var croppedFile;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _loginUserController.getProfileData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final UserModel? userModel = snapshot.data;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: const FabButton(),
            bottomNavigationBar: const BottomNavbar(),
            appBar: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: GestureDetector(
                onTap: () {
                  _authManager.logOut();
                  Get.off(() => SplashView());
                },
                child: Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    userModel?.username ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const CollageSelection());
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      child: Icon(Icons.format_paint),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: GestureDetector(
                          onTap: () async {
                            final files = await imageHelper.pickImage();
                            if (files != null) {
                              croppedFile = await imageHelper.crop(
                                  file: files, cropStyle: CropStyle.circle);
                              if (croppedFile != null) {
                                setState(() => _image = File(croppedFile.path));
                                try {
                                  await uploadImageDio(File(croppedFile.path));
                                  print('Image uploaded successfully');
                                  Get.snackbar("Image", "upload successfully");
                                } catch (e) {
                                  print('Error uploading image: $e');
                                  Get.snackbar(
                                      "Error", "upload unsuccessfully");
                                }
                              }
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 36,
                            foregroundImage: NetworkImage(isImageUploaded
                                ? uploadedImageUrl!
                                : userModel?.imgUrl ?? ''),
                            child: const Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => FollowerScreen(),
                            arguments: _userModel.username);
                      },
                      child: Container(
                        height: 70,
                        width: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.onInverseSurface,
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
                              _userModel.friendsCount.toString(),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "request".tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<FriendRequestModel>>(
                      stream: getFriendRequestStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          _requestList = snapshot.data ?? [];

                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 0.85,
                            ),
                            itemCount: _requestList.length,
                            itemBuilder: (context, itemNumber) {
                              final requestItem = _requestList[itemNumber];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              FriendProfileScreen(),
                                              arguments: requestItem.userId,
                                            );
                                          },
                                          child: Container(
                                            height: 12.h,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surfaceVariant,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                requestItem.userId!,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 10.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceVariant,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  _friendRequestController
                                                      .confirmFriend(
                                                    requestItem.userId!,
                                                  );
                                                },
                                                child: Container(
                                                  height: 4.h,
                                                  width: 8.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Icon(
                                                    Icons.done_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  _friendRequestController
                                                      .declineFriend(
                                                          requestItem.userId!);
                                                },
                                                child: Container(
                                                  height: 4.h,
                                                  width: 8.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
