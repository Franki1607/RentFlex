import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../api/firebase/firebase_core.dart';
import '../../../models/property.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EstatesController extends GetxController {

  FirebaseCore firebaseCore = FirebaseCore.instance;

  final formKey = GlobalKey<FormBuilderState>();

  final isSaveLoading = false.obs;

  void setSaveLoading(bool value) {
    isSaveLoading(value);
  }

  void saveProperty() async {
    isSaveLoading(true);
    try {
      if (images.value.length> 0) {
        await uploadImages();
      }
      firebaseCore.createProperty(
          new Property(
              uid: Uuid().v4(), ownerId: "${firebaseCore.firebaseUser?.uid}",
              name:formKey.currentState?.fields['name']?.value,
              description:formKey.currentState?.fields['description']?.value,
              country:formKey.currentState?.fields['country']?.value,
              department:formKey.currentState?.fields['department']?.value,
              neighborhood:formKey.currentState?.fields['neighborhood']?.value,
              address:formKey.currentState?.fields['address']?.value,
              price: double.parse("${formKey.currentState?.fields['price']?.value}"),
              minPrice: double.parse("${formKey.currentState?.fields['minPrice']?.value}"),
              type: formKey.currentState?.fields['type']?.value,
              numberOfSaloons: int.parse("${formKey.currentState?.fields['numberOfSaloons']?.value??0}"),
              numberOfBathrooms: int.parse("${formKey.currentState?.fields['numberOfBathrooms']?.value??0}"),
              numberOfBedrooms: int.parse("${formKey.currentState?.fields['numberOfBedrooms']?.value??0}"),
              numberOfFloors: int.parse("${formKey.currentState?.fields['numberOfFloors']?.value??0}"),
              numberOfGarages: int.parse("${formKey.currentState?.fields['numberOfGarages']?.value??0}"),
              numberOfkitchens: int.parse("${formKey.currentState?.fields['numberOfkitchens']?.value??0}"),
              other: formKey.currentState?.fields['other']?.value??"",
              photos: imageUrls,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()
          )
      );
      isSaveLoading(false);
      Get.back();
    }catch(e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: 'Please try again',
        icon: Icon(Icons.error, color: Colors.red),
        duration: Duration(seconds: 2),
      ));
      print(e);
      isSaveLoading(false);
    }
  }

  RxList<File> images = RxList([]);
  List<String> imageUrls = [];

  //add images
  void addImage(File image) {
    images.value.add(image);
    update();
  }

  void deleteImage(int index) {
    images.value.removeAt(index);
    update();
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      images.value += result.paths.map((path) => File(path!)).toList();
      update();
      //uploadImages();
    } else {
      // User canceled the picker
    }
  }

  RxList<firebase_storage.UploadTask> tasks = <firebase_storage.UploadTask>[].obs;

  Future<void> uploadImages() async {
    for (var image in images) {
      try {
        firebase_storage.UploadTask task = uploadFile(image);
        tasks.add(task);
        await task.whenComplete(() async {
          String url = await storage.ref('uploads/${image.path.split('/').last}').getDownloadURL();
          imageUrls.add(url);
        });
      } catch (e) {
        // Handle upload error
      }
    }
  }

  firebase_storage.UploadTask uploadFile(File file) {
    firebase_storage.UploadTask task = storage
        .ref('uploads/${file.path.split('/').last}')
        .putFile(file);
    return task;
  }
  void navigateBack() => Get.back();
}
