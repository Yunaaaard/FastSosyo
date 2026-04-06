import 'dart:io';

import 'package:file_picker/file_picker.dart';

class UploadIdService {
  Future<File?> pickIdFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final String? path = result.files.single.path;
    if (path == null || path.isEmpty) {
      return null;
    }

    return File(path);
  }
}
