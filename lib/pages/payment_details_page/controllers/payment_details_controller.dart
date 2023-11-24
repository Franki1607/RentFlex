import 'package:get/get.dart';
import 'package:rent_flex/models/property.dart';

import '../../../api/firebase/firebase_core.dart';
import '../../../models/payment.dart';

class PaymentDetailsController extends GetxController {
  FirebaseCore firebaseCore = FirebaseCore.instance;

  late Property property;
  late Payment payment;

  List months = [
    "january".tr,
    "february".tr,
    "march".tr,
    "april".tr,
    "may".tr,
    "june".tr,
    "july".tr,
    "august".tr,
    "september".tr,
    "october".tr,
    "november".tr,
    "december".tr
  ];

  @override
  void onInit() {
    payment = Get.arguments[0];
    property = Get.arguments[1];

    // uid= Get.arguments[0];
    // propertyName= Get.arguments[1];
    // contractId= Get.arguments[2];

    super.onInit();
  }
  void navigateBack() => Get.back();
}
