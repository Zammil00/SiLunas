import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:si_lunas/core/color/app_color.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(AppColor.main)),
      body: Center(),
    );
  }
}
