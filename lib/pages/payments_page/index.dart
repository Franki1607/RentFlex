import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants.dart';
import '../../models/payment.dart';
import 'controllers/payments_controller.dart';

class PaymentsPage extends GetWidget<PaymentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        appBar: AppBar(
          title: Text("payments".tr, style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: GetBuilder<PaymentsController>(
          builder: (_) => StreamBuilder<List<Payment>>(
            stream: controller.firebaseCore.getAllPaymentStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("Data payments");
                print(snapshot.data);
                List<Payment> payments = snapshot.data!;
                return payments.length==0 ?Center(
                  child: Image.asset("images/no-data-min.png"),
                ) : Padding(
                  padding: const EdgeInsets.only(left: defaultPadding/2, right: defaultPadding/2),
                  child: ListView.builder(
                    itemCount: payments.length,
                    padding: EdgeInsets.only(bottom: 100),
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
                                onTap: () {
                                  print("I'm Caulled");
                                  Get.toNamed("/payment-details", arguments: [payment, controller.getProperty(payment.propertyId)]);
                                },
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
                                                child: Icon(BootstrapIcons.calendar_check),
                                              ),
                                              Text(
                                                controller.months[payment.monthlyDate!.month-1] + " ${payment.monthlyDate!.year}",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: defaultHeight/2
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: defaultPadding/4),
                                                child: Icon(BootstrapIcons.wallet),
                                              ),
                                              Text(
                                                double.parse(payment.amount).toStringAsFixed(0),
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                " F CFA",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey,
                                                ),
                                              ),

                                            ],
                                          ),
                                          SizedBox(
                                              height: defaultHeight/2
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: defaultPadding/4),
                                                child: Icon(BootstrapIcons.clock),
                                              ),
                                              Text(
                                                "${payment.createdAt!.day??0}"+ " "+controller.months[payment.createdAt!.month-1] + " ${payment.createdAt!.year}",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                " - "+"${payment.createdAt!.hour}"+":"+ "${payment.createdAt!.minute}",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey,
                                                ),
                                              ),

                                            ],
                                          ),
                                          SizedBox(
                                              height: defaultHeight/2
                                          ),
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
