import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class OnboardingController extends GetxController {
  void navigateBack() => Get.back();

  final PageController pageController = PageController(initialPage: 0);

  final currentPage = 0.obs;

  void setCurrentPage(int page) => currentPage.value = page;

  void skipPage() {
    pageController.jumpToPage(
      2
    );
  }
}
