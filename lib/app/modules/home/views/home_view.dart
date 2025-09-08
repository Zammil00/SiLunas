import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:si_lunas/core/color/app_color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColor.base),
      appBar: AppBar(
        backgroundColor: Color(AppColor.main),
        elevation: 0,
        title: Text(
          "Hi, Labil Dev",
          style: GoogleFonts.sora(
            color: Color(AppColor.base),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Color(AppColor.base),
              size: 30,
            ),
          ),
        ],
      ),

      // ==== BOTTOM NAVIGATION ====
      bottomNavigationBar: _BottomBar(controller: controller),

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(AppColor.main), Color(AppColor.main)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rp. 90.000",
                        style: GoogleFonts.sora(
                          color: Color(AppColor.base),
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Total Hutang Kamu",
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                // CARD TAB MENGAMBANG
                Positioned(
                  bottom: -30,
                  left: 40,
                  right: 40,
                  child: Obx(
                    () => Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _tabButton(
                            label: "Hutang",
                            active: controller.selectedMenu.value == 1,
                            onTap: () => controller.setMenu(1),
                          ),
                          _tabButton(
                            label: "Piutang",
                            active: controller.selectedMenu.value == 2,
                            onTap: () => controller.setMenu(2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 70),

            // KONTEN BAWAH
            Expanded(
              child: Center(
                child: Obx(() {
                  if (controller.selectedMenu.value == 1) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.money_off_csred_rounded,
                          size: 60,
                          color: Colors.red[400],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Menampilkan data Hutang",
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    );
                  } else if (controller.selectedMenu.value == 2) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 60,
                          color: Colors.green[400],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Menampilkan data Piutang",
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      "Silakan pilih menu",
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Tab Button
  Widget _tabButton({
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? Color(AppColor.main) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: GoogleFonts.sora(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: active ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        backgroundColor: Color(AppColor.base),
        currentIndex: controller.bottomIndex.value,
        onTap: (index) {
          controller.setBottomIndex(index);

          // Handle route sesuai index
          switch (index) {
            case 0:
              Get.offAllNamed(Routes.HOME);
              break;
            case 1:
              Get.offAllNamed('/riwayat');
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
