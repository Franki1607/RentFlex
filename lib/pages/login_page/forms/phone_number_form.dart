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
            FormBuilderValidators.required(errorText: "phone_number_required".tr),
            (value) {
              if (value!.length != 8) {
                return 'enter_valid_phone_number'.tr;
              }
              if (!mtnPrefixList.contains(int.parse(value.substring(0, 2)))) {
                return 'only_mtn_numbers_are_allowed'.tr;
              }
              return null;
            }

          ]
        ),
      ),
    );
  }
}