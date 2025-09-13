import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    final transaksiId = Get.arguments;
    final uid = client.auth.currentUser!.id;

    final user = await client
        .from("user_profile")
        .select("id")
        .eq("uid", uid)
        .single();

    final int userId = user['id'];

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

    print("Detail Transaksi: $transactionDetail");
  }
}
