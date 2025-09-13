import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:si_lunas/core/color/app_color.dart';

import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColor.base),
      appBar: AppBar(
        backgroundColor: Color(AppColor.main),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Transaksi',
          style: GoogleFonts.sora(
            color: Color(AppColor.base),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {
                Get.toNamed(Routes.ADD_TRANSACTIONS);
              },
              icon: Icon(Icons.add, size: 35, color: Colors.black87),
            ),
          ),
        ],
      ),

      // BODYNYA KITA PAKE FUTUREBUILDER UNTUK FETCH DATA DARI SUPABASE
      body: FutureBuilder(
        future: controller.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 8),
            child: ListView.builder(
              itemCount: controller.transactionsList.length,
              itemBuilder: (context, index) {
                final transaksi = controller.transactionsList[index];
                return ListTile(
                  // dense: true,
                  visualDensity: VisualDensity.compact,

                  // LEADING NYA
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(AppColor.main),
                    child: Text(
                      "${index + 1}",
                      style: GoogleFonts.sora(color: Colors.white),
                    ),
                  ),

                  // TITLE NYA
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaksi['name'] ?? '-',
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 1),
                          Text(
                            transaksi["amount"] != null
                                ? "Rp ${transaksi["amount"]}"
                                : '-',
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            transaksi['type'] == 'Utang'
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            color: transaksi['type'] == 'Utang'
                                ? Colors.red
                                : Colors.green,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              Get.toNamed(
                                Routes.DETAIL_TRANSACTION,
                                // KIRIM ID TRANSAKSI KE HALAMAN DETAIL TRANSAKSI
                                // ARGUMENTS INI YANG AKAN KITA TANGKAP DI CONTROLLER DETAIL TRANSAKSI
                                arguments: transaksi['id'],
                              );
                            },
                            icon: Icon(
                              Icons.more_horiz_rounded,
                              size: 30,
                              color: Color(AppColor.main),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),

      // ==== FLOATING ACTION BUTTON ====

      // ==== BOTTOM NAVIGATION ====
      bottomNavigationBar: _BottomBar(controller: controller),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.controller});

  final TransactionsController controller;

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
