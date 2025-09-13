import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/color/app_color.dart';

import '../../../routes/app_pages.dart';
import '../controllers/detail_transaction_controller.dart';

class DetailTransactionView extends GetView<DetailTransactionController> {
  const DetailTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fc),
      appBar: AppBar(
        backgroundColor: Color(AppColor.main),
        elevation: 0,
        title: Text(
          'Detail Transaksi',
          style: GoogleFonts.sora(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getTransactionById(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.transactionDetail.isEmpty) {
            return Center(
              child: Text(
                'Data transaksi tidak ditemukan',
                style: GoogleFonts.sora(fontSize: 16, color: Colors.grey[600]),
              ),
            );
          }

          final transaksi = controller.transactionDetail;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // HEADER CARD
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(AppColor.main),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: Color(AppColor.main),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          transaksi['name'] != null
                              ? "${transaksi['name']}"
                              : "-",
                          style: GoogleFonts.sora(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // TAMPILAN AMOUNT CARD
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 28,
                        color: Color(AppColor.main),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jumlah",
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              transaksi['amount'] != null
                                  ? "Rp ${transaksi['amount']}"
                                  : "-",
                              style: GoogleFonts.sora(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // TAMPILAN TYPE CARD
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.type_specimen_rounded,
                        size: 28,
                        color: Color(AppColor.main),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jenis Transaksi",
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              transaksi['type'] == "Utang"
                                  ? "Utang"
                                  : "Piutang",
                              style: GoogleFonts.sora(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:
                            (transaksi['type'] == "Utang"
                                    ? Colors.red
                                    : Colors.green)
                                .withOpacity(0.1),
                        child: Icon(
                          transaksi['type'] == "Utang"
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: transaksi['type'] == "Utang"
                              ? Colors.red
                              : Colors.green,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // TAMPILAN NOTE CARD
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.note, size: 28, color: Color(AppColor.main)),

                      SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Catatan",
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              transaksi['note'] != null &&
                                      transaksi['note'].toString().isNotEmpty
                                  ? "${transaksi['note']}"
                                  : "Tidak ada catatan",
                              style: GoogleFonts.sora(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // TAMPILAN TANGGAL TRANSAKSI CARD
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 28,
                        color: Color(AppColor.main),
                      ),

                      SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal Transaksi",
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              transaksi['date'] != null
                                  ? "${transaksi['date']}"
                                  : "-",
                              style: GoogleFonts.sora(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // TANGGAL JATUH TEMPO CARD
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.dataset_linked,
                        size: 28,
                        color: Color(AppColor.main),
                      ),

                      SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal Jatuh Tempo",
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),

                            Text(
                              transaksi['due_date'] != null
                                  ? "${transaksi['due_date']}"
                                  : "-",
                              style: GoogleFonts.sora(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // BUTTON DELETE DAN EDIT
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.deleteTransaction(transaksi['id']);
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 28,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Hapus',
                          style: GoogleFonts.sora(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.toNamed(Routes.EDIT_TRANSACTION);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 28,
                        ),
                        label: Text(
                          'Edit',
                          style: GoogleFonts.sora(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(AppColor.main),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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
  }
}
