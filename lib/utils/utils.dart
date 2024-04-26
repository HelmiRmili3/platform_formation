import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickImage() async {
  File? image;
  final picker = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowCompression: true,
  );

  if (picker != null && picker.files.isNotEmpty) {
    image = File(picker.files.first.path!);
  }

  return image;
}