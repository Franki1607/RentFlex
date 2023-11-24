import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../api/firebase/firebase_core.dart';
import '../../../models/property.dart';

class InvoiceController extends GetxController {
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

  // void saveContract() async{
  //   isSaveLoading(true);
  //   try{
  //     int result = await firebaseCore.createContract(
  //         new Contract(
  //             uid: Uuid().v4(),
  //             ownerId: "${firebaseCore.firebaseUser?.uid}",
  //             propertyId: formKey.currentState?.fields['propertyId']?.value,
  //             tenantNumber1: "+229"+formKey.currentState?.fields['tenantNumber1']?.value,
  //             ownerNumber: firebaseCore.firebaseUser!.phoneNumber??"",
  //             startPaiementDate: formKey.currentState?.fields['startPaiementDate']?.value,
  //             isActive: true
  //         )
  //     );
  //     print(result);
  //     if (result == -1){
  //       Get.back();
  //       Get.showSnackbar(GetSnackBar(
  //         title: 'Error'.tr,
  //         message: "active_contract".tr,
  //         icon: Icon(Icons.error, color: Colors.orange),
  //         duration: Duration(seconds: 2),
  //       ));
  //     }else{
  //       Get.back();
  //     }
  //     isSaveLoading(false);
  //   }catch(e){
  //     print(e);
  //     Get.showSnackbar(GetSnackBar(
  //       title: 'Error',
  //       message: 'Please try again',
  //       icon: Icon(Icons.error, color: Colors.red),
  //       duration: Duration(seconds: 2),
  //     ));
  //     isSaveLoading(false);
  //   }
  // }

  String getPropertyName(String propertyId) {
    try {
      return properties.firstWhere((element) => element.uid == propertyId).name;
    }catch (e) {
      return "...";
    }
  }
  void navigateBack() => Get.back();
}
