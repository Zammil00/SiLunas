import 'package:get/get.dart';

class TransactionModel {
  final int jenis; // 1 = Hutang, 2 = Piutang
  final String nama;
  final String nominal;
  final String keterangan;

  TransactionModel({
    required this.jenis,
    required this.nama,
    required this.nominal,
    required this.keterangan,
  });
}

class TransactionsController extends GetxController {
  // CONTROL BUTTOM BAR
  var bottomIndex = 1.obs;
  void setBottomIndex(int index) {
    bottomIndex.value = index;
  }

  /// tab menu aktif
  var selectedMenu = 1.obs; // 1 = Hutang, 2 = Piutang

  /// daftar transaksi
  var transactions = <TransactionModel>[].obs;

  /// ganti tab menu
  void setMenu(int menu) {
    selectedMenu.value = menu;
  }

  /// tambah transaksi baru
  void addTransaction(int jenis, String nama, String nominal, String ket) {
    final trx = TransactionModel(
      jenis: jenis,
      nama: nama,
      nominal: nominal,
      keterangan: ket,
    );
    transactions.add(trx);
  }

  /// ambil transaksi sesuai tab aktif
  List<TransactionModel> get currentTransactions {
    return transactions.where((t) => t.jenis == selectedMenu.value).toList();
  }
}
