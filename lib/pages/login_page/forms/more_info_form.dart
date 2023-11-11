import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../controllers/login_controller.dart';
import '../../../models/user.dart' as mUser;


class MoreInfoForm extends GetWidget<LoginController> {
  const MoreInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeInDown(
              duration: Duration(milliseconds: 500),
              child: Text(
                "let_create_profile".tr,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 30,
          ),
          Obx(() {
            return Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    // Make circle avatar with pathImage or background color grey and selected image with FilePicker
                    if (controller.imagePath.value != '')
                      Obx(() {
                        return CircleAvatar(
                          radius: circleAvatarRaduis,
                          backgroundImage: FileImage(
                              File(controller.imagePath.value)),
                        );
                      })
                    else
                      CircleAvatar(
                        radius: circleAvatarRaduis,
                        backgroundColor: Colors.grey,

                      ),
                    //add button to select image
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () async {
                          print("Called");
                          FilePickerResult? result = await FilePicker
                              .platform
                              .pickFiles(
                            type: FileType.image,
                          );
                          if (result != null &&
                              (result.files.first.extension ==
                                  "jpg" ||
                                  result.files.first
                                      .extension ==
                                      "jpeg" ||
                                  result.files.first
                                      .extension ==
                                      "png" ||
                                  result.files.first
                                      .extension ==
                                      "gif") &&
                              result.files.first.size <=
                                  4194304) {
                            controller.imagePath.value =
                            result.files.single.path!;
                          } else {
                            Get.snackbar("Error",
                                "Veillez selectionner une image de moins de 4Mo");
                          }
                        },
                        child: Center(
                            child: Icon(
                              Icons.camera_alt, size: 25,
                              color: primaryColor,)
                        ),
                      ),

                    ),
                  ],
                ),
                if (controller.imagePath.value != '')
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.imagePath.value =
                        '';
                      },
                      child: Center(child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 18)),
                    ),
                  ),
              ],
            );
          }),
          FormBuilder(
            key: controller.moreInfoFormKey,
            child: Column(
              children: [
                FormBuilderTextField(
                    name: 'firstName',
                    decoration: InputDecoration(
                        labelText: "first_name".tr
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "first_name_required".tr),
                      FormBuilderValidators.min(
                          2, errorText: "first_name_min".tr)
                    ])
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                    name: 'lastName',
                    decoration: InputDecoration(
                        labelText: "last_name".tr
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "last_name_required".tr),
                      FormBuilderValidators.min(
                          2, errorText: "last_name_min".tr)
                    ])
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(
                        labelText: "email".tr
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "email_required".tr),
                      FormBuilderValidators.email(errorText: "invalid_email".tr)
                    ])
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderRadioGroup(
                  name: 'role',
                  decoration: InputDecoration(
                      labelText: "role".tr
                  ),
                  initialValue: "owner",
                  options: [
                    FormBuilderFieldOption(
                        value: 'owner',
                        child: Text("owner".tr)
                    ),
                    FormBuilderFieldOption(
                        value: 'tenant',
                        child: Text("tenant".tr)
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          FadeInDown(
            delay: Duration(milliseconds: 800),
            duration: Duration(milliseconds: 500),
            child: Obx(() {
              return MaterialButton(
                elevation: 0,
                onPressed: () async {
                  if (controller.moreInfoFormKey.currentState!
                      .saveAndValidate()) {
                    await controller.createUser();
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
    );
  }
}