import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/transaction_controller.dart';

class TransactionPage extends GetWidget<TransactionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<TransactionController>(
          builder: (_) => Placeholder(),
        ));
  }
}
