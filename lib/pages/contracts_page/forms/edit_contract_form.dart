import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:rent_flex/pages/contracts_page/controllers/contracts_controller.dart';
import 'package:rent_flex/pages/estates_page/controllers/estates_controller.dart';
import '../../../constants.dart';

class editContractForm extends GetWidget<ContractsController> {
  const editContractForm({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: defaultPadding / 2, bottom: defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("add_contract".tr, style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600))
                ],
              ),
            ),
            FormBuilder(
              key: controller.formKey,
              child: Column(
                children: [
                  FormBuilderDropdown(
                    name: "propertyId",
                    decoration: InputDecoration(
                        labelText: "property".tr
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "property_required".tr),
                    ]),
                    items: controller.oroperties.value.map((e) {
                      return DropdownMenuItem(
                        child: Text(e.name),
                        value: e.uid,
                      );
                    } ).toList(),
                    valueTransformer: (val) {
                      return val == null ? null : val.toString();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderPhoneField(
                    name: 'tenantNumber1',
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
                            if (controller.firebaseCore.firebaseUser?.phoneNumber!.substring(4) == value) {
                              return 'same_number'.tr;
                            }
                            return null;
                          }

                        ]
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderDateTimePicker(
                    name: "startPaiementDate",
                    decoration: InputDecoration(
                        labelText: "startPaiementDate".tr
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "startPaiementDate_required".tr),
                    ]),
                    inputType: InputType.date,
                    initialEntryMode: DatePickerEntryMode.calendar,
                    initialDate: DateTime.now(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: defaultHeight,
            ),
            FadeInDown(
              delay: Duration(milliseconds: 800),
              duration: Duration(milliseconds: 500),
              child: Obx(() {
                return MaterialButton(
                  elevation: 0,
                  onPressed: () async {
                    if (!controller.isSaveLoading.value)
                      if (controller.formKey.currentState!
                          .saveAndValidate()) {
                        controller.saveContract();
                      }
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
                  child: controller.isSaveLoading.value
                      ? Center(child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(color: Colors.white,)),)
                      : Text(
                    "save".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}