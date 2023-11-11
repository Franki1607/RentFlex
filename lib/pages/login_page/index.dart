import 'package:animate_do/animate_do.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_flex/constants.dart';
import 'package:rent_flex/pages/login_page/forms/phone_number_form.dart';
import 'controllers/login_controller.dart';
import 'forms/more_info_form.dart';
import 'forms/otp_form.dart';

class LoginPage extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
          builder: (_) =>
              Obx(() {
                return SingleChildScrollView(
                  child: controller.isNewUser.value
                      ? MoreInfoForm()
                      : Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      width: double.infinity,
                      child: Obx(() {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 250,
                              child: Image.network(
                                'https://res.cloudinary.com/dfng74ru6/image/upload/v1699697317/otp_qrzly4.png',
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            FadeInDown(
                                duration: Duration(milliseconds: 500),
                                child: Text(
                                  "otp_login".tr,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            if(!controller.canWriteCode.value)
                              FadeInDown(
                                delay: Duration(milliseconds: 500),
                                duration: Duration(milliseconds: 500),
                                child: Text(
                                  "enter_your_phone_number".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade500,
                                      height: 1.5),
                                ),
                              ),
                            if(controller.canWriteCode.value)
                              FadeInDown(
                                delay: Duration(milliseconds: 500),
                                duration: Duration(milliseconds: 500),
                                child: Text(
                                  "code_sent_at".tr + "\n " +
                                      controller.phone.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade500,
                                      height: 1.5),
                                ),
                              ),

                            if(!controller.canWriteCode.value)
                              SizedBox(
                                height: 30,
                              ),
                            if(!controller.canWriteCode.value)
                              FadeInDown(
                                delay: Duration(milliseconds: 600),
                                duration: Duration(milliseconds: 500),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: PhoneNumberForm(),
                                  ),
                                ),
                              ),

                            if(controller.canWriteCode.value)
                              SizedBox(
                                height: 30,
                              ),
                            if(controller.canWriteCode.value)
                              FadeInDown(
                                delay: Duration(milliseconds: 600),
                                duration: Duration(milliseconds: 500),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: OtpForm(),
                                  ),
                                ),
                              ),
                            if(controller.canWriteCode.value)
                              FadeInDown(
                                delay: Duration(milliseconds: 700),
                                duration: Duration(milliseconds: 500),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "code_not_received".tr,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade500),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          if (controller.canResendCode.value) {
                                            controller.sendOtp(isResend: true);
                                          }
                                        },
                                        child: Text(
                                          !controller.canResendCode.value
                                              ? "try_again_in".tr + " " +
                                              controller.retryCount.toString()
                                              : "resend_code".tr,
                                          style: TextStyle(
                                              color: primaryColor),

                                        )
                                    )
                                  ],
                                ),
                              ),
                            if(controller.canWriteCode.value)
                              FadeInDown(
                                delay: Duration(milliseconds: 700),
                                duration: Duration(milliseconds: 500),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          if (controller.canResendCode.value) {
                                            controller.canWriteCode.value =
                                            false;
                                            controller.setLoading(false);
                                          }
                                        },
                                        child: Text("back".tr,
                                          style: TextStyle(color: Colors.black),

                                        )
                                    )
                                  ],
                                ),
                              ),
                            if(!controller.canWriteCode.value)
                              SizedBox(
                                height: 50,
                              ),
                            if(!controller.canWriteCode.value)
                              FadeInDown(
                                delay: Duration(milliseconds: 800),
                                duration: Duration(milliseconds: 500),
                                child: MaterialButton(
                                  elevation: 0,
                                  onPressed: () async {
                                    controller.sendOtp();
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: primaryColor,
                                  minWidth: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.8,
                                  height: 50,
                                  child: controller.isLoading.value
                                      ? Center(child: SizedBox(width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(color: Colors.white,)),)
                                      : Text(
                                    "send_code".tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            if(controller.canWriteCode.value)
                              SizedBox(
                                height: 50,
                              ),

                          ],
                        );
                      })),
                );
              })),
    );
  }
}
