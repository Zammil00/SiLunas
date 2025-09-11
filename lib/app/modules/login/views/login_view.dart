import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_lunas/core/color/app_color.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // ✅ biar layar ikut naik kalau keyboard muncul
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Color(AppColor.main)),
      body: SafeArea(
        child: SingleChildScrollView(
          // ✅ scroll otomatis
          // padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian atas (gambar ilustrasi)
              Container(
                height:
                    MediaQuery.of(context).size.height *
                    0.25, // ✅ tinggi relatif
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(AppColor.main), Color(AppColor.main)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(300),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      "LOGIN TO SILUNAS APP",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Form
                    Text("Masukkan Email"),
                    TextField(
                      controller: controller.emailC,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text("Masukkan Password"),
                    Obx(
                      () => TextField(
                        controller: controller.passC,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.isHide.value,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () => controller.isHide.toggle(),
                            icon: controller.isHide.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tombol Login
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(AppColor.main),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => controller.login(),
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Link Register & Forgot Password
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Get.offAllNamed('/register'),
                          child: const Text("Buat Akun Baru"),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Get.offAllNamed('/forgotpass'),
                          child: const Text("Lupa Password?"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
