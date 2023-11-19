import 'package:get/get.dart';
import 'contracts_controller.dart';

class ContractsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractsController>(() => ContractsController());
  }
}
