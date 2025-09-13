import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_transaction_controller.dart';

class EditTransactionView extends GetView<EditTransactionController> {
  const EditTransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditTransactionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditTransactionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
