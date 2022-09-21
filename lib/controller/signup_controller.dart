import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  final ImagePicker picker = ImagePicker();
  XFile? thumbnailXFile;

  void setThumbnailXFile(XFile xfile) {
    thumbnailXFile = xfile;
    update();
  }

}
