import 'dart:io';

import 'package:breathin/core/logger_customizations/custom_logger.dart';
import 'package:breathin/core/widgets/custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class FilePickerService {
  final log = CustomLogger(className: 'FilePickerService');
  File? selectedImage;

  Future<File?> pickImage() async {
    log.i("print 2");
    return await pickImageWithoutCompression();
  }

  selectPdf() async {
    File? selectedPdf;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedPdf = File(result.paths.first!);
      final extension = p.extension(selectedPdf.path);
      debugPrint('@FilePcikerService.pickPdf ==> Extension: $extension');

      if (extension == '.pdf') {
        return selectedPdf;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  pickImageWithoutCompression() async {
    log.i("print 3");
    File? selectedImage;
    final filePicker = FilePicker.platform;
    log.i("print 4");
    FilePickerResult? result = await filePicker.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    log.i("print 5 $result");
    if (result != null) {
      selectedImage = File(result.paths.first!);
      final extension = p.extension(selectedImage.path);
      log.d('@FilePcikerService.pickImage ==> Extension: $extension');

      if (extension == '.jpg' ||
          extension == '.jpeg' ||
          extension == '.png' ||
          extension == '.gif') {
        return selectedImage;
      } else {
        customSnackBar(message: "Something went wrong. Please try again.");
        return null;
      }
    }
  }

  // Future<File?> _compressImageFile(File file, String targetPath) async {
  //   debugPrint(
  //       '@compressImageFile => Size before compression: ${await file.length()}');
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     targetPath,
  //     quality: 70,
  //   );

  //   if (result != null) {
  //     print('File compressed successfully');
  //   } else {
  //     print('Compressed file path is null');
  //   }

  //   debugPrint(
  //       '@compressImageFile => Size after compression: ${await result?.length()}');
  //   return result;
  // }
}
