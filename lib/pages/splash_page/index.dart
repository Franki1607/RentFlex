import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_flex/constants.dart';

import 'controllers/splash_controller.dart';
class SplashPage extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: GetBuilder<SplashController>(
          init: controller.initApp(),
          builder: (_) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 9,
                    child: Center(
                        child: Image.asset("images/logo_white.png")
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("sponsored_by".tr, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w100),),
                          Padding(
                            padding: const EdgeInsets.only(left: defaultPadding/2),
                            child: Image.asset("images/logo_mtn.png"),
                          )
                        ],
                      ),
                    ))
                )
              ],
            ),
          ),
        )
    );
  }
}