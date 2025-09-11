import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTransactionsController extends GetxController {
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
}
