import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'controllers/dashboard_controller.dart';

class DashboardPage extends GetWidget<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<DashboardController>(
          builder: (_) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding:
                          EdgeInsets.only(top: defaultPadding*2,right: defaultPadding, left: defaultPadding),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    text: "Hello,\n",
                                    style: TextStyle(
                                        color: Colors.black,fontSize: 17.0),
                                    children: [
                                      TextSpan(
                                        text: "Brestley Hadwey",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19.0,
                                          height: 1.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(Radius.circular(150))),
                                ),
                              ],
                            ),
                          )
                      )
                  ),
                ],
              )
          ),
        )
    );
  }
}
