import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:si_lunas/core/color/app_color.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColor.base),
      appBar: AppBar(
        backgroundColor: Color(AppColor.main),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: GoogleFonts.sora(
            color: Color(AppColor.base),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder(
        future: controller.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
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

              // Konten profil
              Positioned.fill(
                top: 15,
                child: Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 118,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Color(AppColor.main),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Card info user
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.nama.value,
                                style: GoogleFonts.sora(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                controller.email.value,
                                style: GoogleFonts.sora(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Menu tambahan
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: Icon(
                                Icons.edit_document,
                                color: Color(AppColor.main),
                              ),
                              title: Text(
                                "Edit Profile",
                                style: GoogleFonts.sora(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppColor.main),
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onTap: () {
                                Get.toNamed(Routes.EDIT_PROFILE);
                              },
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.redAccent,
                              ),
                              title: Text(
                                "Keluar",
                                style: GoogleFonts.sora(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onTap: () {
                                controller.logout();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),

      // ==== BOTTOM NAVIGATION ====
      bottomNavigationBar: _BottomBar(controller: controller),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.controller});

  final ProfileController controller;

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
