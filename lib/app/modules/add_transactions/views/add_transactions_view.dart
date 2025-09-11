import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_lunas/core/color/app_color.dart';

import '../controllers/add_transactions_controller.dart';

class AddTransactionsView extends GetView<AddTransactionsController> {
  const AddTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColor.base),
      resizeToAvoidBottomInset: true, // biar konten naik saat keyboard muncul
      appBar: AppBar(
        backgroundColor: Color(AppColor.main),
        title: Text(
          'Tambah Transaksi',
          style: GoogleFonts.sora(
            color: Color(AppColor.base),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 16,
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // JENIS TRANSAKSI
              Text(
                "Jenis Transaksi",
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Obx(
                () => ToggleButtons(
                  borderRadius: BorderRadius.circular(12),
                  borderWidth: 1.5,
                  borderColor: Colors.grey[400]!,
                  selectedBorderColor: Color(AppColor.main),
                  selectedColor: Colors.white,
                  fillColor: Color(AppColor.main),
                  color: Colors.grey[700],
                  isSelected: [
                    controller.typeT.value == 1,
                    controller.typeT.value == 2,
                  ],
                  onPressed: (index) {
                    controller.typeT.value = index == 0 ? 1 : 2;
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_circle_outline,
                            size: 18,
                            color: controller.typeT.value == 1
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Utang",
                            style: GoogleFonts.sora(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 18,
                            color: controller.typeT.value == 2
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Piutang",
                            style: GoogleFonts.sora(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // FORM NAMA
              Text(
                "Nama",
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: controller.nameC,
                keyboardType: TextInputType.name,
                style: GoogleFonts.sora(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Masukkan nama pihak bersangkutan",
                  hintStyle: GoogleFonts.sora(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(AppColor.main),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // FORM JUMLAH
              Text(
                "Jumlah Transaksi",
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: controller.amountC,
                keyboardType: TextInputType.number,
                style: GoogleFonts.sora(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Masukkan jumlah uang",
                  hintStyle: GoogleFonts.sora(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  prefixIcon: const Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(AppColor.main),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // FORM TANGGAL TRANSAKSI
              Text(
                "Tanggal Transaksi",
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: controller.dateC,
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(AppColor.main),
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(AppColor.main),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    controller.selectedDate.value = picked;
                    controller.dateC.text = controller.dateFormat.format(
                      picked,
                    );
                  }
                },
                style: GoogleFonts.sora(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Pilih tanggal transaksi",
                  hintStyle: GoogleFonts.sora(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(AppColor.main),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // FORM JATUH TEMPO
              Text(
                "Tanggal Jatuh Tempo",
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: controller.dueDateC,
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(AppColor.main),
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(AppColor.main),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    controller.dueDate.value = picked;
                    controller.dueDateC.text = controller.dateFormat.format(
                      picked,
                    );
                  }
                },
                style: GoogleFonts.sora(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Pilih tanggal jatuh tempo",
                  hintStyle: GoogleFonts.sora(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(AppColor.main),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // FORM CATATAN
              Text(
                "Catatan",
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: controller.noteC,
                keyboardType: TextInputType.text,
                style: GoogleFonts.sora(fontSize: 14, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Masukkan Catatan (opsional)",
                  hintStyle: GoogleFonts.sora(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  prefixIcon: const Icon(Icons.notes, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(AppColor.main),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // BUTTON SIMPAN
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.addTransaction();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppColor.main),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Obx(
                    () => Text(
                      controller.isLoading.isFalse
                          ? "Tambah Transaksi"
                          : "Loading...",
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
