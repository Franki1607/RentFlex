import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../models/property.dart';
import '../controllers/dashboard_controller.dart';

class TenantView extends GetWidget<DashboardController>{
  const TenantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Property>>(
      stream: controller.firebaseCore.getAllPropertiesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("Data");
          print(snapshot.data);
          List<Property> properties = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(top:80.0),
            child: ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                Property property = properties[index];
                return ListTile(
                  title: Text(property.description, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                  subtitle: Text(property.description),
                  // Add more widgets to display other property details
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );;
  }
}