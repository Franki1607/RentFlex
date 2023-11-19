import 'package:get/get.dart';
import 'estates_controller.dart';

class EstatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EstatesController>(() => EstatesController());
  }
}
