import 'dart:async';
import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/api/firebase/firebase_core.dart';
import 'package:rent_flex/api/momo_open_api/mtn_momo_api.dart';
import 'package:rent_flex/api/momo_open_api/mtn_momo_models.dart';
import 'package:rent_flex/models/property.dart';
import 'package:rent_flex/pages/dashboard_page/forms/create_payment_form.dart';
import 'package:rent_flex/pages/dashboard_page/widgets/tenants_view.dart';
import 'package:uuid/uuid.dart';
import '../../constants.dart';
import 'controllers/dashboard_controller.dart';

class DashboardPage extends GetWidget<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
        builder: (_) => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/background.png"),
                        fit: BoxFit.cover
                      )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: defaultPadding/2, right: defaultPadding/2, top: 140.0, bottom: defaultPadding),
                    child: StreamBuilder<List<Property>>(
                      stream: controller.firebaseCore.getAllPropertiesStream(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          List<Property> properties = snapshot.data!;
                          if (properties.isEmpty) {
                            return Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 180.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(defaultRadius*2)),
                                        ),
                                        child: Center(
                                            child: Column(
                                              children: [
                                                Image.asset("images/no-data-min.png", height: 150,),
                                                Text((GetStorage().read("user_role")=="owner")? "no_data_owner".tr: "no_data_tenant".tr, overflow: TextOverflow.ellipsis,)
                                              ],
                                            )
                                        ) ,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 170.0,
                                          width: 170.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white10.withOpacity(0.1),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(200.0),
                                                  topRight: Radius.circular(20.0))),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }
                          return CarouselSlider(
                            options: CarouselOptions(
                              aspectRatio: 5 / 10,
                              autoPlay: properties.length>1? true: false,
                              viewportFraction: 1.0,
                              height: 200.0,
                            ),
                            items: properties.map((property) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 180.0,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(0, 5),
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(defaultRadius*2)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: defaultHeight,
                                                ),
                                                Text(
                                                  "${property.name}",
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: Color(0xFF1F1F1F),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: defaultHeight,
                                                ),
                                                Text(
                                                  "sold".tr,
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      fontSize: 12
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: defaultHeight/2,
                                                ),
                                                Text(
                                                  property.lastPaymentMonth!=null? controller.checkBestMonth(DateTime.now(), property.lastPaymentMonth??DateTime.now())? "0 / ${property.price.toStringAsFixed(0)} FCFA":
                                                  "${property.lastPaymentAmount?.toStringAsFixed(0)??0.toStringAsFixed(0)} / ${property.price.toStringAsFixed(0)} FCFA" : "0 / ${property.price.toStringAsFixed(0)} FCFA",
                                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    color: Color(0xFF1F1F1F),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: defaultHeight,
                                                ),
                                                if(property.lastPaymentMonth!=null)
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                        controller.checkBestMonth(DateTime.now(), property.lastPaymentMonth??DateTime.now())? "rent_for".tr +  "${controller.months[DateTime.now().month -1]} ${DateTime.now().year}": "rent_for".tr + " ${controller.months[property.lastPaymentMonth!.month-1]} ${property.lastPaymentMonth!.year} ",
                                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                            fontSize: 12
                                                        )
                                                    ),
                                                    Text(
                                                        controller.checkBestMonth(DateTime.now(), property.lastPaymentMonth??DateTime.now())? "O%" :
                                                        "${(100*(property.lastPaymentAmount??0) / property!.price).ceil()} %",
                                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                            fontSize: 12,
                                                            color: Colors.red
                                                        )
                                                    ),

                                                  ],
                                                ),
                                                if(property.lastPaymentMonth==null)
                                                  Text("no_occupied".tr, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),),
                                                SizedBox(
                                                  height: defaultHeight/2,
                                                ),
                                                if(property.lastPaymentMonth!=null)
                                                LinearProgressIndicator(
                                                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                                  value: controller.checkBestMonth(DateTime.now(), property.lastPaymentMonth??DateTime.now())? 0.0: (100*(property.lastPaymentAmount??0) / property!.price)/100,
                                                  backgroundColor: Color(0xFFF1F1F1),
                                                  minHeight: defaultHeight/2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 170.0,
                                            width: 170.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white10.withOpacity(0.1),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(200.0),
                                                    topRight: Radius.circular(20.0))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          );
                        }else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 180.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(defaultRadius*2)),
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator()
                                      ) ,
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 170.0,
                                        width: 170.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white10.withOpacity(0.1),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(200.0),
                                                topRight: Radius.circular(20.0))),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          );
                        }
                      }
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding*3, left: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: defaultPadding*2.5,
                            width: defaultPadding*2.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(color: Colors.white, width: 2.0),
                                image: DecorationImage(
                                    image: NetworkImage("https://res.cloudinary.com/dfng74ru6/image/upload/v1700353755/blank-profile_jitnpg.png"),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Y'ello",
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  "${GetStorage().read("user_first_name")?? "User"}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                ]
              ),
              Padding(
                padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (GetStorage().read("user_role")=="owner") {
                          Get.showSnackbar(GetSnackBar(
                            title: 'Error'.tr,
                            message: "only_for_tenant".tr,
                            icon: Icon(Icons.error, color: Colors.orange),
                            duration: Duration(seconds: 2),
                          ));
                        }else
                        Get.bottomSheet(
                            BottomSheet(
                                onClosing: () {},
                                builder: (BuildContext context) {
                                  controller.setMinAmount(1000);
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
                                                          helperText: "Min 1000 FCFA"
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
                                                                1000) {
                                                              return 'amount_too_low'.tr;
                                                            }
                                                            // if (double.parse(value) <
                                                            //     controller.minAmount.value) {
                                                            //   return 'amount_too_low'.tr;
                                                            // }
                                                            //
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
                                }
                            )
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFfef4ce),
                            radius: 25,
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Icon(
                                BootstrapIcons.cash_stack,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: defaultPadding/4),
                            child: Text("paid".tr),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {

                        Get.toNamed("/transactions");

                       //  MtnMomoApi mtnMomoApi = MtnMomoApi.instance;
                       //
                       //  //await mtnMomoApi.updateToken();
                       //
                       //
                       //  String externalId = "123333332";
                       //  String ref = Uuid().v4();
                       //  bool test= await mtnMomoApi.requestToPay(RequestToPay(
                       //      amount: "1000", phoneNumber: "${FirebaseCore.instance.firebaseUser?.phoneNumber}",
                       //      externalId: externalId, currency: mtnMomoApi.config.currency, note: "Test",  message: "Test"), ref);
                       //
                       //  print("After check $ref");
                       //  print("$test");
                       // //
                       // PaymentStatus? paymentStatus= await mtnMomoApi.getPaymentStatus(ref);
                       //
                       // if (paymentStatus?.status=="SUCCESSFUL") {
                       //   String transferRef = Uuid().v4();
                       //   externalId = "123333332";
                       //   bool transfer= await mtnMomoApi.transfer(Transfer(
                       //     amount: "1000", phoneNumber: "${FirebaseCore.instance.firebaseUser?.phoneNumber}",
                       //     externalId: externalId, currency: mtnMomoApi.config.currency, note: "Test",  message: "Test",
                       //
                       //   ), transferRef);
                       //
                       //   if (transfer) {
                       //     print("transfer en cours pour $transferRef");
                       //   }
                       //
                       //  TransferStatus? transferStatus= await mtnMomoApi.getTransferStatus(transferRef);
                       //
                       //   if (transferStatus?.status=="SUCCESSFUL") {
                       //     print("transfer successful");
                       //   }
                       // }

                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFfef4ce),
                            radius: 25,
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Icon(
                                BootstrapIcons.receipt_cutoff,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: defaultPadding/4),
                            child: Text("Transactions".tr),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/estates");
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFfef4ce),
                            radius: 25,
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Icon(
                                BootstrapIcons.house_door,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: defaultPadding/4),
                            child: Text("estates".tr),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/contracts");
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFfef4ce),
                            radius: 25,
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Icon(
                                BootstrapIcons.gear,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: defaultPadding/4),
                            child: Text("contracts".tr),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: defaultPadding ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "late_paiements".tr,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      "see_all".tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: defaultPadding*5),
                child: StreamBuilder<List<Property>>(
                  stream: controller.firebaseCore.getAllPropertiesStream(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      List<Property> properties = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: properties.length,
                        padding: EdgeInsets.only(top: 0),
                        itemBuilder: (context, index){
                          return controller.checkBestMonth(DateTime.now(), properties[index].lastPaymentMonth??DateTime.now())? ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: controller.checkDifferenceMonth(DateTime.now(), properties[index]!.lastPaymentMonth?? DateTime.now())??0,
                              padding: EdgeInsets.only(top: 0),
                              //reverse: true,
                              itemBuilder: (context, i) {
                                print("index $index");
                                print("i $i");
                                int difference = controller.checkDifferenceMonth(DateTime.now(), properties[index]!.lastPaymentMonth?? DateTime.now());
                                return Container(
                                  margin: EdgeInsets.only(bottom: defaultPadding),
                                  padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                                  height: 100.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(defaultRadius*2)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: defaultHeight,
                                      ),
                                      Text(
                                        "${properties[index]!.name}",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Color(0xFF1F1F1F),
                                        ),
                                      ),
                                      SizedBox(
                                        height: defaultHeight,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "late_rent_for".tr +" "+ "${controller.months[controller.subtractMonths(DateTime.now(), difference-(i)).month-1]} ",
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.red
                                              )
                                          ),
                                          Text(
                                              i==0? "${(100*(properties[index]!.lastPaymentAmount??0) / properties[index]!.price).ceil() } %": " 0 %",
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.red
                                              )
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: defaultHeight/2,
                                      ),
                                      LinearProgressIndicator(
                                        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                        value: i==0?(100*(properties[index]!.lastPaymentAmount??0) / properties[index]!.price)/100: 0,
                                        backgroundColor: Color(0xFFF1F1F1),
                                        minHeight: defaultHeight/2,
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ):Center();
                        });

                    }else {
                      return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 180.0,
                                  width: double.infinity,
                                  child: Center(
                                      child: CircularProgressIndicator()
                                  ) ,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 170.0,
                                    width: 170.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white10.withOpacity(0.1),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(200.0),
                                            topRight: Radius.circular(20.0))),
                                  ),
                                ),
                              ],
                            ),
                          )
                      );
                    }
                  }
                )
              ),

            ],
          ),
        )
      )
    );
  }
}
