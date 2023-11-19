import 'package:animate_do/animate_do.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:rent_flex/pages/estates_page/controllers/estates_controller.dart';
import '../../../constants.dart';

class createPropertyForm extends GetWidget<EstatesController> {
  const createPropertyForm({Key? key}) : super(key: key);

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
                  Text("add_property".tr, style: Theme
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
                  FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(
                          labelText: "name".tr,
                          hintText: "name_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "name_required".tr),
                        FormBuilderValidators.min(
                            10, errorText: "name_min".tr)
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: 'description',
                      maxLines: 5,
                      decoration: InputDecoration(
                          labelText: "description".tr,
                          hintText: "description_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "description_required".tr),
                        FormBuilderValidators.min(
                            10, errorText: "description_min".tr)
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: 'country',
                      initialValue: "Bénin",
                      enabled: false,
                      decoration: InputDecoration(
                          labelText: "country".tr,
                          hintText: "country_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "country_required".tr),
                        FormBuilderValidators.min(
                            2, errorText: "country_min".tr)
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "department",
                      decoration: InputDecoration(
                          labelText: "department".tr,
                          hintText: "department_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "department_required".tr),
                        FormBuilderValidators.min(
                            2, errorText: "department_min".tr)
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: 'city',
                      decoration: InputDecoration(
                          labelText: "city".tr,
                          hintText: "city_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "city_required".tr),
                        FormBuilderValidators.min(
                            2, errorText: "city_min".tr)
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "neighborhood",
                      decoration: InputDecoration(
                          labelText: "neighborhood".tr,
                          hintText: "neighborhood_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "neighborhood_required".tr),
                        FormBuilderValidators.min(
                            2, errorText: "neighborhood_min".tr)
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "address",
                      maxLines: 2,
                      decoration: InputDecoration(
                          labelText: "address".tr,
                          hintText: "address_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "address_required".tr),
                        FormBuilderValidators.min(
                            20, errorText: "address_min".tr)
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "price",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "price".tr,
                          hintText: "price_hint".tr,
                          suffixText: "CFA"
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "price_required".tr),
                        FormBuilderValidators.min(
                            2, errorText: "price_min".tr)
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "minPrice",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "min_price".tr,
                          hintText: "min_price_hint".tr,
                          suffixText: "CFA"
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "price_required".tr),
                        FormBuilderValidators.min(
                            2, errorText: "price_min".tr),
                            (value) {
                          if (controller.formKey.currentState!.fields['price']!
                              .value != null) {
                            if (double.parse(controller.formKey.currentState!
                                .fields['price']!.value.toString()) < double
                                .parse(controller.formKey.currentState!
                                .fields['minPrice']!.value.toString())) {
                              return "min_price_max".tr;
                            } else if (double.parse(
                                controller.formKey.currentState!
                                    .fields['price']!.value.toString()) <
                                1000) {
                              return "min_price_min".tr;
                            }
                            // if(double.parse(controller.formKey.currentState!.fields['price']!.value.toString())/25 < double.parse(controller.formKey.currentState!.fields['minPrice']!.value.toString())){
                            //   return "min_price_min".tr;
                            // }
                            //
                          }
                          return null;
                        }
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderDropdown(
                    name: "type",
                    decoration: InputDecoration(
                        labelText: "type".tr
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "type_required".tr),
                    ]),
                    items: [
                      DropdownMenuItem(
                          value: "house",
                          child: Text("house".tr)
                      ),
                      DropdownMenuItem(
                          value: "apartment",
                          child: Text("apartment".tr)
                      ),
                      DropdownMenuItem(
                          value: "land",
                          child: Text("land".tr)
                      ),
                      DropdownMenuItem(
                          value: "store",
                          child: Text("store".tr)
                      ),
                      DropdownMenuItem(
                          value: "office",
                          child: Text("office".tr)
                      ),
                      DropdownMenuItem(
                          value: "other",
                          child: Text("other".tr)
                      )
                    ],
                    valueTransformer: (val) {
                      return val == null ? null : val.toString();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "numberOfSaloons",
                      keyboardType: TextInputType.number,
                      initialValue: "0",
                      decoration: InputDecoration(
                          labelText: "numberOfSaloons".tr,
                          hintText: "numberOfSaloons_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "numberOfSaloons_required".tr),
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "numberOfBedrooms",
                      keyboardType: TextInputType.number,
                      initialValue: "0",
                      decoration: InputDecoration(
                          labelText: "numberOfBedrooms".tr,
                          hintText: "numberOfBedrooms_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "numberOfBedrooms_required".tr),
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "numberOfBathrooms",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "numberOfBathrooms".tr,
                          hintText: "numberOfBathrooms_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "numberOfBathrooms_required".tr),
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "numberOfGarages",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "numberOfGarages".tr,
                          hintText: "numberOfGarages_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "numberOfGarages_required".tr),
                      ])
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                      name: "numberOfFloors",
                      initialValue: "0",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "numberOfFloors".tr,
                          hintText: "numberOfFloors_hint".tr
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "numberOfFloors_required".tr),
                      ])
                  ),


                ],
              ),
            ),
            SizedBox(
              height: defaultHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Images"),
                IconButton(onPressed: (){
                  controller.pickImages();
                }, icon: Icon(BootstrapIcons.plus_circle))
              ],
            ),
            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemCount: controller.images.value.length,
                padding: EdgeInsets.only(bottom: defaultPadding*2),
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.0),
                            image: DecorationImage(
                                image: FileImage(controller.images[index]),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                        icon: Icon(BootstrapIcons.trash, color: Colors.red,),
                        onPressed: () {
                          controller.deleteImage(index);
                          Get.forceAppUpdate();
                        },
                      ),
                    ],
                  );
                },
              );
            }),
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
                        //print(controller.formKey.currentState!.fields['type']?.value);
                        controller.saveProperty();
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