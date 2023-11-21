import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/api/firebase/firebase_config.dart';
import 'package:rent_flex/api/momo_open_api/mtn_momo_models.dart';
import '../../models/contract.dart';
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
    contractCollection: 'contracts',
    momoConfigCollection: 'momoconfig'
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
        duration: Duration(seconds: 2),
      ));
      return null;
    }
  }

  // Gets proper [FirebaseFirestore] instance.
  FirebaseFirestore myFirebaseFirestore() => config.appName != null
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
      var doc = await myFirebaseFirestore().collection(config.userCollection).where("phoneNumber", isEqualTo: firebaseUser!.phoneNumber).limit(1).get();

      if(doc.docs.isEmpty){

        print("C'est parce que j'ai pas d'utilisateur ${firebaseUser!.phoneNumber}");
        return false;
      }
      mUser.User user = mUser.User.fromMap(doc.docs.first.data());

      savePreferences(user);
      return true;
    }catch(e){
      throw e;
    }
  }

  // Get MtnMomoCon
  Stream<MoMoApiConfig> getMtnMomoConfigStream()  {
    try {
      print("Stream is called");
      Stream<QuerySnapshot> querySnapshot=  myFirebaseFirestore().collection(config.momoConfigCollection).snapshots();
      print(querySnapshot);
      return querySnapshot.map((querySnapshot) {
        print(querySnapshot.docs.first.data());
        return MoMoApiConfig.fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>);
      });
    } catch (e) {
      throw e;
    }
  }

  Future <MoMoApiConfig> getMtnMomoConfig()  {
    try {
      Stream<QuerySnapshot> querySnapshot=  myFirebaseFirestore().collection(config.momoConfigCollection).snapshots();
      print(querySnapshot);
      return querySnapshot.map((querySnapshot) {
        print(querySnapshot.docs.first.data());
        return MoMoApiConfig.fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>);
      }).first;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> updateFirstMtnMomoConfig(MoMoApiConfig mtnMomoConfig) async {
    try {
      await myFirebaseFirestore().collection(config.momoConfigCollection).get().then((value) {
        value.docs.first.reference.update(mtnMomoConfig.toMap());
      });
      return true;
    } catch (e) {
      throw e;
    }
  }

  // Create User
  Future<bool> createDBUser(mUser.User user) async {
    user.uid = firebaseUser!.uid;
    try {
      await myFirebaseFirestore()
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
      await myFirebaseFirestore()
          .collection(config.propertyCollection)
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
      await myFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(firebaseUser?.uid)
          .collection(config.propertyCollection)
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
      await myFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(firebaseUser?.uid)
          .collection(config.propertyCollection)
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
      if (GetStorage().read("user_role")=="owner"){
        print("It's owner");
        Stream<QuerySnapshot> querySnapshotStream = myFirebaseFirestore()
            .collection(config.propertyCollection).where("ownerId", isEqualTo: firebaseUser?.uid)
            .snapshots();

        return querySnapshotStream.map((querySnapshot) {
          List<Property> properties = [];
          querySnapshot.docs.forEach((doc) {
            properties.add(Property.fromJson(doc.data() as Map<String, dynamic>));
          });
          return properties;
        });
      }else if(GetStorage().read("user_role")=="tenant"){
        print("It's tenant");

        return myFirebaseFirestore()
            .collectionGroup(config.contractCollection)
            .where("tenantNumber1", isEqualTo: firebaseUser?.phoneNumber)
            .where("isActive", isEqualTo: true)
            .snapshots()
            .asyncMap((querySnapshot) async {
          List<Property> properties = [];
          for (var doc in querySnapshot.docs) {
            DocumentSnapshot propertyDoc = await myFirebaseFirestore()
                .collection(config.propertyCollection)
                .doc(doc.reference.parent.parent!.id)
                .get();
            properties.add(Property.fromJson(propertyDoc.data() as Map<String, dynamic>));
          }
          return properties;
        });
      } else {
        print("It's inconnue");
        // logout user
        return Stream.empty();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> existantContract(String propertyId) async {
    try {
      var doc = await myFirebaseFirestore().collectionGroup(config.contractCollection).where("propertyId", isEqualTo: propertyId).where("isActive", isEqualTo: true).limit(1).get();
      print(doc.docs);
      if(!doc.docs.isEmpty){
        return true;
      }
      return false;
    }catch(e){
      print(e);
      throw e;
    }
  }

  //create Contract
  Future<int> createContract(Contract contract) async {
    try {
      // check if we have a active contract for this property
      bool exist = await existantContract(contract.propertyId);

      if (exist){
        return -1;
      }
      await myFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(contract.propertyId)
          .collection(config.contractCollection)
          .doc(contract.uid)
          .set(contract.toJson());
      return 1;
    }catch(e){
      print(e);
      throw e;
    }
  }

  //update Contract
  Future<bool> updateContract(Contract contract) async {
    try {
      await myFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(contract.propertyId)
          .collection(config.contractCollection)
          .doc(contract.uid)
          .update(contract.toJson());
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  //delete Contract
  Future<bool> deleteContract(String uid) async {
    try {
      await myFirebaseFirestore()
          .collection(config.propertyCollection).get().then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              doc.reference.collection(config.contractCollection).doc(uid).get().then((value) {
                if (value.exists){
                  value.reference.delete();
                }
              });
            });
        });
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  //get Contract
  Stream<List<Contract>> getAllContractsStream() {
    try {
      if (GetStorage().read("user_role")=="owner"){

        Stream<QuerySnapshot> querySnapshotStream = myFirebaseFirestore()
            .collectionGroup(config.contractCollection).where("ownerId", isEqualTo: firebaseUser?.uid)
            .snapshots();
        return querySnapshotStream.map((querySnapshot) {
          List<Contract> contracts = [];
          querySnapshot.docs.forEach((doc) {
            contracts.add(Contract.fromJson(doc.data() as Map<String, dynamic>));
          });
          return contracts;

        });
      } else if (GetStorage().read("user_role")=="tenant"){

        Stream<QuerySnapshot> querySnapshotStream = myFirebaseFirestore()
            .collectionGroup(config.contractCollection).where("tenantNumber1", isEqualTo: firebaseUser?.phoneNumber)
            .snapshots();
        return querySnapshotStream.map((querySnapshot) {
          List<Contract> contracts = [];
          querySnapshot.docs.forEach((doc) {
            contracts.add(Contract.fromJson(doc.data() as Map<String, dynamic>));
          });
          return contracts;

        });
      } else {
        // logout user
        return Stream.empty();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void savePreferences(mUser.User user) async {
    print("Saving preferences");
    await GetStorage().write('user_first_name', user.firstName);
    await GetStorage().write('user_last_name', user.lastName);
    await GetStorage().write('user_role', user.role);
    await GetStorage().write('user_photo_url', user.photoURL);
  }
  // FirebaseFirestore.instance
  //     .collection('properties')
  //     .get()
  //     .then((QuerySnapshot querySnapshot) {
  // querySnapshot.docs.forEach((doc) {
  // FirebaseFirestore.instance
  //     .collection('properties')
  //     .doc(doc.id)
  //     .collection('contracts')
  //     .get()
  //     .then((QuerySnapshot contractSnapshot) {
  // contractSnapshot.docs.forEach((contractDoc) {
  // if (contractDoc['active'] && contractDoc['phoneNumber'] == '67016623') {
  // print('Property ID: ${doc.id}');
  // }
  // });
  // });
  // });
  // });



}

