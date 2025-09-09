// ================== CONTROLLER ==================
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  var bottomIndex = 2.obs;

  // simpan foto profil
  var imageFile = Rx<File?>(null);

  void setBottomIndex(int index) {
    bottomIndex.value = index;
  }

  // fungsi pilih foto
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // bisa juga ImageSource.camera
      imageQuality: 80,
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }
}
