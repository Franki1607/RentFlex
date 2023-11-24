import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants.dart';
import 'controllers/profile_controller.dart';

class ProfilePage extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("profile".tr, style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: GetBuilder<ProfileController>(
          builder: (_) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: defaultPadding*3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: defaultPadding*6,
                        width: defaultPadding*6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                            border: Border.all(color: Colors.white, width: 2.0),
                            image: DecorationImage(
                                image: NetworkImage("https://res.cloudinary.com/dfng74ru6/image/upload/v1700353755/blank-profile_jitnpg.png"),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding/2,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 240,
                        child: Text("${GetStorage().read("user_first_name")?? "User"} ${GetStorage().read("user_last_name")?? "User"}", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )),
                      SizedBox(
                        height: defaultPadding/4,
                      ),
                      Container(
                        width: 240,
                        child: Text("${controller.firebaseCore.firebaseUser?.phoneNumber}",
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )),

                    ],
                  ),
                  SizedBox(
                    height: defaultPadding*2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultPadding),
                        border: Border.all(color: Colors.grey, width: 1.0)
                      ),
                      child: ListTile(
                        onTap: () {
                          controller.changeLanguage();
                        },
                        leading: Container(
                          height: defaultPadding*2,
                          width: defaultPadding*2,
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(defaultPadding)
                          ),
                          child: Icon(
                            BootstrapIcons.translate,
                            color: Colors.black

                          ),

                        ),
                        title: Text("language".tr),
                        subtitle: Text("${(GetStorage().read("locale")??"fr_FR") == "fr_FR"? "french".tr: "english".tr}".tr, style: Theme.of(context).textTheme.caption, overflow: TextOverflow.ellipsis,),
                        trailing: Icon(BootstrapIcons.chevron_right),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultPadding),
                        border: Border.all(color: Colors.grey, width: 1.0)
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed("/notifications");
                        },
                        leading: Container(
                          height: defaultPadding*2,
                          width: defaultPadding*2,
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(defaultPadding)
                          ),
                          child: Icon(
                            BootstrapIcons.bell_fill,
                            color: Colors.black

                          ),

                        ),
                        title: Text("Notifications".tr),
                        subtitle: Text("your_notifications".tr, style: Theme.of(context).textTheme.caption, overflow: TextOverflow.ellipsis,),
                        trailing: Icon(BootstrapIcons.chevron_right),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultPadding),
                        border: Border.all(color: Colors.grey, width: 1.0)
                      ),
                      child: ListTile(
                        onTap: () {
                          controller.firebaseCore.logout();
                        },
                        leading: Container(
                          height: defaultPadding*2,
                          width: defaultPadding*2,
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(defaultPadding)
                          ),
                          child: Icon(
                            BootstrapIcons.box_arrow_in_right,
                            color: Colors.black

                          ),

                        ),
                        title: Text("logout".tr),
                        subtitle: Text("logout_hint".tr, style: Theme.of(context).textTheme.caption, overflow: TextOverflow.ellipsis,),
                        trailing: Icon(BootstrapIcons.chevron_right),
                      ),
                    ),
                  ),

                ]
              ),
            ),
          ),
        ));
  }
}
