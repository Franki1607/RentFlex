import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/splash_controller.dart';
class SplashPage extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<SplashController>(
          init: controller.initApp(),
          builder: (_) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Ceci est un splash screen personalisable"),
              ],
            )
          ),
        )
    );
  }
}