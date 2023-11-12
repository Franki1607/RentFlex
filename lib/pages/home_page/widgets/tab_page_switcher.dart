import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dashboard_page/index.dart';

import '../../marketplace_page/index.dart';
import '../../profile_page/index.dart';
import '../../transaction_page/index.dart';
import '../controllers/home_controller.dart';

class TabPageSwitcher extends GetWidget<HomeController> {
  final List<Widget> _tabPages = [DashboardPage(), TransactionPage(), MarketplacePage(), ProfilePage()];
  TabPageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _tabPages[controller.tabIndex.value]);
  }
}
