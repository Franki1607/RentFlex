import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:telephony/telephony.dart';

import '../../../api/firebase/firebase_authentification.dart';
import '../../../constants.dart';

class LoginController extends GetxController {

  final formKey = GlobalKey<FormBuilderState>();

  final otpFieldController = OtpFieldController();

  final otpValue = "".obs;

  void setOtpValue(String value) => otpValue.value = value;

  final currentIndex = 0.obs ;

  void setIndex(int index) => this.currentIndex.value = index;

  final otpResended = false.obs;

  void setOtpResended(bool value) => otpResended.value = value;

  final canWriteCode = false.obs;

  void setCanWriteCode(bool value) => canWriteCode.value = value;

  final canResendCode = true.obs;

  void setCanResendCode(bool value) => canResendCode.value = value;

  final retryCount = 0.obs;
  
  final phone = "".obs;
  
  void setPhone(String value) => phone.value = value;

  final FirebaseAuthenfication _authHelper = FirebaseAuthenfication();

  final isLoading = false.obs;

  void setLoading(bool value) => isLoading.value = value;

  String verificationId = "";

  Telephony telephony = Telephony.instance;



  void sendOtp({bool isResend = false}) async {
    if (isResend || formKey.currentState!.saveAndValidate()) {
      if (!isResend){
        isLoading.value = true;
        setPhone("+229"+formKey.currentState!.fields['phone']!.value);
      }

      await _authHelper.sendVerificationCode(phone.value, (String id) {
        verificationId = id;
        canWriteCode.value = true;
        canResendCode.value = false;

        retryCount.value = 60; // for 1 minute

        new Timer.periodic(Duration(seconds: 1), (timer) {
          if (retryCount.value == 0) {
            canResendCode.value = true;
            timer.cancel();
          }
          retryCount.value--;
        });
      }, () {
        isLoading.value = false;
        Get.showSnackbar(
            GetSnackBar(
              title: 'Verification failed',
              message: 'Please try again',
              icon: Icon(Icons.error, color: Colors.red),
            )
        );
      }, () {
        isLoading.value = false;
        GetSnackBar(
          title: 'Verification failed',
          message: 'The verification took too long, please try again',
          icon: Icon(Icons.error, color: Colors.red),
        );
      });
    }
  }

  Future<void> verifyOtp() async {
    if (otpValue.value.length == 6) {
      await _authHelper.signInWithPhoneNumber(verificationId, otpValue.value)
          .then((User? user) {
        if (user != null) {
          Get.offNamed("/");
          print("User is signed in!");
        } else {
          otpFieldController.clear();
          Get.showSnackbar(
            GetSnackBar(
              title: "Log in failed",
              message: "Please try again",
              icon: Icon(Icons.error, color: Colors.red),
            )
          );
        }
      });
    }
  }

  @override
  void onInit() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print("Koiiiiiii il y a un nouveau message");
        print(message.body);
        // get the message
        String sms = message.body.toString();

        if(message.body!.contains(appFirebaseId)){
          String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'),'');
          otpFieldController.set(otpcode.split(""));

        }else{
          print("Normal message.");
        }
      },
      listenInBackground: false,
    );
    super.onInit();
  }

  void navigateBack() => Get.back();
}
