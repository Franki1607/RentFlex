import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_flex/pages/profile_page/controllers/profile_controller.dart';

class SelectLanguageModal extends GetWidget<ProfileController> {
  const SelectLanguageModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('select_language'.tr, style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center),
              ],
            ),
          ),
          ListTile(
            leading: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Flag.fromString('US', height: 36, width: 36, fit: BoxFit.fill)),
            ),
            title: Text('english'.tr),
            onTap: () => controller.updateLocale(Locale('en', 'US')),
          ),
          ListTile(
            leading: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Flag.fromString('FR', height: 36, width: 36, fit: BoxFit.fill)),
            ),
            title: Text('french'.tr),
            onTap: () => controller.updateLocale(Locale('fr', 'FR')),
          )
        ],
      ),
    );
  }
}