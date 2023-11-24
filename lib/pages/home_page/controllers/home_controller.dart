import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final tabIndex = 0.obs;

  setTabIndex(int value) {
    tabIndex(value);
  }

  Padding buildIcon(IconData icon, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Opacity(
        opacity: isActive ? 1.0 : 0.7,
        child: Icon(icon),
      ),
    );
  }
  void navigateBack() => Get.back();
}