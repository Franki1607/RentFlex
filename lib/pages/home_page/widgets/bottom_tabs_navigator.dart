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
                unselectedItemColor: Color(0xFF989BA1),
                selectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                backgroundColor:greyColor,

                elevation: 1.0,
                currentIndex: controller.tabIndex.value,
                items: [
                  BottomNavigationBarItem(
                      activeIcon: Icon(BootstrapIcons.pie_chart_fill, color: primaryColor,),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Opacity(
                          opacity: 0.7,
                          child: Icon(BootstrapIcons.pie_chart),
                        ),
                      ),
                      label: 'dashboard'
                  ),
                  BottomNavigationBarItem(
                      activeIcon: Icon(
                        BootstrapIcons.clipboard_data_fill, color: primaryColor,),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Opacity(
                          opacity: 0.7,
                          child: Icon(BootstrapIcons.clipboard_data),
                        ),
                      ),
                      label: 'Transactions'),
                  BottomNavigationBarItem(
                      activeIcon: Icon(
                        BootstrapIcons.houses_fill, color: primaryColor,),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Opacity(
                          opacity: 0.7,
                          child: Icon(BootstrapIcons.houses),
                        ),
                      ),
                      label: 'Marketplace'),
                  BottomNavigationBarItem(
                      activeIcon: Icon(BootstrapIcons.person_fill, color: primaryColor,),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Opacity(
                          opacity: 0.7,
                          child: Icon(BootstrapIcons.person),
                        ),
                      ),
                      label: 'Profile'),
                ],
                onTap: (index) {
                  controller.setTabIndex(index);
                },
              );
            }),
          ))
          .paddingOnly(left: 16, right: 16, bottom: 10)
    );
  }
}
