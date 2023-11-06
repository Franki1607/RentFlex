import 'package:animate_do/animate_do.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_flex/pages/login_page/forms/phone_number_form.dart';
import 'controllers/login_controller.dart';
import 'forms/otp_form.dart';

class LoginPage extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
          builder: (_) =>
              SingleChildScrollView(
                child: Container(
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
                              'https://images2.imgbox.com/7b/9b/s5JBARFN_o.jpeg',
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          FadeInDown(
                              duration: Duration(milliseconds: 500),
                              child: Text(
                                "Verification OTP Phone Number",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          if(!controller.canWriteCode.value)
                          FadeInDown(
                            delay: Duration(milliseconds: 500),
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              "Please enter yor phone number",
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
                              "A code was sent to the \n "+controller.phone.value,
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
                                  "Code not received?",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey.shade500),
                                ),
                                TextButton(
                                    onPressed: () {
                                      if (controller.canResendCode.value) {
                                        controller.sendOtp(isResend: true);
                                      }
                                    },
                                    child: Text(
                                      !controller.canResendCode.value
                                          ? "Try again in " + controller.retryCount.toString()
                                          : "Resend",
                                      style: TextStyle(color: Colors.blueAccent),

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
                                        controller.canWriteCode.value = false;
                                        controller.setLoading(false);
                                      }
                                    },
                                    child: Text("back",
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
                              color: Colors.blueAccent,
                              minWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8,
                              height: 50,
                              child: controller.isLoading.value? Center(child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),) :Text(
                                "Send Code",
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
              )),
    );
  }
}
