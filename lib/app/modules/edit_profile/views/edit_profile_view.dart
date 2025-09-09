import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:si_lunas/core/color/app_color.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColor.base),
      appBar: AppBar(
        backgroundColor: Color(AppColor.main),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.sora(
            color: Color(AppColor.base),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Stack(
        children: [
          // Background atas melengkung
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                color: Color(AppColor.main),
              ),
            ),
          ),

          // Konten Edit Profile
          Positioned.fill(
            top: 15,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Avatar
                  // Ganti bagian Avatar kamu di EditProfileView jadi seperti ini:
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 118,
                        backgroundColor: Colors.white,
                        backgroundImage: controller.imageFile.value != null
                            ? FileImage(controller.imageFile.value!)
                            : null,
                        child: controller.imageFile.value == null
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: Color(AppColor.main),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 12,
                        right: MediaQuery.of(context).size.width * 0.28,
                        child: InkWell(
                          onTap: () {
                            controller.pickImage(); // fungsi di controller
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(AppColor.main),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // Card form edit profile
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 24,
                        ),
                        child: Column(
                          children: [
                            TextField(
                              // controller: controller.namaC,
                              style: GoogleFonts.sora(fontSize: 16),
                              decoration: InputDecoration(
                                labelText: "Nama Lengkap",
                                labelStyle: GoogleFonts.sora(),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(AppColor.main),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              // controller: controller.emailC,
                              style: GoogleFonts.sora(fontSize: 16),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: GoogleFonts.sora(),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(AppColor.main),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(AppColor.main),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Simpan Perubahan",
                                  style: GoogleFonts.sora(
                                    color: Color(AppColor.base),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ==== BOTTOM NAVIGATION ====
      bottomNavigationBar: _BottomBar(controller: controller),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.controller});

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        backgroundColor: Color(AppColor.base),
        currentIndex: controller.bottomIndex.value,
        onTap: (index) {
          controller.setBottomIndex(index);
          switch (index) {
            case 0:
              Get.offAllNamed(Routes.HOME);
              break;
            case 1:
              Get.offAllNamed(Routes.TRANSACTIONS);
              break;
            case 2:
              Get.offAllNamed(Routes.PROFILE);
              break;
          }
        },
        selectedItemColor: Color(AppColor.main),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
