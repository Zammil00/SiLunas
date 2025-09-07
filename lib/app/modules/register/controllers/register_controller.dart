import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isHide = true.obs;
  RxBool isLoading = false.obs;

  // DEFINI SUPABASE CLIENT DULU
  final SupabaseClient client = Supabase.instance.client;

  // KITA BUAT FUNGSI REGISTER
  void register() async {
    // Defini variabel untuk menampung inputan user
    String name = nameC.text;
    String email = emailC.text;
    String pass = passC.text;

    // KITA BUAT VALIDASI SEDERHANA
    if (name.isEmpty || email.isEmpty || pass.isEmpty) {
      Get.snackbar(
        "MAAF YA",
        "Nama, Email, dan Password wajib diisi !",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // KALO TIDAK KOSONG, MAKA PROSES REGISTER
    isLoading.value = true; // MULAI LOADING

    try {
      // PROSES REGISTER MENGGUNAKAN SUPABASE
      // SIMPAN RESPONSE NYA
      final response = await client.auth.signUp(email: email, password: pass);

      final user = response.user;
      if (kDebugMode) {
        print(" USER NYA : $user ");
      }

      if (user != null) {
        // KOSONGKAN FIELD NYA
        nameC.clear();
        emailC.clear();
        passC.clear();

        isLoading.value = false; // SELESAI LOADING

        // KEMBALI KE HALAMAN LOGIN
        Get.offAllNamed(Routes.LOGIN);

        // JIKA BERHASIL
        Get.snackbar(
          "REGISTER BERHASIL",
          "Cek email kamu untuk verifikasi !",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }

      // KITA SIMPAN DATA USER KE TABLE "users" DI SUPABASE
      try {
        await client.from("user_profile").insert({
          "uid": user?.id,
          "name": name,
          "email": email,
          "created_at": DateTime.now().toIso8601String(),
        });
        if (kDebugMode) {
          print("DATA BERHASIL DI SIMPAN KE TABLE USER_PROFILE");
        }
      } catch (e) {
        if (kDebugMode) {
          print("GAGAL MENYIMPAN DATA USER KE TABLE USERS : $e");
        }
      }
    } catch (e) {
      // JIKA TERJADI ERROR
      Get.snackbar(
        "REGISTER GAGAL",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
