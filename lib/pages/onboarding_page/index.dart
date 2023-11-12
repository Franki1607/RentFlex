import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:rent_flex/constants.dart';
import 'controllers/onboarding_controller.dart';

class OnboardingPage extends GetWidget<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<OnboardingController>(
          builder: (_) =>
              Scaffold(
                body: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Obx(() {
                      return Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height,
                            child: PageView(
                              physics: ClampingScrollPhysics(),
                              controller: controller.pageController,
                              onPageChanged: (int page) {
                                controller.setCurrentPage(page);
                              },
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: defaultPadding*2, bottom: defaultPadding, left: defaultPadding, right: defaultPadding
                                          ),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("1/3",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16 ),),

                                                TextButton(onPressed: (){
                                                  controller.skipPage();
                                                }, child: Text("skip".tr, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, color: primaryColor)))
                                              ]
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: FractionalOffset.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Image(
                                              image: NetworkImage(
                                                  'https://res.cloudinary.com/dfng74ru6/image/upload/v1699694159/onbording1_etps6f.png'),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: defaultHeight),
                                            Text(
                                              'onboarding1_title'.tr,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: defaultHeight),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              child: Text(
                                                "onboarding1_desc".tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: defaultPadding*2, bottom: defaultPadding, left: defaultPadding, right: defaultPadding
                                          ),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("2/3",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16 ),),

                                                TextButton(onPressed: (){
                                                  controller.skipPage();
                                                }, child: Text("skip".tr, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, color: primaryColor)))
                                              ]
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: FractionalOffset.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Image(
                                              image: NetworkImage(
                                                  'https://res.cloudinary.com/dfng74ru6/image/upload/v1699694159/onbording2_pyl2eq.png'),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: defaultHeight),
                                            Text(
                                              'onboarding2_title'.tr,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: defaultHeight),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              child: Text(
                                                "onboarding2_desc".tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: defaultPadding*2, bottom: defaultPadding, left: defaultPadding, right: defaultPadding
                                          ),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("3/3",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16 ),),

                                                TextButton(onPressed: (){}, child: Text("", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, color: primaryColor)))
                                              ]
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: FractionalOffset.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Image(
                                              image: NetworkImage(
                                                  'https://res.cloudinary.com/dfng74ru6/image/upload/v1699694159/onbording3_yh4gcz.png'),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: defaultHeight),
                                            Text(
                                              'onboarding3_title'.tr,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: defaultHeight),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              child: Text(
                                                "onboarding3_desc".tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 470.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 150),
                                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                                    height: 5.0,
                                    width: controller.currentPage==0 ? 24.0 : 16.0,
                                    decoration: BoxDecoration(
                                      color: controller.currentPage==0 ? primaryColor : Colors.black26,
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                    ),
                                  ),

                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 150),
                                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                                    height: 5.0,
                                    width: controller.currentPage==1 ? 24.0 : 16.0,
                                    decoration: BoxDecoration(
                                      color: controller.currentPage==1 ? primaryColor : Colors.black26,
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 150),
                                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                                    height: 5.0,
                                    width: controller.currentPage==2 ? 24.0 : 16.0,
                                    decoration: BoxDecoration(
                                      color: controller.currentPage==2 ? primaryColor : Colors.black26,
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          controller.currentPage.value == 2
                              ? Align(
                            alignment: FractionalOffset.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: defaultPadding, right: defaultPadding, left: defaultPadding),
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: primaryColor,
                                ),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      primary: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      Get.toNamed('/login');
                                    },
                                    child: Center(
                                        child: Text(
                                          "next".tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1.5),
                                        ))),
                              ),
                            ),
                          )
                              : Text(''),
                        ],
                      );
                    }),
                  ),
                ),
              ),
        ));
  }
}
