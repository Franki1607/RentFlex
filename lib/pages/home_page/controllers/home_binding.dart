import 'package:get/get.dart';
import 'package:rent_flex/pages/dashboard_page/controllers/dashboard_controller.dart';
import 'package:rent_flex/pages/payments_page/controllers/payments_controller.dart';
import 'package:rent_flex/pages/profile_page/controllers/profile_controller.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<PaymentsController>(() => PaymentsController());
  }
}