import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/profile_controller.dart';

class ProfilePage extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileController>(
          builder: (_) => Placeholder(),
        ));
  }
}
