import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionsController extends GetxController {
  // CONTROL BUTTOM BAR
  var bottomIndex = 1.obs;
  void setBottomIndex(int index) {
    bottomIndex.value = index;
  }

  // KITA GET DATA TRANSACTIONS DARI SUPABASE
  // define supabase client here
  final SupabaseClient client = Supabase.instance.client;

  // KITA BUAT LIST OBSERVABLE UNTUK MENAMPUNG DATA TRANSACTIONS
  RxList<Map<String, dynamic>> transactionsList = <Map<String, dynamic>>[].obs;

  // METHOD UNTUK FETCH DATA TRANSACTIONS DARI SUPABASE
  Future<void> getTransactions() async {
    // AMBIL UID USER YANG SEDANG LOGIN
    final uid = client.auth.currentUser!.id;

    // AMBIL DATA USER DARI UID YG SUDAH KITA DAPATKAN
    // DATA INI KITA GUNAKAN UNTUK MENDAPATKAN USER_ID YANG ADA DI TABEL USER_PROFILE
    final user = await client
        .from("user_profile")
        .select("id")
        .eq("uid", uid)
        .single();

    // SIMPAN DULU USER ID NYA
    final int userId = user['id'];

    // SETELAH DI DAPATKAN ID USER YG SEDANG LOGIN, KITA GUNAKAN ID INI UNTUK MENGAMBIL DATA TRANSACTIONS BERDASARKAN USER_ID
    final dataTransactions = await client
        .from("transactions")
        .select()
        .eq("user_id", userId);

    // SETELAH DAPAT DATA KITA SIMPAN KE DALAM LIST OBSERVABLE
    transactionsList.value = List<Map<String, dynamic>>.from(dataTransactions);

    print("Data Transactions: $transactionsList");
  }
}
