import 'dart:io';
import 'package:collage_me/controllers/friend_controller.dart';
import 'package:collage_me/controllers/friend_request_controller.dart';
import 'package:collage_me/controllers/image_helper.dart';
import 'package:collage_me/controllers/user_collage_controller.dart';
import 'package:collage_me/core/auth_manager.dart';
import 'package:http/http.dart' as http;
import 'package:collage_me/models/user_model.dart';
import 'package:collage_me/splah_screen.dart';
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

  final List friendRequest = [
    'Kullanıcı 1',
    'Kullanıcı 2',
    'Kullanıcı 3',
    'Kullanıcı 4',
    'Kullanıcı 5',
    'Kullanıcı 6'
  ].obs;

  Future userInformationFunction() async {
    _userModel = await _loginUserController.getProfileData();
  }

  Future<void> uploadImageDio(File imageFile) async {
    final url = 'https://evliliksitesii.com/addAvatar';
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_friendRequestControllerController.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });
      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
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
    _friendRequestControllerController.getFriendRequest();
    userInformationFunction();
    //_userCollageController.userCollage();
    super.initState();
  }

  File? _image;
  final imageHelper = Get.put(ImageHelper());
  // ignore: prefer_typing_uninitialized_variables
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
                                } catch (e) {
                                  print('Error uploading image: $e');
                                }
                              }
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 36,
                            foregroundImage:
                                NetworkImage(userModel?.imgUrl ?? ''),
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
                              "453",
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
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 0.85),
                      itemCount: 6,
                      itemBuilder: (context, itemNumber) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const FriendProfileScreen(),
                                          arguments: friendRequest[itemNumber]);
                                    },
                                    child: Container(
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Profil foto",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    height: 10.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            friendRequest[itemNumber],
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: Colors.black,
                                                ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 4.h,
                                              width: 8.h,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Icon(
                                                Icons.done_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                            ),
                                            Container(
                                              height: 4.h,
                                              width: 8.h,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Icon(
                                                Icons.close_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
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
