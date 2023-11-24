import 'package:get/get.dart';
import 'invoice_controller.dart';

class InvoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceController>(() => InvoiceController());
  }
}
