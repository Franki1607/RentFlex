import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/marketplace_controller.dart';

class MarketplacePage extends GetWidget<MarketplaceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<MarketplaceController>(
          builder: (_) => Placeholder(),
        ));
  }
}
