import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_flex/models/property.dart';
import 'package:rent_flex/pages/dashboard_page/forms/create_property_form.dart';
import 'package:rent_flex/pages/dashboard_page/widgets/tenants_view.dart';
import 'package:uuid/uuid.dart';
import '../../constants.dart';
import 'controllers/dashboard_controller.dart';

class DashboardPage extends GetWidget<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return true? Scaffold(
      body: GetBuilder<DashboardController>(
        builder: (_) => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("images/background.png"),


                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 170.0, bottom: 30.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 5 / 10,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        height: 220.0,
                      ),
                      items: [0, 1, 2, 3, 4].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 220.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF31A1C9), Color(0xFF3DB6D4)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(defaultRadius*2)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Text(
                                            "Immeuble Midombo",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Color(0xFF1F1F1F),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Text(
                                            "1000 / 45000 FCFA",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Sans",
                                                fontSize: 20.0),
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          LinearProgressIndicator(
                                            value: 0.5,
                                            backgroundColor: Colors.white,
                                            minHeight: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "Jipau Dev",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Sans",
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    "Date",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w300,
                                                      fontFamily: "Sans",
                                                    ),
                                                  ),
                                                  Text(
                                                    "07/21",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Sans",
                                                        fontSize: 16.0),
                                                  )
                                                ],
                                              ),
                                            ],
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
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.only(top: 72.0, left: 22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 53.0,
                            width: 53.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(color: Colors.white, width: 2.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/4091205/pexels-photo-4091205.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
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
                                "Kathleen Walker",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17.0,
                                    color: Colors.white),
                              ),
                              Text(
                                "Member Since 18 2016",
                                style: TextStyle(
                                    fontFamily: "Sans",
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white54),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                ]
              )
            ],
          ),

        )
      )
    ): Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 78.0),
        child: FloatingActionButton(
          onPressed: () {
            controller.firebaseCore.createProperty(new Property(uid: Uuid().v4(), ownerId: "${controller.firebaseCore.firebaseUser?.uid}", name: "Maison Mikwabo C4", description: "Ceci est une description", country: "Bénin", department: "Littoral", neighborhood: "Agla Hlazounto", address: '500 m de la pharmacie Lulu Lulu', price: 300000, minPrice: 2000, type: "room", other: "", photos: []));
          }
        ),
      ),
        body: GetBuilder<DashboardController>(
          builder: (_) => true? TenantView(): Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding:
                          EdgeInsets.only(top: defaultPadding*2,right: defaultPadding, left: defaultPadding),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    text: "Hello,\n",
                                    style: TextStyle(
                                        color: Colors.black,fontSize: 17.0),
                                    children: [
                                      TextSpan(
                                        text: "Brestley Hadwey",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19.0,
                                          height: 1.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(Radius.circular(150))),
                                ),
                              ],
                            ),
                          )
                      )
                  ),
                ],
              )
          ),
        )
    );
  }
}
