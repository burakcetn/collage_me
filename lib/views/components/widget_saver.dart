import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveToGalleryButton extends StatelessWidget {
  final Uint8List imageData;

  SaveToGalleryButton({required this.imageData});

  Future<void> _saveImageToGallery() async {
    // Request permission to save to the gallery
    PermissionStatus status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Permission denied');
    }

    // Decode the image
    img.Image? image = img.decodeImage(imageData);

    // Get the directory for storing the image
    Directory directory = await getTemporaryDirectory();
    String filePath = '${directory.path}/output.png';

    // Save the image to the temporary directory
    File(filePath).writeAsBytesSync(img.encodePng(image!));

    // Save the image to the gallery
    final result = await ImageGallerySaver.saveFile(filePath);
    if (result['isSuccess'] == false) {
      throw Exception('Failed to save image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _saveImageToGallery().then((_) {
          // Show a success message or perform any other actions
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image saved to gallery')),
          );
        }).catchError((error) {
          // Show an error message or perform any other error handling
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save image')),
          );
        });
      },
      child: Text('Save to Gallery'),
    );
  }
}
