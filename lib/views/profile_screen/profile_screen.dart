import 'dart:io';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  final LoginUserController _loginUserController =
      Get.put(LoginUserController());
  final UserCollageController _userCollageController =
      Get.put(UserCollageController());
  UserModel _userModel = Get.put(UserModel());

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
    var userName = _userModel.userName.obs;
    debugPrint(_userModel.userName);
  }

  Future<void> uploadImage(File imageFile) async {
    final url =
        'https://evliliksitesii.com/addAvatar'; // Replace with your API endpoint
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
    // Add any additional parameters or headers to the request if needed

    final response = await request.send();
    if (response.statusCode == 200) {
      print(imageFile.path);
      print('Image uploaded successfully');
    } else {
      print('Image upload failed with status code ${response.statusCode}');
    }
  }

  @override
  void initState() {
    userInformationFunction();
    _userCollageController.userCollage();
    super.initState();
  }

  File? _image;
  final imageHelper = Get.put(ImageHelper());
  // ignore: prefer_typing_uninitialized_variables
  var croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              FutureBuilder<UserModel>(
                future: _loginUserController.getProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show nothing while loading
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final UserModel? userModel = snapshot.data;

                    return Text(
                      userModel?.userName ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary),
                    );
                  }
                },
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
                            await uploadImage(File(croppedFile
                                .path)); // Send the image file to the API
                          }
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 36,
                        foregroundImage:
                            _image != null ? FileImage(_image!) : null,
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
                        arguments: _userModel.userName);
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
                          "Takipçi :",
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
                  "Arkadaş İsteklerin",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
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
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('croppedFile', croppedFile));
  }
}
