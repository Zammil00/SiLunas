import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool isHide = true.obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
}
