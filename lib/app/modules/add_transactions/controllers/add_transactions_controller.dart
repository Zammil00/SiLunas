import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddTransactionsController extends GetxController {
  // Ntuk Select Type Transaksi
  RxInt typeT = 1.obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController amountC = TextEditingController();

  // untuk tanggal transaksi
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  TextEditingController dateC = TextEditingController();

  // Untuk Tanggal Jatuh Tempo
  Rx<DateTime?> dueDate = Rx<DateTime?>(null);
  TextEditingController dueDateC = TextEditingController();
}
