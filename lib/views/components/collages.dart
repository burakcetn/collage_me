import 'dart:io';

import 'package:collage_me/controllers/user_collage_controller.dart';
import 'package:collage_me/models/friend_profile_model.dart';
import 'package:collage_me/views/home_screen/home_screen.dart';
import 'package:collage_me/views/profile_screen/onboard_friend_collage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:collage_me/models/user_collage_model.dart';
import 'package:dio/dio.dart' as dio;
import '../../controllers/image_helper.dart';
import '../collage_screen/onboard_collage.dart';

class Collage0 extends StatelessWidget {
  Collage0(
      {Key? key,
      this.collagePhotos,
      this.collageFriendPhotos,
      this.friendUsername})
      : super(key: key);
  List<CollagePhoto>? collagePhotos;
  List<CollageFriendPhoto>? collageFriendPhotos;
  String? friendUsername;

  final imageHelper = ImageHelper();
  final UserCollageController _controller = Get.put(UserCollageController());
  File? _image;
  var croppedFile;

  Future<void> _pickAndCropImage(
      BuildContext context, int index, int? collageId, int screen) async {
    final pickedImage = await imageHelper.pickImage();
    if (pickedImage != null) {
      final croppedImage = await imageHelper.crop(file: pickedImage);
      if (croppedImage != null) {
        _image = File(croppedImage.path);
        // Send the cropped image with its index value via POST request
        await _sendImage(index, _image!, collageId, screen);
      }
    }
  }

  Future<void> _sendImage(
      int index, File imageFile, int? collageId, int screen) async {
    ///ChangePhoto/{CollageId}/{index}
    final url =
        'https://evliliksitesii.com/ChangePhoto/$collageId/${index + 1}'; // Replace with your API endpoint
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    debugPrint("url ::: $url");
    if (screen == 0) {
      Get.off(() => OnboardCollage());
    } else {
      Get.off(() => OnboardFriendProfile(), arguments: friendUsername);
    }
    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_controller.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Image", "uploaded");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 4,
            mainAxisCellCount: 8,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                  index: 0,
                  imgUrl: collagePhotos != null
                      ? (collagePhotos?[0].photoUrl)
                      : collageFriendPhotos?[0].photoUrl),
            ),
          ),
        ],
      ),
    );
  }
}

class Collage1 extends StatelessWidget {
  Collage1(
      {super.key,
      this.collagePhotos,
      this.collageFriendPhotos,
      this.friendUsername});
  List<CollagePhoto>? collagePhotos;
  List<CollageFriendPhoto>? collageFriendPhotos;
  String? friendUsername;

  final imageHelper = ImageHelper();
  final UserCollageController _controller = Get.put(UserCollageController());
  File? _image;
  var croppedFile;

  Future<void> _pickAndCropImage(
      BuildContext context, int index, int? collageId, int screen) async {
    final pickedImage = await imageHelper.pickImage();
    if (pickedImage != null) {
      final croppedImage = await imageHelper.crop(file: pickedImage);
      if (croppedImage != null) {
        _image = File(croppedImage.path);
        // Send the cropped image with its index value via POST request
        await _sendImage(index, _image!, collageId, screen);
      }
    }
  }

