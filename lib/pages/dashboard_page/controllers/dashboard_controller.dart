import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../api/firebase/firebase_core.dart';

class DashboardController extends GetxController {
  void navigateBack() => Get.back();

  final formKey = GlobalKey<FormBuilderState>();

  final isSaveLoading = false.obs;

  void setSaveLoading(bool value) {
    isSaveLoading(value);
  }

  FirebaseCore firebaseCore = FirebaseCore.instance;
  List<File> images = [];

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      images = result.paths.map((path) => File(path!)).toList();
      update();
      uploadImages();
    } else {
      // User canceled the picker
    }
  }

  RxList<firebase_storage.UploadTask> tasks = <firebase_storage.UploadTask>[].obs;

  void uploadImages() async {
    for (var image in images) {
      try {
        tasks.add(uploadFile(image));
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
}
