import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CameraService {
  CameraService({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  Future<File?> captureSelfie() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 85,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }
}
