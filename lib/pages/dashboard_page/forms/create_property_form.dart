import 'package:animate_do/animate_do.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../controllers/dashboard_controller.dart';

class createPropertyForm extends GetWidget<DashboardController>{
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
            FormBuilder(
              key: controller.formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                      name: 'name',
                      maxLines: 5,
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
                      (value){
                        if(controller.formKey.currentState!.fields['price']!.value != null){
                          if(double.parse(controller.formKey.currentState!.fields['price']!.value.toString()) < double.parse(controller.formKey.currentState!.fields['minPrice']!.value.toString())){
                            return "min_price_max".tr;
                          }else if(double.parse(controller.formKey.currentState!.fields['price']!.value.toString())/25 < double.parse(controller.formKey.currentState!.fields['minPrice']!.value.toString())){
                            return "min_price_min".tr;
                          }
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                    name: "numberOfSaloons",
                    keyboardType: TextInputType.number,
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
              height: 50,
            ),
            FadeInDown(
              delay: Duration(milliseconds: 800),
              duration: Duration(milliseconds: 500),
              child: Obx(() {
                return MaterialButton(
                  elevation: 0,
                  onPressed: () async {
                    // if (controller.moreInfoFormKey.currentState!
                    //     .saveAndValidate()) {
                    //   await controller.createUser();
                    // }
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

  // @override
  // Widget build(BuildContext context) {
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Upload Images'),
  //     ),
  //     body: GetBuilder<DashboardController>(
  //       builder: (controller) => Obx(() => Container(
  //         height: 200,
  //         child: ListView.builder(
  //           itemCount: controller.tasks.length,
  //           itemBuilder: (context, index) {
  //             return StreamBuilder<firebase_storage.TaskSnapshot>(
  //               stream: controller.tasks[index].snapshotEvents,
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasData) {
  //                   final progress =
  //                       snapshot.data!.bytesTransferred / snapshot.data!.totalBytes;
  //                   return ListTile(
  //                     leading: Image.file(controller.images[index]),
  //                     title: LinearProgressIndicator(value: progress),
  //                   );
  //                 } else {
  //                   return Container();
  //                 }
  //               },
  //             );
  //           },
  //         ),
  //       )),
  //     ),
  //     floatingActionButton: Padding(
  //
  //       padding: const EdgeInsets.only(bottom: 78.0),
  //       child: FloatingActionButton(
  //         onPressed: controller.pickImages,
  //         child: Icon(Icons.add_a_photo),
  //       ),
  //     ),
  //   );
  // }
}