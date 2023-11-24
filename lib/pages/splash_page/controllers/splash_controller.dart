import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/api/firebase/firebase_core.dart';

class SplashController extends GetxController{
  final isInSplashScreen = false.obs;

  setIsInSplashScreen(bool value) {
    isInSplashScreen(value);
  }

  initApp() {
    setIsInSplashScreen(true);
    Future.delayed(Duration(seconds: 5), () {
      initLocale();
      if (FirebaseCore.instance.firebaseUser != null){
        Get.offAllNamed('/');
      }else
        Get.offNamed('/onboarding');
      // Get.offNamed('/');
    });
    setIsInSplashScreen(false);
  }

  initLocale() {
    GetStorage box = GetStorage();
    if (box.read('locale') != null)
      box.read('locale') == 'en_US'
          ? Get.updateLocale(Locale('en', 'US'))
          : Get.updateLocale(Locale('fr', 'FR'));
    else
      Get.updateLocale(Locale('fr', 'FR')); box.write('locale', 'fr_FR');
  }

  void navigateBack() => Get.back();
}