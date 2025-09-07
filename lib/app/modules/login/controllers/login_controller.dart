import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  // DEFINISI CONTROLLER UNTUK MENGAMBIL DATA DARI TEXTFIELD
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isHide = true.obs;
  RxBool isLoading = false.obs;

  // LANGKAH AWAL INIT SUPABASECLIENT
  final SupabaseClient client = Supabase.instance.client;

  // KITA BUAT FUNGSI LOGIN
  void login() async {
    // DEFINI VARIABEL UNTUK MENAMPUNG INPUTAN USER
    String email = emailC.text.trim();
    String pass = passC.text.trim();

    // VALIDASI JIKA EMAIL DAN PASSWORD TIDAK BOLEH KOSONG
    if (emailC.text.isEmpty || passC.text.isEmpty) {
      Get.snackbar(
        "MAAF YA",
        "Email dan Password tidak boleh kosong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // JIKA PASSWORD DAN EMAIL TIDAK KOSONG, MAKA PROSES LOGIN

    // MULAI LOADING
    isLoading.value = true;

    // LANGUSNG PROSES LOGIN MENGGUNAKAN SUPABASE SIGININWITHPASSWORD

    try {
      // INI PROSES LOGINNYA
      final AuthResponse res = await client.auth.signInWithPassword(
        email: email,
        password: pass,
      );

      // KITA AMBIL DATA USER NYA
      final session = res.session;
      final user = res.user;

      if (kDebugMode) {
        print(" SESSION NYA : $session ");
      }
      if (kDebugMode) {
        print(" USER NYA : $user ");
      }

      if (session != null || user != null) {
        Get.offAllNamed(Routes.HOME);

        Get.snackbar(
          "YEAY",
          "Login Berhasil, Selamat datang ${user!.email}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isLoading.value = false; // SELESAI LOADING
      }
    } catch (e) {
      if (e is AuthException) {
        // JIKA TERJADI ERROR SAAT LOGIN
        Get.snackbar(
          "MAAF YA",
          e.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "MAAF YA",
          "Terjadi kesalahan tak terduga",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      isLoading.value = false; // SELESAI LOADING
      return;
    }
  }
}
