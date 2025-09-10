import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../config/app_colors.dart';

class ImageUtils {
  static Future<File?> pickCropCompressImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(source: source);
      if (picked == null) return null;

      final File pickedFile = File(picked.path);

      // Crop
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: AppColors.primary,
            statusBarColor: AppColors.primary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: "Crop Image",
            aspectRatioLockEnabled: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );

      if (croppedFile == null) return null;

      // Compress to 600x600 and quality ~30
      final tempDir = await getTemporaryDirectory();
      final targetPath = path.join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}_600x600.jpg');

      final XFile? compressed = await FlutterImageCompress.compressAndGetFile(
        croppedFile.path,
        targetPath,
        minWidth: 500,
        minHeight: 500,
        quality: 80,
        format: CompressFormat.jpeg,
      );
      return File(compressed?.path ?? croppedFile.path);
    } catch (e) {
      debugPrint("Error in pickCropCompressImage: $e");
      return null;
    }
  }
}
