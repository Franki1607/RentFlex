import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/bottom_tabs_navigator.dart';
import 'widgets/tab_page_switcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabPageSwitcher(),
          BottomTabsNavigator(),
        ],
      ),
      // bottomNavigationBar: BottomTabsNavigator(),
    );
  }
}
