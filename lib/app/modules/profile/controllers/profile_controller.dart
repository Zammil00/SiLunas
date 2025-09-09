import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  // CONTROL BUTTOM BAR
  var bottomIndex = 2.obs;
  void setBottomIndex(int index) {
    bottomIndex.value = index;
  }

  // PRIFILE CONTROLER
  // KONEK KE SUPABSE DULU AMBIL DATA PROFILE NYA

  // INSTANCE SUPABASE DULU DENGAN NAMA client
  SupabaseClient client = Supabase.instance.client;

  // DEFINISI VAR DATA NYA
  RxString nama = "".obs;
  RxString email = "".obs;

  // SEKARNG GET DATA DARI SUPABASE NYA
  // GET NYA PAKE FUTERE

  Future<void> getData() async {
    // KASIH VAR FINAL
    // GET DATA AWAIT LANGSUNG
    final dataProfile = await client.from("user_profile").select().match({
      "uid": client.auth.currentUser!.id,
    }).single();

    // SEKARANG KITA TAMPUNG DATA HASIL GETDATA NYA
    nama.value = dataProfile['name'];
    email.value = dataProfile['email'];

    print("DATA DARI SUPABASE $dataProfile");

    print(nama.value);
    print(email.value);
  }

  // FUNGSI LOGOUT
  void logout() async {
    // AWAIT LOGOUT KE SUPABASE
    await client.auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar(
      "Berhasil",
      "Akun Anda Sudah Logout",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
