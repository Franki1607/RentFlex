import 'package:get/get.dart';

class HomeController extends GetxController{
  final tabIndex = 0.obs;

  setTabIndex(int value) {
    tabIndex(value);
  }
  void navigateBack() => Get.back();
}