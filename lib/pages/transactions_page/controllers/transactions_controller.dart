import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../api/firebase/firebase_core.dart';
import '../../../models/property.dart';

class TransactionsController extends GetxController {
  FirebaseCore firebaseCore = FirebaseCore.instance;

  late StreamSubscription<List<Property>> subscription;

  final formKey = GlobalKey<FormBuilderState>();

  RxList<Property> properties =RxList([]);

  final isSaveLoading = false.obs;

  void setSaveLoading(bool value) {
    isSaveLoading(value);
  }

  void setProperties(List<Property> value) {
    properties(value);
  }

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
  void onInit() async {
    // TODO: implement onInit
    super.onInit();


    subscription = await firebaseCore.getAllPropertiesStream().listen((event) {
      setProperties(event);
      update();
    });

  }

  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void navigateBack() => Get.back();
}
