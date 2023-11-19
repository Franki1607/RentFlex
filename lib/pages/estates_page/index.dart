import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forms/create_property_form.dart';
import 'package:uuid/uuid.dart';
import '../../models/property.dart';
import 'controllers/estates_controller.dart';

class EstatesPage extends GetWidget<EstatesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("estates".tr),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
      body: GetBuilder<EstatesController>(
        builder: (_) => StreamBuilder<List<Property>>(
          stream: controller.firebaseCore.getAllPropertiesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("Data");
              print(snapshot.data);
              List<Property> properties = snapshot.data!;
              return ListView.builder(
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  Property property = properties[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                spreadRadius: 0.2,
                                blurRadius: 0.5)
                          ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Stack(
                              //   children: <Widget>[

                              //   ],
                              // ),
                              Container(
                                height: 140.0,
                                color: Colors.yellow,
                                child: Container(
                                  height: 140.0,
                                  width: MediaQuery.of(context).size.width / 2.1,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    image: DecorationImage(
                                        image: NetworkImage("http://via.placeholder.com/640x360"),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Container(
                                    height: 140.0,
                                    color: Colors.black12.withOpacity(0.3),
                                    child: Center(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 50.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left: 8.0, right: 3.0, top: 15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2.7,
                                  child: Text(
                                    property.name,
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.5),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 5.0, bottom: 15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2.7,
                                  child: Text(
                                    property.description,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Sofia",
                                        color: Colors.black38),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      )
    );
  }
}
