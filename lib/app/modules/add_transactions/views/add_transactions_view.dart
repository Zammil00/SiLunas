import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_transactions_controller.dart';

class AddTransactionsView extends GetView<AddTransactionsController> {
  const AddTransactionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTransactionsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddTransactionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
