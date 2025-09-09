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
              size: 26,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ==== HEADER ====
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(AppColor.main),
                        Color(AppColor.main).withOpacity(0.9),
                      ],
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

                // TAB MENGAMBANG
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
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () => controller.setMenu(1),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedMenu.value == 1
                                      ? Color(AppColor.main)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "Hutang",
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: controller.selectedMenu.value == 1
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () => controller.setMenu(2),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedMenu.value == 2
                                      ? Color(AppColor.main)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "Piutang",
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: controller.selectedMenu.value == 2
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
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

            const SizedBox(height: 70),

            // ==== KONTEN ====
            Expanded(
              child: Center(
                child: Obx(() {
                  switch (controller.selectedMenu.value) {
                    case 1:
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
                    case 2:
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
                    default:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 60,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Silakan pilih menu",
                            style: GoogleFonts.sora(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      );
                  }
                }),
              ),
            ),
          ],
        ),
      ),

      // ==== BOTTOM NAVIGATION ====
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ================= BOTTOM NAVIGATION =================
  Widget _buildBottomNav() {
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
              Get.offAllNamed(Routes.ADD_TRANSACTION);
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
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task),
            label: "Transaksi",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
