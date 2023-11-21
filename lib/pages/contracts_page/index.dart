import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/models/contract.dart';
import 'package:rent_flex/pages/contracts_page/forms/create_contract_form.dart';
import '../../constants.dart';
import 'controllers/contracts_controller.dart';

class ContractsPage extends GetWidget<ContractsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        appBar: AppBar(
          title: Text("contracts".tr),
          centerTitle: true,
        ),
        floatingActionButton: (GetStorage().read("user_role")=="owner")? FloatingActionButton(
          onPressed: () {
            Get.bottomSheet(
              BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return createContractForm();
                }
              )
            );
          },
          child: Icon(BootstrapIcons.file_earmark_plus),
        ): null,
        body: GetBuilder<ContractsController>(
          builder: (_) => StreamBuilder<List<Contract>>(
            stream: controller.firebaseCore.getAllContractsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("Data Contracts");
                print(snapshot.data);
                List<Contract> contracts = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.only(left: defaultPadding/2, right: defaultPadding/2),
                  child: ListView.builder(
                    itemCount: contracts.length,
                    itemBuilder: (context, index) {
                      Contract contract = contracts[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: defaultHeight/2
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(color: Colors.white,
                                  boxShadow: [
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),

                                    //   color: Color(0xFFF4F5F6),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(defaultPadding/2),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.getPropertyName(contract.propertyId),
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
                                                  contract.tenantNumber1,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
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
                                                Text("Status: "),
                                                Text((contract.isActive?? true)?'Actif': "Inactif",
                                                  style: TextStyle(
                                                    color: (contract.isActive?? true)?Colors.green: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                        text: "${contract.startPaiementDate.toString().split(" ")[0]} ",
                                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                            color: primaryColor
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(onPressed: (){}, icon: Icon(BootstrapIcons.pencil_square),)
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                          )
                        ],
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
