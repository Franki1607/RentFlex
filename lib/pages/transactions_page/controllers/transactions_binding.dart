import 'package:get/get.dart';
import 'transactions_controller.dart';

class TransactionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsController>(() => TransactionsController());
  }
}
