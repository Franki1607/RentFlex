import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../api/firebase/firebase_core.dart';
import '../widgets/select_language_modal.dart';

class ProfileController extends GetxController {
  FirebaseCore firebaseCore = FirebaseCore.instance;

  changeLanguage() {
    Get.bottomSheet(SelectLanguageModal());
  }

  updateLocale(Locale locale) {
    print('${locale.languageCode}_${locale.countryCode}');
    GetStorage box = GetStorage();
    box.write('locale', '${locale.languageCode}_${locale.countryCode}');
    Get.updateLocale(locale);
    Get.back();
  }

  void navigateBack() => Get.back();
}
