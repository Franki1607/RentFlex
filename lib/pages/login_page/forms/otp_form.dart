import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/countries.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../controllers/login_controller.dart';

class OtpForm extends GetWidget<LoginController> {
  const OtpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OTPTextField(
      controller: controller.otpFieldController,
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 30,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w900
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onChanged: (value) {

      },
      onCompleted: (pin) async {
        controller.setOtpValue(pin);
        await controller.verifyOtp();
        print("Completed: " + pin);
      },
    );
  }
}