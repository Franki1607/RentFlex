import 'package:get/get.dart';
import 'payment_details_controller.dart';

class PaymentDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentDetailsController>(() => PaymentDetailsController());
  }
}
