import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rent_flex/init_and_register.dart';
import '/providers/theme/theme.dart';
import '/providers/theme/theme_provider.dart';
import '/routers/routes.dart';

import 'local_lang/translator.dart';

void main() async{
  await InitAndRegister().initialize();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider();
    return GetMaterialApp(
        navigatorKey: Get.key,
        translations: Translator(),
        locale: Get.deviceLocale,
        debugShowCheckedModeBanner: false,
        title: 'Swift Starter',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeProvider.theme,
        initialRoute: '/splash',
        getPages: AppRouter.routes
    );
  }
}