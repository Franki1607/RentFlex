import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/models/payment.dart';
import '../../constants.dart';
import 'controllers/invoice_controller.dart';

class InvoicePage extends GetWidget<InvoiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        appBar: AppBar(
          title: Text("payments".tr),
          centerTitle: true,
        ),
        floatingActionButton: (GetStorage().read("user_role")=="owner")? FloatingActionButton(
          onPressed: () {
            // Get.bottomSheet(
            //     BottomSheet(
            //         onClosing: () {},
            //         builder: (BuildContext context) {
            //           return createContractForm();
            //         }
            //     )
            // );
          },
          child: Icon(BootstrapIcons.file_earmark_plus),
        ): null,
        body: GetBuilder<InvoiceController>(
          builder: (_) => StreamBuilder<List<Payment>>(
            stream: controller.firebaseCore.getAllPaymentStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("Data payments");
                print(snapshot.data);
                List<Payment> payments = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.only(left: defaultPadding/2, right: defaultPadding/2),
                  child: ListView.builder(
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      Payment payment = payments[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: defaultPadding/2),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                              color: Colors.white
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height: defaultHeight/2
                              ),
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(defaultPadding/2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.getPropertyName(payment.propertyId),
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                              height: defaultHeight/2
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: defaultPadding/4),
                                                child: Icon(BootstrapIcons.person_fill_gear),
                                              ),
                                              Text(
                                                GetStorage().read("user_role")=="owner"?payment.uid:payment.uid,
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: (GetStorage().read("user_role")=="owner")? MainAxisAlignment.spaceBetween: MainAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "start_paiement_date".tr+": ",
                                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                            color: Colors.black87
                                                        )
                                                    ),
                                                    TextSpan(
                                                      text: "${payment.monthlyDate.toString().split(" ")[0]} ",
                                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                          color: primaryColor
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              if (GetStorage().read("user_role")=="owner")
                                                IconButton(onPressed: (){}, icon: Icon(BootstrapIcons.pencil_square),)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: CircularProgressIndicator())
                );
              }
            },
          ),
        )
    );
  }
}
