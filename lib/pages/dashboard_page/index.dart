import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/api/firebase/firebase_core.dart';
import 'package:rent_flex/api/momo_open_api/mtn_momo_api.dart';
import 'package:rent_flex/api/momo_open_api/mtn_momo_models.dart';
import 'package:rent_flex/models/property.dart';
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
                                                  "${property.lastPaymentAmount?.toStringAsFixed(0)??0.toStringAsFixed(0)} / ${property.price.toStringAsFixed(0)} FCFA",
                                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                                                        "rent_for".tr,
                                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                            fontSize: 12
                                                        )
                                                    ),
                                                    Text(
                                                        "50 %",
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
                                                  value: 0.5,
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
                    Column(
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
                    GestureDetector(
                      onTap: () async {
                        MtnMomoApi mtnMomoApi = MtnMomoApi.instance;

                        //await mtnMomoApi.updateToken();


                        String externalId = "123333332";
                        String ref = Uuid().v4();
                        bool test= await mtnMomoApi.requestToPay(RequestToPay(
                            amount: "1000", phoneNumber: "${FirebaseCore.instance.firebaseUser?.phoneNumber}",
                            externalId: externalId, currency: mtnMomoApi.config.currency, note: "Test",  message: "Test"), ref);

                        print("After check $ref");
                        print("$test");
                       //
                       PaymentStatus? paymentStatus= await mtnMomoApi.getPaymentStatus(ref);

                       if (paymentStatus?.status=="SUCCESSFUL") {
                         String transferRef = Uuid().v4();
                         externalId = "123333332";
                         bool transfer= await mtnMomoApi.transfer(Transfer(
                           amount: "1000", phoneNumber: "${FirebaseCore.instance.firebaseUser?.phoneNumber}",
                           externalId: externalId, currency: mtnMomoApi.config.currency, note: "Test",  message: "Test",

                         ), transferRef);

                         if (transfer) {
                           print("transfer en cours pour $transferRef");
                         }

                        TransferStatus? transferStatus= await mtnMomoApi.getTransferStatus(transferRef);

                         if (transferStatus?.status=="SUCCESSFUL") {
                           print("transfer successful");
                         }
                       }

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
                            child: Text("invoice".tr),
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
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 1,
                  padding: EdgeInsets.only(top: 0),
                  itemBuilder: (context, index){
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
                            "Immeuble Midombo",
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
                                  "Paiement en retard pour".tr,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 12,
                                    color: Colors.red
                                  )
                              ),
                              Text(
                                  "50 %",
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
                            value: 0.5,
                            backgroundColor: Color(0xFFF1F1F1),
                            minHeight: defaultHeight/2,
                          ),
                        ],
                      ),
                    );
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
