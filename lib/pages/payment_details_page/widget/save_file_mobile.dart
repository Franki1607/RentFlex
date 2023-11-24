import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
///To save the pdf file in the device
Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  //Get the storage folder location using path_provider package.
  String? path;
  if (Platform.isAndroid ||
      Platform.isIOS ||
      Platform.isLinux ||
      Platform.isWindows) {
    final Directory directory =
        await path_provider.getApplicationSupportDirectory();
    path = directory.path;
  } else {
    path = await PathProviderPlatform.instance.getApplicationSupportPath();
  }
  final File file =
      File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  if (Platform.isAndroid || Platform.isIOS) {
    //Launch the file (used open_file package)
    // Old -----------------
    // if(await requestPermission(Permission.storage)){
    //   await open_file.OpenFile.open('$path/$fileName');
    // }else{
    //   Get.snackbar(
    //     'Erreur',
    //     'Vous devez autoriser l\'accès au stockage pour pouvoir télécharger le fichier',
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    // }
    // New -----------------
    final pickedDirectory = await FlutterFileDialog.pickDirectory();

    if (pickedDirectory != null) {
      final filePath = await FlutterFileDialog.saveFileToDirectory(
        directory: pickedDirectory!,
        data: Uint8List.fromList(bytes),
        mimeType: "application/pdf",
        fileName: "$fileName",
        replace: true,
      );
      print("------------------------------------");
      print(pickedDirectory);
      if(await requestPermission(Permission.storage)){
      	try{
      	
	   final result =await open_file.OpenFilex.open('$path/$fileName');
	   print(result.type);
	   print(result.message);
      	}catch (e){
           print("Here");
      	   print(e);
        }
      }else{
         Get.snackbar(
           'Erreur',
           'Vous devez autoriser l\'accès au stockage pour pouvoir télécharger le fichier',
           backgroundColor: Colors.red,
           colorText: Colors.white,
         );
      }
    }
  } else if (Platform.isWindows) {
    await Process.run('start', <String>['$path\\$fileName'], runInShell: true);
  } else if (Platform.isMacOS) {
    await Process.run('open', <String>['$path/$fileName'], runInShell: true);
  } else if (Platform.isLinux) {
    await Process.run('xdg-open', <String>['$path/$fileName'],
        runInShell: true);
  }

}

Future<bool> requestPermission(Permission permission) async {
  var status = await permission.status;
  if (status.isGranted) {
    return true;
  } else if (status.isDenied || status.isPermanentlyDenied) {
    var result = await permission.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
