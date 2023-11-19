import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/contracts_controller.dart';

class ContractsPage extends GetWidget<ContractsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ContractsController>(
          builder: (_) => Placeholder(),
        ));
  }
}
