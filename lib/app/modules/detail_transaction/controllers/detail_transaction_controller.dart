import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailTransactionController extends GetxController {
  // DEFINISI SUPABASE CLIENT
  final SupabaseClient client = Supabase.instance.client;

  // SEBELUM GET DATA KITA BUAT LIST OBSERVABLE UNTUK MENAMPUNG DATA TRANSAKSI
  RxMap<String, dynamic> transactionDetail = <String, dynamic>{}.obs;

  // METHOD UNTUK MENDAPATKAN DETAIL TRANSAKSI BERDASARKAN ID
  Future<void> getTransactionById() async {
    // KITA TAMPUNG ID TRANSAKSI YANG KITA DAPATKAN DARI ARGUMENT
    final transaksiId = Get.arguments;

    // KITA AMBIL DATA USER YANG SEDANG LOGIN DULU NTUK KEAMANAN
    final uid = client.auth.currentUser!.id;

    // AMBIL DATA USER DARI UID YG SUDAH KITA DAPATKAN
    // DATA INI KITA GUNAKAN UNTUK MENDAPATKAN USER
    final user = await client
        .from("user_profile")
        .select("id")
        .eq("uid", uid)
        .single();

    // SIMPAN DULU USER ID NYA
    final int userId = user['id'];

    // SEKARANG KITA AMBIL DATA TRANSAKSI BERDASARKAN ID TRANSAKSI DAN USER_ID
    final dataTransaction = await client
        .from("transactions")
        .select()
        .eq("id", transaksiId)
        .eq("user_id", userId)
        .single();

    // SIMPAN DATA TRANSAKSI KE DALAM LIST OBSERVABLE
    transactionDetail.value = Map<String, dynamic>.from(dataTransaction);
    print("Detail Transaksi: $transactionDetail.value");
  }

  // SEKARNG KITA BUAT METHOD UNTUK MENGHAPUS TRANSAKSI
  // int id di dapatkan dari onpressed delete button di detail_transaction_view.dart
  Future<void> deleteTransaction(int id) async {
    try {
      final response = await client
          .from("transactions")
          .delete()
          .eq("id", id)
          .select();

      if (response.isNotEmpty) {
        Get.snackbar(
          "Berhasil",
          "Data transaksi berhasil dihapus",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.toNamed(Routes.TRANSACTIONS); // balik ke halaman sebelumnya
      } else {
        Get.snackbar(
          "Info",
          "Tidak ada data yang dihapus",
          colorText: Colors.white,
          backgroundColor: Colors.orange,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Gagal",
        "Terjadi kesalahan saat menghapus transaksi: $e",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error deleting transaction: $e");
    }
  }
}
