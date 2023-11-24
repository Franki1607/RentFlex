import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rent_flex/constants.dart';
import 'package:rent_flex/models/transaction.dart';
import 'controllers/payment_details_controller.dart';

class PaymentDetailsPage extends GetWidget<PaymentDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        appBar: AppBar(
          title: Text("payment_details".tr, style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: SingleChildScrollView(
            child: GetBuilder<PaymentDetailsController>(
              builder: (_) => FutureBuilder(
                future: controller.firebaseCore.getAllPaymentTransaction(controller.payment.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List <Transaction> transactions = snapshot.data!;
                    print("Data transactions");
                    print(transactions);
                   return Padding(
                     padding: const EdgeInsets.all(18.0),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             QrImageView(
                               data: '${controller.payment.uid}',
                               version: QrVersions.auto,
                               size: 100.0,
                             ),
                           ],
                         ),
                         Text("details".tr, style: Theme.of(context).textTheme.headline6),
                         SizedBox(
                           height:defaultHeight/4
                         ),
                         Divider(thickness: 1.5, color: Colors.black12),
                         SizedBox(
                           height: defaultHeight/4
                         ),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                   width: 200,
                                   child: Text('${controller.property.name}', style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14), overflow: TextOverflow.ellipsis,)),
                                 SizedBox(
                                   height: defaultHeight/4,
                                 ),
                                 Container(
                                   width: 250,
                                   child: Text('${controller.property.description}', style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 12), overflow: TextOverflow.ellipsis)),
                               ],
                             ),
                             Text( '${controller.property.price.toStringAsFixed(0)}/m', ),
                           ],
                         ),
                         SizedBox(
                             height: defaultHeight/4
                         ),
                         Divider(thickness: 1.5, color: Colors.black12),
                         SizedBox(
                             height: defaultHeight/4
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('rent_for'.tr,),
                             Text(controller.months[controller.payment.monthlyDate!.month-1] + " ${controller.payment.monthlyDate!.year}"),

                           ],
                         ),
                         Divider(thickness: 1.5, color: Colors.black12),
                         SizedBox(
                             height: defaultHeight/4
                         ),
                         for (Transaction transaction in transactions)
                           Padding(
                             padding: const EdgeInsets.only(bottom: defaultPadding/4),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text('${transaction.createdAt}',),
                                 Text('${double.parse(transaction.amount).toStringAsFixed(0)}',),

                               ],
                             ),
                           ),
                         Divider(thickness: 1.5, color: Colors.black12),
                         SizedBox(
                             height: defaultHeight/4
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Total',),
                             Text('${double.parse(controller.payment.amount).toStringAsFixed(0)}',),
                           ],
                         ),
                         SizedBox(
                             height: defaultHeight/4
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('unpaid'.tr,),
                               Text('${(controller.property.price - double.parse(controller.payment.amount)).toStringAsFixed(0)}',),
                           ],
                         ),
                         SizedBox(
                             height: defaultHeight
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             TextButton(
                               onPressed: (){
                                 Get.showSnackbar(GetSnackBar(
                                   title: 'Error',
                                   message: 'Available soon',
                                   icon: Icon(Icons.error, color: Colors.yellow),
                                   duration: Duration(seconds: 2),
                                 ));
                               },
                               child: Row(
                                 children: [
                                   Icon(BootstrapIcons.file_pdf),
                                   SizedBox(
                                       width: defaultWidth/4
                                   ),
                                   Text("print".tr,),
                                 ],
                               ),
                               style: TextButton.styleFrom(
                                 primary: Colors.black,
                                 backgroundColor: primaryColor
                               )
                             )
                           ],
                         )
                       ],
                     ),
                   );
                  }else if (snapshot.hasError) {
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
            ),
          ),
        )
    );
  }
}
