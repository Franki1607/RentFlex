import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController{
  final isInSplashScreen = false.obs;

  setIsInSplashScreen(bool value) {
    isInSplashScreen(value);
  }

  initApp() {
    setIsInSplashScreen(true);
    Future.delayed(Duration(seconds: 5), () {
      initLocale();
      // Get.offNamed('/onboarding');
      Get.offNamed('/');
    });
    setIsInSplashScreen(false);
  }

  initLocale() {
    GetStorage box = GetStorage();
    if (box.read('locale') != null)
      box.read('locale') == 'en_US'
          ? Get.updateLocale(Locale('fr', 'FR'))
          : Get.updateLocale(Locale('en', 'US'));
    else
      Get.updateLocale(Locale('fr', 'FR'));
  }

  void navigateBack() => Get.back();
}