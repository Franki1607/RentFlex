import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/countries.dart';

import '../../../constants.dart';
import '../controllers/login_controller.dart';

class PhoneNumberForm extends GetWidget<LoginController> {
  const PhoneNumberForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
        child:  FormBuilderPhoneField(
        name: 'phone',
        defaultSelectedCountryIsoCode: 'BJ',
        countryFilterByIsoCode: ['BJ'],
        priorityListByIsoCode: ['BJ'],
        validator: FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(errorText: "Phone number is required"),
            // Write your custom validator here using PhoneNumberUtil to validate phone number
            (value) {
              // check if number has 8 digits
              if (value!.length != 8) {
                return 'Please enter a valid phone number';
              }
              // check if number starts with number in mtnPrefixList
              if (!mtnPrefixList.contains(int.parse(value.substring(0, 2)))) {
                return 'Only MTN numbers are allowed';
              }
              return null;
            }

          ]
        ),
      ),
    );
  }
}