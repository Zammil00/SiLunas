import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:si_lunas/app/routes/app_pages.dart';
import 'package:si_lunas/core/color/app_color.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditTransactionController extends GetxController {
  // DEFINISI SUPABASE CLIENT
  final SupabaseClient client = Supabase.instance.client;

  // STATE LOADING
  RxBool isLoading = false.obs;

  // KIAT MANAGE STATE MENGGUNAKAN GETX
  RxInt typeT = 1.obs;

  // UNTUK TANGGAL TRANSAKSI
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // UNTUK TANGGAL JATUH TEMPO
  Rx<DateTime?> dueDate = Rx<DateTime?>(null);

  // KIATA BUAT DATE FORMAT
  final DateFormat dateFormat = DateFormat("d MMM yyyy"); // contoh:

  // TETXT EDITING CONTROLLER
  TextEditingController nameC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController dueDateC = TextEditingController();
  TextEditingController noteC = TextEditingController();

  // KITA BUAT LIST OBSERVABLE UNTUK MENAMPUNG DATA TRANSAKSI
  RxMap<String, dynamic> transactionDetail = <String, dynamic>{}.obs;

  // METHOD UNTUK MENGAMBIL DETAIL TRANSAKSI BERDASARKAN ID
  // KEMUDIAN DI TAMPILKAN KE HINT TEXT FORM FIELD
  Future<void> getTransactionById() async {
    // TAMPUNG ID TRANSAKSI DARI ARGUMENT
    final transaksiId = Get.arguments;

    // AMBIL DATA UID USER YANG SEDANG LOGIN
    final uid = client.auth.currentUser!.id;

    // SETELAH DAPAT UID, KITA AMBIL DATA USERNYA
    final user = await client
        .from("user_profile")
        .select("id")
        .eq("uid", uid)
        .single();

    // SETELAH DAPAT USER, KITA SIMPAN USER ID NYA
    final int userId = user['id'];

    // SETELAH DAPAT ID TRANSAKSI DAN USER ID, KITA AMBIL DATA TRANSAKSI
    final dataTransaction = await client
        .from("transactions")
        .select()
        .eq("id", transaksiId)
        .eq("user_id", userId)
        .single();

    transactionDetail.value = Map<String, dynamic>.from(dataTransaction);

    // ✅ Mapping field type ke typeT
    if (transactionDetail['type'] == "Utang") {
      typeT.value = 1;
    } else if (transactionDetail['type'] == "Piutang") {
      typeT.value = 0;
    }

    // ✅ isi controller text juga biar langsung muncul
    nameC.text = transactionDetail['name'] ?? '';
    amountC.text = transactionDetail['amount'] != null
        ? transactionDetail['amount'].toString()
        : '';
    noteC.text = transactionDetail['note'] ?? '';
    dateC.text = transactionDetail['date'] ?? '';
    dueDateC.text = transactionDetail['due_date'] ?? '';
  }

  // METHOD UNTUK UPDATE TRANSAKSI
  // ID didapat dari Get.arguments
  Future<void> updateTransaction() async {
    // TENTU AMBIL ID TRANSAKSI DULU DARI ARGUMENT
    final transaksiId = Get.arguments;

    // KITA AMBIL UID USER YANG SEDANG LOGIN
    final uid = client.auth.currentUser!.id;

    // SETELAH DAPAT UID, KITA AMBIL DATA USERNYA
    final user = await client
        .from("user_profile")
        .select("id")
        .eq("uid", uid)
        .single();

    // SETELAH DAPAT USER, KITA SIMPAN USER ID NYA
    final int userId = user["id"];

    // MAPPING TYPE TOOGLE KE STRING
    final typeF = typeT.value == 1 ? "Utang" : "Piutang";

    // LANSUNG DALAM PROSES UPDATE DATA
    try {
      await client
          .from("transactions")
          .update({
            "name": nameC.text,
            "amount": int.tryParse(amountC.text) ?? 0,
            "note": noteC.text,
          })
          .eq("id", transaksiId)
          .eq("user_id", userId);

      Get.toNamed(Routes.DETAIL_TRANSACTION);
      Get.snackbar(
        "Berhasil",
        "Data Anda Sudah Di Update",
        colorText: Colors.black54,
        backgroundColor: Color(AppColor.secondary),
      );
    } catch (e) {
      Get.snackbar('Hi', 'i am a modern snackbar');
    }
  }
}
