import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/notifications_controller.dart';

class NotificationsPage extends GetWidget<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications".tr, style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: GetBuilder<NotificationsController>(
        builder: (_) => Center(
          child: Image.asset("images/no-data-min.png"),
        ),
      ));
  }
}
