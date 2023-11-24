import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../api/firebase/firebase_core.dart';
import '../../../models/property.dart';

class DashboardController extends GetxController {
  void navigateBack() => Get.back();

  final formKey = GlobalKey<FormBuilderState>();

  FirebaseCore firebaseCore = FirebaseCore.instance;

  late StreamSubscription<List<Property>> subscription;

  RxList<Property> properties =RxList([]);

  final isSaveLoading = false.obs;

  final useAnotherNumber = false.obs;

  void setUseAnotherNumber(bool value) => useAnotherNumber(value);

  final minAmount = 1000.0.obs;

  void setMinAmount(double value) => minAmount(value);

  bool checkBestMonth(DateTime month1 , DateTime month2){
    if (month1.year == month2.year && month1.month>=month2.month) {
      return true;
    }else if (month1.year > month2.year) {
      return true;
    }else{
      return false;

    }
  }

  int checkDifferenceMonth(DateTime month1 , DateTime month2){
    int years = month1.year-month2.year;
    int months = month1.month-month2.month;

    if (months < 0) {
      years--;
      months = 12+months;
    }

    return years*12+months;
  }

  DateTime subtractMonths(DateTime date, int months) {
    if (date.month - months < 1) {
      return DateTime(date.year - 1, 12 + date.month - months);
    } else {
      return DateTime(date.year, date.month - months);
    }
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
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    subscription = await firebaseCore.getAllPropertiesStream().listen((event) {
      setProperties(event);
      update();
    });
  }

  void onDestroy() {
    subscription.cancel();
  }

  void onDispose() {
    subscription.cancel();
  }

  void setSaveLoading(bool value) {
    isSaveLoading(value);
  }

  void setProperties(List<Property> value) {
    properties(value);
  }

}
