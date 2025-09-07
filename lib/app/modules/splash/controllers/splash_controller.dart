import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController extends GetxController {
  // DEFINISI SUPABASE CLIENT DULU
  final SupabaseClient client = Supabase.instance.client;

  void cekLogin() async {
    // TAMPUNG DATA USER YANG SEDANG LOGIN
    final user = client.auth.currentUser;

    if (user != null) {
      // JIKA ADA USER YANG SEDANG LOGIN
      // MAKA LANGSUNG KE HALAMAN HOME
      Get.offAllNamed("/home");
    } else {
      // JIKA TIDAK ADA USER YANG SEDANG LOGIN
      // MAKA KEMBALI KE HALAMAN LOGIN
      Get.offAllNamed("/login");
    }
  }
}
