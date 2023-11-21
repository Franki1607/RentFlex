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

  FirebaseCore firebaseCore = FirebaseCore.instance;

}
