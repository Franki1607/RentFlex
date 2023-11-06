import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'controllers/onboarding_controller.dart';

class OnboardingPage extends GetWidget<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<OnboardingController>(
          builder: (_) => Scaffold(
            body: IntroViewsFlutter(
              controller.pages,
              pageButtonsColor: Colors.black45,
              skipText: Text(
                "skip".tr,
              ),
              doneText: Text(
                "done".tr,
              ),
              onTapDoneButton: () async {
                Get.offNamed("/login");
              },
              onTapSkipButton: () {
                Get.offNamed("/login");
              },
            ),
          ),
        ));
  }
}
