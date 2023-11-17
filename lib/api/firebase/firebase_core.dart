import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_flex/api/firebase/firebase_config.dart';
import '../../models/property.dart';
import '../../models/user.dart' as mUser;
import 'package:firebase_storage/firebase_storage.dart';


class FirebaseCore {
  FirebaseCore._privateConstructor() {
    // listen user change
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      firebaseUser = user;
    });
  }

  FirebaseConfig config = FirebaseConfig(
    userCollection: 'users',
    propertyCollection: 'properties',
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser = FirebaseAuth.instance.currentUser;

  FirebaseStorage  storage = FirebaseStorage.instance;

  // Singleton instance.
  static final FirebaseCore instance = FirebaseCore._privateConstructor();


  // Send verification code
  Future<void> sendVerificationCode(
      String phoneNumber, Function(String verificationId) codeSent, Function() verificationFailed, Function() codeAutoRetrievalTimeout) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
      },
      verificationFailed: (FirebaseAuthException e) {
        verificationFailed();
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        codeAutoRetrievalTimeout();
      },
    );
  }

  // Sign in with phone number
  Future<User?> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      return user;
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Invalid code',
        message: 'Please try again',
        icon: Icon(Icons.error, color: Colors.red),
      ));
      return null;
    }
  }

  // Gets proper [FirebaseFirestore] instance.
  FirebaseFirestore getFirebaseFirestore() => config.appName != null
      ? FirebaseFirestore.instanceFor(
        app: Firebase.app(config.appName!),
      )
      : FirebaseFirestore.instance;

  // Set config
  void setConfig(FirebaseConfig fireConfig) {
    config = fireConfig;
  }

  Future<bool> isUserExist() async{
    print("Anhan \n Moi j'ai été appelé ohhhh");
    if(firebaseUser == null){
      print("C'est à cause de moi");
      return false;
    }
    try{
      var doc = await getFirebaseFirestore().collection(config.userCollection).where("phoneNumber", isEqualTo: firebaseUser!.phoneNumber).limit(1).get();

      if(doc.docs.isEmpty){
        print("C'est parce que j'ai pas d'utilisateur ${firebaseUser!.phoneNumber}");
        return false;
      }
      return true;
    }catch(e){
      throw e;
    }
  }

  // Create User
  Future<bool> createDBUser(mUser.User user) async {
    user.uid = firebaseUser!.uid;
    try {
      await getFirebaseFirestore()
          .collection(config.userCollection)
          .doc(firebaseUser?.uid)
          .set(user.toMap());
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  // upload profile image
  Future<String> uploadImage(String imagePath) async {
    File photo = File(imagePath);
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    String filename = uniqueFileName+photo.path.split('/').last;
    String destination = 'images/$filename';

    try {
      final ref = storage
          .ref(destination);
      await ref.putFile(photo);

      String url = await ref.getDownloadURL();

      return url;
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: "Can not upload image",
      ));
      print('Tcho envoie le fichier non!!!!!!!');
      throw e;
    }
  }

  //properties Crud

  Future<bool> createProperty(Property property) async {
    //property.uid = firebaseUser!.uid;
    try {
      await getFirebaseFirestore()
          .collection("properties")
          .doc(property.uid)
          .set(property.toJson());
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  Future<bool> deleteProperty(String uid) async {
    try {
      await getFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(firebaseUser?.uid)
          .collection("properties")
          .doc(uid)
          .delete();
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  Future<bool> updateProperty(Property property) async {
    try {
      await getFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(firebaseUser?.uid)
          .collection("properties")
          .doc(property.uid)
          .update(property.toJson());
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  Stream<List<Property>> getAllPropertiesStream() {
    try {
      Stream<QuerySnapshot> querySnapshotStream = getFirebaseFirestore()
          .collection("properties").where("ownerId", isEqualTo: firebaseUser?.uid)
          .snapshots();
      return querySnapshotStream.map((querySnapshot) {
        List<Property> properties = [];
        querySnapshot.docs.forEach((doc) {
          properties.add(Property.fromJson(doc.data() as Map<String, dynamic>));
        });
        return properties;
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }


}