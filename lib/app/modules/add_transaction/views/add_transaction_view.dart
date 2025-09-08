import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_transaction_controller.dart';

class AddTransactionView extends GetView<AddTransactionController> {
  const AddTransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTransactionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddTransactionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