  Future<void> _sendImage(
      int index, File imageFile, int? collageId, int screen) async {
    ///ChangePhoto/{CollageId}/{index}
    final url =
        'https://evliliksitesii.com/ChangePhoto/$collageId/${index + 1}'; // Replace with your API endpoint
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    debugPrint("url ::: $url");
    if (screen == 0) {
      Get.off(() => OnboardCollage());
    } else {
      Get.off(() => OnboardFriendProfile(), arguments: friendUsername);
    }
    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_controller.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Image", "uploaded");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 0,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[0].photoUrl)
                    : collageFriendPhotos?[0].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  1,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 1,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[1].photoUrl)
                    : collageFriendPhotos?[1].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  2,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 2,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[2].photoUrl)
                    : collageFriendPhotos?[2].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  3,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 3,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[3].photoUrl)
                    : collageFriendPhotos?[3].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 4,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  4,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 4,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[4].photoUrl)
                    : collageFriendPhotos?[4].photoUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Collage2 extends StatelessWidget {
  List<CollagePhoto>? collagePhotos;
  List<CollageFriendPhoto>? collageFriendPhotos;
  Collage2(
      {super.key,
      this.collagePhotos,
      this.collageFriendPhotos,
      this.friendUsername});
  String? friendUsername;

  final imageHelper = ImageHelper();
  final UserCollageController _controller = Get.put(UserCollageController());
  File? _image;
  var croppedFile;

  Future<void> _pickAndCropImage(
      BuildContext context, int index, int? collageId, int screen) async {
    final pickedImage = await imageHelper.pickImage();
    if (pickedImage != null) {
      final croppedImage = await imageHelper.crop(file: pickedImage);
      if (croppedImage != null) {
        _image = File(croppedImage.path);
        // Send the cropped image with its index value via POST request
        await _sendImage(index, _image!, collageId, screen);
      }
    }
  }

  Future<void> _sendImage(
      int index, File imageFile, int? collageId, int screen) async {
    ///ChangePhoto/{CollageId}/{index}
    final url =
        'https://evliliksitesii.com/ChangePhoto/$collageId/${index + 1}'; // Replace with your API endpoint
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    debugPrint("url ::: $url");
    if (screen == 0) {
      Get.off(() => OnboardCollage());
    } else {
      Get.off(() => OnboardFriendProfile(), arguments: friendUsername);
    }
    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_controller.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Image", "uploaded");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 0,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[0].photoUrl)
                    : collageFriendPhotos?[0].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 1,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[1].photoUrl)
                    : collageFriendPhotos?[1].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 2,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[2].photoUrl)
                    : collageFriendPhotos?[2].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 3,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[3].photoUrl)
                    : collageFriendPhotos?[3].photoUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Collage3 extends StatelessWidget {
  List<CollagePhoto>? collagePhotos;
  List<CollageFriendPhoto>? collageFriendPhotos;
  String? friendUsername;
  Collage3(
      {Key? key,
      this.collagePhotos,
      this.collageFriendPhotos,
      this.friendUsername})
      : super(key: key);

  final imageHelper = ImageHelper();
  final UserCollageController _controller = Get.put(UserCollageController());
  File? _image;
  var croppedFile;

  Future<void> _pickAndCropImage(
      BuildContext context, int index, int? collageId, int screen) async {
    final pickedImage = await imageHelper.pickImage();
    if (pickedImage != null) {
      final croppedImage = await imageHelper.crop(file: pickedImage);
      if (croppedImage != null) {
        _image = File(croppedImage.path);
        // Send the cropped image with its index value via POST request
        await _sendImage(index, _image!, collageId, screen);
      }
    }
  }

  Future<void> _sendImage(
      int index, File imageFile, int? collageId, int screen) async {
    ///ChangePhoto/{CollageId}/{index}
    final url =
        'https://evliliksitesii.com/ChangePhoto/$collageId/${index + 1}'; // Replace with your API endpoint
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    debugPrint("url ::: $url");
    if (screen == 0) {
      Get.off(() => OnboardCollage());
    } else {
      Get.off(() => OnboardFriendProfile(), arguments: friendUsername);
    }
    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_controller.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Image", "uploaded");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 0,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[0].photoUrl)
                    : collageFriendPhotos?[0].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 6,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 1,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[1].photoUrl)
                    : collageFriendPhotos?[1].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 6,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 2,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[2].photoUrl)
                    : collageFriendPhotos?[2].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 3,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[3].photoUrl)
                    : collageFriendPhotos?[3].photoUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Collage4 extends StatelessWidget {
  List<CollagePhoto>? collagePhotos;
  List<CollageFriendPhoto>? collageFriendPhotos;
  String? friendUsername;

  Collage4(
      {Key? key,
      this.collagePhotos,
      this.collageFriendPhotos,
      this.friendUsername})
      : super(key: key);

  final imageHelper = ImageHelper();
  final UserCollageController _controller = Get.put(UserCollageController());
  File? _image;
  var croppedFile;

  Future<void> _pickAndCropImage(
      BuildContext context, int index, int? collageId, int screen) async {
    final pickedImage = await imageHelper.pickImage();
    if (pickedImage != null) {
      final croppedImage = await imageHelper.crop(file: pickedImage);
      if (croppedImage != null) {
        _image = File(croppedImage.path);
        // Send the cropped image with its index value via POST request
        await _sendImage(index, _image!, collageId, screen);
      }
    }
  }

  Future<void> _sendImage(
      int index, File imageFile, int? collageId, int screen) async {
    ///ChangePhoto/{CollageId}/{index}
    final url =
        'https://evliliksitesii.com/ChangePhoto/$collageId/${index + 1}'; // Replace with your API endpoint
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    debugPrint("url ::: $url");
    if (screen == 0) {
      Get.off(() => OnboardCollage());
    } else {
      Get.off(() => OnboardFriendProfile(), arguments: friendUsername);
    }

    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_controller.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Image", "uploaded");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 0,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[0].photoUrl)
                    : collageFriendPhotos?[0].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 1,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[1].photoUrl)
                    : collageFriendPhotos?[1].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 2,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[2].photoUrl)
                    : collageFriendPhotos?[2].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 3,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[3].photoUrl)
                    : collageFriendPhotos?[3].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 3,
            mainAxisCellCount: 6,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 4,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[4].photoUrl)
                    : collageFriendPhotos?[4].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 5,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[5].photoUrl)
                    : collageFriendPhotos?[5].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 6,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[6].photoUrl)
                    : collageFriendPhotos?[6].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 7,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[7].photoUrl)
                    : collageFriendPhotos?[7].photoUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Collage5 extends StatelessWidget {
  List<CollagePhoto>? collagePhotos;
  List<CollageFriendPhoto>? collageFriendPhotos;
  String? friendUsername;
  Collage5(
      {Key? key,
      this.collagePhotos,
      this.collageFriendPhotos,
      this.friendUsername})
      : super(key: key);

  final imageHelper = ImageHelper();
  final UserCollageController _controller = Get.put(UserCollageController());
  File? _image;
  var croppedFile;

  Future<void> _pickAndCropImage(
      BuildContext context, int index, int? collageId, int screen) async {
    final pickedImage = await imageHelper.pickImage();
    if (pickedImage != null) {
      final croppedImage = await imageHelper.crop(file: pickedImage);
      if (croppedImage != null) {
        _image = File(croppedImage.path);
        // Send the cropped image with its index value via POST request
        await _sendImage(index, _image!, collageId, screen);
      }
    }
  }

  Future<void> _sendImage(
      int index, File imageFile, int? collageId, int screen) async {
    ///ChangePhoto/{CollageId}/{index}
    final url =
        'https://evliliksitesii.com/ChangePhoto/$collageId/${index + 1}'; // Replace with your API endpoint
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    debugPrint("url ::: $url");
    if (screen == 0) {
      Get.off(() => OnboardCollage());
    } else {
      Get.off(() => OnboardFriendProfile(), arguments: friendUsername);
    }
    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_controller.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Image", "uploaded");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 0,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[0].photoUrl)
                    : collageFriendPhotos?[0].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 1,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[1].photoUrl)
                    : collageFriendPhotos?[1].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 6,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 2,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[2].photoUrl)
                    : collageFriendPhotos?[2].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 3,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[3].photoUrl)
                    : collageFriendPhotos?[3].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 4,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[4].photoUrl)
                    : collageFriendPhotos?[4].photoUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Collage6 extends StatelessWidget {
  Collage6(
      {Key? key,
      this.collagePhotos,
      this.collageFriendPhotos,
      this.friendUsername})
      : super(key: key);
  List<CollagePhoto>? collagePhotos;
  List<CollageFriendPhoto>? collageFriendPhotos;
  String? friendUsername;

  final imageHelper = ImageHelper();
  final UserCollageController _controller = Get.put(UserCollageController());
  File? _image;
  var croppedFile;

  Future<void> _pickAndCropImage(
      BuildContext context, int index, int? collageId, int screen) async {
    final pickedImage = await imageHelper.pickImage();
    if (pickedImage != null) {
      final croppedImage = await imageHelper.crop(file: pickedImage);
      if (croppedImage != null) {
        _image = File(croppedImage.path);
        // Send the cropped image with its index value via POST request
        await _sendImage(index, _image!, collageId, screen);
      }
    }
  }

  Future<void> _sendImage(
      int index, File imageFile, int? collageId, int screen) async {
    ///ChangePhoto/{CollageId}/{index}
    final url =
        'https://evliliksitesii.com/ChangePhoto/$collageId/${index + 1}'; // Replace with your API endpoint
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    debugPrint("url ::: $url");
    if (screen == 0) {
      Get.off(() => OnboardCollage());
    } else {
      Get.off(() => OnboardFriendProfile(), arguments: friendUsername);
    }
    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_controller.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Image", "uploaded");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 4,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 0,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[0].photoUrl)
                    : collageFriendPhotos?[0].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 1,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[1].photoUrl)
                    : collageFriendPhotos?[1].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 4,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 2,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[2].photoUrl)
                    : collageFriendPhotos?[2].photoUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Collage7 extends StatelessWidget {
  List<CollagePhoto>? collagePhotos;
  List<CollageFriendPhoto>? collageFriendPhotos;
  String? friendUsername;

  Collage7(
      {Key? key,
      this.collagePhotos,
      this.collageFriendPhotos,
      this.friendUsername})
      : super(key: key);

  final imageHelper = ImageHelper();
  final UserCollageController _controller = Get.put(UserCollageController());
  File? _image;
  var croppedFile;

  Future<void> _pickAndCropImage(
      BuildContext context, int index, int? collageId, int screen) async {
    final pickedImage = await imageHelper.pickImage();
    if (pickedImage != null) {
      final croppedImage = await imageHelper.crop(file: pickedImage);
      if (croppedImage != null) {
        _image = File(croppedImage.path);
        // Send the cropped image with its index value via POST request
        await _sendImage(index, _image!, collageId, screen);
      }
    }
  }

  Future<void> _sendImage(
      int index, File imageFile, int? collageId, int screen) async {
    ///ChangePhoto/{CollageId}/{index}
    final url =
        'https://evliliksitesii.com/ChangePhoto/$collageId/${index + 1}'; // Replace with your API endpoint
    final dioService = dio.Dio();
    String fileName = imageFile.path.split('/').last;

    debugPrint("url ::: $url");
    if (screen == 0) {
      Get.off(() => OnboardCollage());
    } else {
      Get.off(() => OnboardFriendProfile(), arguments: friendUsername);
    }
    try {
      dioService.options.headers['Authorization'] =
          "Bearer ${_controller.getToken()}";
      dioService.options.contentType = 'multipart/form-data';

      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(imageFile.path,
            filename: fileName),
      });

      final response = await dioService.post(url, data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Image", "uploaded");
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 8,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 0,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[0].photoUrl)
                    : collageFriendPhotos?[0].photoUrl,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 8,
            child: GestureDetector(
              onTap: () => _pickAndCropImage(
                  context,
                  0,
                  collagePhotos != null
                      ? (collagePhotos?[0].collageId)
                      : (collageFriendPhotos?[0].collageId),
                  collagePhotos != null ? 0 : 1),
              child: Tile(
                index: 1,
                imgUrl: collagePhotos != null
                    ? (collagePhotos?[1].photoUrl)
                    : collageFriendPhotos?[1].photoUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.imgUrl,
    this.extent,
    this.bottomSpace,
  }) : super(key: key);

  final String? imgUrl;
  final int index;
  final double? extent;
  final double? bottomSpace;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple[200],
          borderRadius: BorderRadius.circular(15)),
      height: extent,
      child: imgUrl == null
          ? Center(
              child: CircleAvatar(
                minRadius: 20,
                maxRadius: 20,
                backgroundColor: Colors.white38,
                foregroundColor: Colors.black,
                child: Icon(Icons.add),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: NetworkImage(imgUrl!),
                fit: BoxFit.fill,
              ),
            ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
