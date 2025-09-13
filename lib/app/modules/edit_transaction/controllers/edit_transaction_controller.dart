import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditTransactionController extends GetxController {
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
}
