import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

abstract class FilePickerHelper {
  // ignore: body_might_complete_normally_nullable
  static Future<File?> pickFile(
      {String title = "Pick a file",
      FileType? type,
      List<String>? allowedExtensions,
      ValueChanged<File>? onSelected}) async {
    var result = await FilePicker.platform.pickFiles(
        type: type ?? FileType.custom,
        allowedExtensions: allowedExtensions,
        dialogTitle: title);
    if (result != null) {
      File file = File(result.files.first.path!);
      if (onSelected != null) onSelected(file);
    } else {
      return null;
    }
  }





  static Future<List<File>?> pickImages({ValueChanged<List<File>>? onSelected}) async {
    // Allow multiple images to be picked
    List<XFile>? returnedImages = await ImagePicker().pickMultiImage();

    if (returnedImages != null && returnedImages.isNotEmpty) {
      // Convert XFile list to File list
      List<File> files = returnedImages.map((image) => File(image.path)).toList();

      // Trigger callback if provided
      if (onSelected != null) onSelected(files);

      return files;
    } else {
      return null; // Return null if no images are selected
    }
  }

}
