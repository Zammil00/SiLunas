import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_transaction_controller.dart';

class DetailTransactionView extends GetView<DetailTransactionController> {
  const DetailTransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailTransactionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailTransactionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
