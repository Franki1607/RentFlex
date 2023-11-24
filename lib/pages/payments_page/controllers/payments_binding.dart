import 'package:get/get.dart';
import 'payments_controller.dart';

class PaymentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentsController>(() => PaymentsController());
  }
}
