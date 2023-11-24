import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/models/momo_transaction.dart';
import '../../constants.dart';
import 'controllers/transactions_controller.dart';

class TransactionsPage extends GetWidget<TransactionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        appBar: AppBar(
          title: Text("transactions".tr, style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: GetBuilder<TransactionsController>(
          builder: (_) => StreamBuilder<List<MomoTransaction>>(
            stream: controller.firebaseCore.getAllMomoTransactionStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("Data transactions");
                print(snapshot.data);
                List<MomoTransaction> transactions = snapshot.data!;
                return transactions.length==0 ?Center(
                  child: Image.asset("images/no-data-min.png"),
                ) : Padding(
                  padding: const EdgeInsets.only(left: defaultPadding/2, right: defaultPadding/2),
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      MomoTransaction transaction = transactions[index];
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(defaultPadding/2),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            Container(
                                              height: defaultWidth/2,
                                              width: defaultWidth/2,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(20.0)),
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              width: defaultWidth/2
                                            ),
                                            Text(
                                              "${transaction!.type}".tr,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
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
                                              transaction.amount?.toStringAsFixed(0)??"0",
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
                                              "${transaction.date!.day??0}"+ " "+controller.months[transaction.date!.month-1] + " ${transaction.date!.year}",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              " - "+"${transaction.date!.hour}"+":"+ "${transaction.date!.minute}",
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
                                            Text(
                                              "Ref: ".tr,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                (GetStorage().read("user_role")=="owner")?
                                                "${transaction.toTransactionId}": "${transaction.fromTransactionId}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
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
                                            Text(
                                              "Statut: ".tr,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              transaction.status!=null? "${transaction.status}": "PENDING",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: transaction.status=="SUCCESSFUL"? Colors.lightGreen: transaction.status=="PENDING" ||transaction.status=="ONGOING" ?Colors.orange:Colors.red,

                                              ),
                                            ),

                                          ],
                                        ),


                                      ],
                                    ),
                                  )
                                ],
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
