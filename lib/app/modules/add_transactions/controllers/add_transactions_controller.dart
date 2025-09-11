import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransactionsController extends GetxController {
  // KONTROL BUTTON LOADING DAN GA NYA LOADING
  RxBool isLoading = false.obs;

  // Ntuk Select Type Transaksi
  RxInt typeT = 1.obs;

  // untuk tanggal transaksi
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  // Untuk Tanggal Jatuh Tempo
  Rx<DateTime?> dueDate = Rx<DateTime?>(null);

  // DATE FORMAT
  final DateFormat dateFormat = DateFormat("d MMM yyyy"); // contoh: 10 Sep 2025

  TextEditingController nameC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController dueDateC = TextEditingController();
  TextEditingController noteC = TextEditingController();
  // SEKARANG PROSES INSERT KE DATABASE

  // DEFINE DULU SUPABSSENYA
  SupabaseClient client = Supabase.instance.client;

  // LANGSUNG BUAT FUNGSI INSERTNYA
  Future<void> addTransaction() async {
    // AKTIFKAN IS LOADING
    isLoading.value = true;
    // AMBIL UID DULU
    final uid = client.auth.currentUser!.id;

    // AMBIL ID USERNYA DARI UID DI ATAS
    final user = await client
        .from("user_profile")
        .select("id")
        .eq("uid", uid)
        .single();

    // SIMPAN DULU USER ID NYA
    final int userId = user['id'];

    // SEBELUM INSERT KITA VALIDASI DULU
    if (nameC.text.isEmpty ||
        amountC.text.isEmpty ||
        selectedDate.value == null ||
        dueDate.value == null) {
      Get.snackbar(
        "Error",
        "Nama, Jumlah, Tanggal Transaksi, dan Tanggal Jatuh Tempo wajib diisi",
        backgroundColor: const Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
      );
      return;
    }
    try {
      // BILAH DULU TYPENYA
      final typeF = typeT.value == 1 ? "Utang" : "Piutang";
      // PROSES INSERT KITA PAKE RESPON DEF
      final response = await client.from("transactions").insert({
        "user_id": userId,
        "type": typeF,
        "name": nameC.text,
        "amount": int.parse(amountC.text),
        "date": selectedDate.value!.toIso8601String().split('T').first,
        "due_date": dueDate.value!.toIso8601String().split('T').first,
        "note": noteC.text,
        "status": "Belum Lunas",
        "created_at": DateTime.now().toIso8601String(),
      }).select();

      // KALAU ADA RESPON INSERT NYA
      if (response.isNotEmpty) {
        nameC.clear();
        amountC.clear();
        dateC.clear();
        dueDateC.clear();
        noteC.clear();
        typeT.value = 1;
        selectedDate.value = null;

        print(" Response Insert: $response");

        isLoading.value = false;

        Get.snackbar(
          'Berhasil',
          'Data Transaksi Berhasil Ditambahkan',
          backgroundColor: const Color(0xFF00FF00),
          colorText: const Color(0xFFFFFFFF),
        );

        // KEMBALI KE HALAMAN SEBELUMNYA
        Get.toNamed(Routes.TRANSACTIONS);
      }
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Data Gagal Ditambahkan: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
      );
      print("error bree ======== $e");
    }
  }
}
