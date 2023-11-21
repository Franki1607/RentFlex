import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/constants.dart';
import 'forms/create_property_form.dart';
import 'package:uuid/uuid.dart';
import '../../models/property.dart';
import 'controllers/estates_controller.dart';

class EstatesPage extends GetWidget<EstatesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        title: Text("estates".tr),
        centerTitle: true,
      ),
      floatingActionButton: (GetStorage().read("user_role")=="owner")?  FloatingActionButton(
        onPressed: () {
          controller.images = RxList([]);
          // Get Buttom sheet
          Get.bottomSheet(
            BottomSheet(
              onClosing: (){

              },
              builder: (BuildContext context) {
                return createPropertyForm();
              },
            ));
          //controller.firebaseCore.createProperty(new Property(uid: Uuid().v4(), ownerId: "${controller.firebaseCore.firebaseUser?.uid}", name: "Maison Mikwabo C4", description: "Ceci est une description", country: "Bénin", department: "Littoral", neighborhood: "Agla Hlazounto", address: '500 m de la pharmacie Lulu Lulu', price: 300000, minPrice: 2000, type: "room", other: "", photos: []));
        },
        child: Icon(BootstrapIcons.house_add),
      ): null,
      body: GetBuilder<EstatesController>(
        builder: (_) => StreamBuilder<List<Property>>(
          stream: controller.firebaseCore.getAllPropertiesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("Data");
              print(snapshot.data);
              List<Property> properties = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(left: defaultPadding/2, right: defaultPadding/2),
                child: ListView.builder(
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    Property property = properties[index];
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
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),

                                //   color: Color(0xFFF4F5F6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F1F1),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            property.photos.length>0?property.photos[0]:
                                            "https://res.cloudinary.com/dfng74ru6/image/upload/v1700421967/640x360_rcv22m.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(defaultPadding/2),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          property.name,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          property.description,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "${property.price} F CFA",
                                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                      color: primaryColor
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
