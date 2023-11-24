import 'dart:ffi';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../controllers/home_controller.dart';


class BottomTabsNavigator extends GetWidget<HomeController> {
  const BottomTabsNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 9,
        child: Container(
          height: 75.0,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(defaultRadius*2)),
            child: Obx(() {
              return BottomNavigationBar(
                unselectedItemColor: Theme.of(context).unselectedWidgetColor,
                selectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                backgroundColor: greyColor,
                elevation: 8.0,
                currentIndex: controller.tabIndex.value,
                items: [
                  BottomNavigationBarItem(
                      activeIcon: controller.buildIcon(BootstrapIcons.house_gear_fill, isActive: true),
                      icon: controller.buildIcon(BootstrapIcons.house_gear),
                      label: 'home'.tr
                  ),
                  BottomNavigationBarItem(
                      activeIcon: controller.buildIcon(BootstrapIcons.wallet_fill, isActive: true),
                      icon: controller.buildIcon(BootstrapIcons.wallet),
                      label: 'payments'.tr
                  ),
                  BottomNavigationBarItem(
                      activeIcon: controller.buildIcon(BootstrapIcons.houses_fill, isActive: true),
                      icon: controller.buildIcon(BootstrapIcons.houses),
                      label: 'Marketplace'.tr
                  ),
                  BottomNavigationBarItem(
                      activeIcon: controller.buildIcon(BootstrapIcons.person_fill, isActive: true),
                      icon: controller.buildIcon(BootstrapIcons.person),
                      label: 'profile'.tr
                  ),
                ],
                onTap: (index) {
                  controller.setTabIndex(index);
                },
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              );
            }),
          ),
        ).paddingOnly(left: 16, right: 16, bottom: 10)
    );
  }
}
