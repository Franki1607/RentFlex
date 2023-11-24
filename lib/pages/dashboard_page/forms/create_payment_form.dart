import 'dart:async';
import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/pages/contracts_page/controllers/contracts_controller.dart';
import 'package:rent_flex/pages/dashboard_page/controllers/dashboard_controller.dart';
import '../../../constants.dart';

class createPaymentForm extends GetWidget<DashboardController> {
  const createPaymentForm({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      assignId: true,
      builder: (logic) {
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
                      Text("make_payment".tr, style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600))
                    ],
                  ),
                ),
                FormBuilder(
                  key: controller.formKey,
                  child: Obx(() {
                    return Column(
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
                          items: controller.properties.value.map((e) {
                            return DropdownMenuItem(
                              child: Text(e.name),
                              value: e.uid,
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null)
                              controller.setMinAmount(
                                  controller.properties.value
                                      .firstWhere((element) =>
                                  element.uid == val)
                                      .price);
                          },
                          valueTransformer: (val) {
                            return val == null ? null : val.toString();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                            name: "amount",
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "amount".tr,
                                helperText: "Min ${controller.minAmount.value
                                    .toStringAsFixed(0)} FCFA"
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "amount_required".tr),
                                  (value) {
                                if (value!.isNotEmpty) {
                                  //check if value is more than min amount
                                  print(controller.minAmount.value);
                                  print(double.parse(value));
                                  if (double.parse(value) <
                                      controller.minAmount.value) {
                                    return 'amount_too_low'.tr;
                                  }
                                }
                              }
                            ])
                        ),
                        FormBuilderCheckbox(
                          name: "useAnotherNumber",
                          initialValue: controller.useAnotherNumber.value,
                          title: Text("use_another_number".tr),
                          decoration: InputDecoration(
                            //center element
                              alignLabelWithHint: true
                          ),
                          onChanged: (value) {
                            controller.setUseAnotherNumber(value!);
                          },
                        ),
                        if(controller.useAnotherNumber.value)
                          SizedBox(
                            height: 10,
                          ),
                        if(controller.useAnotherNumber.value)
                          FormBuilderPhoneField(
                            name: 'tenantNumber1',
                            initialValue: controller.firebaseCore.firebaseUser
                                ?.phoneNumber,
                            defaultSelectedCountryIsoCode: 'BJ',
                            countryFilterByIsoCode: ['BJ'],
                            priorityListByIsoCode: ['BJ'],
                            validator: controller.useAnotherNumber.value
                                ? FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                      errorText: "phone_number_required".tr),
                                      (value) {
                                    if (value!.length != 8) {
                                      return 'enter_valid_phone_number'.tr;
                                    }
                                    if (!mtnPrefixList.contains(
                                        int.parse(value.substring(0, 2)))) {
                                      return 'only_mtn_numbers_are_allowed'.tr;
                                    }
                                    if (controller.firebaseCore.firebaseUser
                                        ?.phoneNumber!.substring(4) == value) {
                                      return 'same_number'.tr;
                                    }
                                    return null;
                                  }

                                ]
                            )
                                : null,
                          ),
                      ],
                    );
                  }),
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
                            Get.back();

                            Get.showSnackbar(GetSnackBar(
                              title: 'created_payment'.tr,
                              message: "payment_created_text".tr,
                              icon: Icon(BootstrapIcons.check_circle_fill,
                                  color: Colors.green),
                              duration: Duration(seconds: 2),
                            ));

                            String propertyId = controller.formKey.currentState!
                                .fields["propertyId"]!.value;
                            String amount = controller.formKey.currentState!
                                .fields["amount"]!.value;
                            String? tenantNumber1 = null;
                            if (controller.useAnotherNumber.value)
                              tenantNumber1 = controller.formKey.currentState!
                                  .fields["tenantNumber1"]!.value;

                            late StreamSubscription<bool> subscription;
                            subscription = controller.firebaseCore.makePayment(
                                propertyId, amount, tenantNumber1).listen((
                                event) {
                              if (event) {
                                print("ça a été long mais j'ai fini");
                                subscription.cancel();
                                controller.update();
                              }
                            });
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
                          child: CircularProgressIndicator(
                            color: Colors.white,)),)
                          : Text(
                        "save".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: defaultHeight,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}