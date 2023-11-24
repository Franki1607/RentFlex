import 'dart:async';
import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_flex/api/firebase/firebase_config.dart';
import 'package:rent_flex/api/momo_open_api/mtn_momo_api.dart';
import 'package:rent_flex/api/momo_open_api/mtn_momo_models.dart';
import 'package:rent_flex/models/momo_transaction.dart';
import 'package:uuid/uuid.dart';
import '../../models/contract.dart';
import '../../models/payment.dart';
import '../../models/property.dart';
import '../../models/user.dart' as mUser;
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/transaction.dart' as mTransaction;


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
    momoConfigCollection: 'momoconfig',
    momoTransactionCollection: 'momoTransactions',
    paymentCollection: 'payments',
    transactionCollection: 'transactions',
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

  Future<Property> getProperty(String uid) async {
    try {
      QuerySnapshot querySnapshot = await myFirebaseFirestore()
          .collection(config.propertyCollection)
          .where("uid", isEqualTo: uid)
          .get();
      return Property.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
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

  Future<Contract?> getContract(String propertyId) async {
    try {
      var doc = await myFirebaseFirestore().collection(config.propertyCollection).doc(propertyId).collection(config.contractCollection).where("isActive", isEqualTo: true).limit(1).get();
      print(doc.docs);
      if(!doc.docs.isEmpty){
        return Contract.fromJson(doc.docs.first.data() as Map<String, dynamic>);
      }
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

      // update property
      await myFirebaseFirestore().collection(config.propertyCollection).doc(contract.propertyId).update({
        "lastPaymentMonth": contract.startPaiementDate,
        "lastPaymentAmount": 0.0
      });
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


  //create Payment
  Future<bool> createPayment(Payment payment) async {
    try {
      await myFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(payment.propertyId)
          .collection(config.contractCollection)
          .doc(payment.contractId)
          .collection(config.paymentCollection)
          .doc(payment.uid)
          .set(payment.toJson());
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  //update Payment
  Future<bool> updatePayment(Payment payment) async {
    try {
      await myFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(payment.propertyId)
          .collection(config.contractCollection)
          .doc(payment.contractId)
          .collection(config.paymentCollection)
          .doc(payment.uid)
          .update(payment.toJson());
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  Future<Payment?> getLastPayment(String contractId) async {
    try {
      var doc = await myFirebaseFirestore().collectionGroup(config.paymentCollection).where("contractId", isEqualTo: contractId).orderBy("createdAt", descending: true).limit(1).get();
      print(doc.docs);
      if(!doc.docs.isEmpty){
        return Payment.fromJson(doc.docs.first.data() as Map<String, dynamic>);
      }
      return null;
    }catch(e){
      print(e);
      throw e;
    }
  }
  //
  Stream<List<Payment>> getAllPaymentStream(){
    try {
      if (GetStorage().read("user_role")=="owner"){
        Stream<QuerySnapshot>  querySnapshot = myFirebaseFirestore().collectionGroup(config.paymentCollection).where(
            "toNumber",isEqualTo: firebaseUser?.phoneNumber
        ).orderBy("createdAt", descending: true).snapshots();

        return querySnapshot.map((querySnapshot) {
          List<Payment> payments = [];
          querySnapshot.docs.forEach((doc) {
            payments.add(Payment.fromJson(doc.data() as Map<String, dynamic>));
          });
          return payments;
        });
      }else{
        Stream<QuerySnapshot>  querySnapshot = myFirebaseFirestore().collectionGroup(config.paymentCollection).where(
            "fromNumber",isEqualTo: firebaseUser?.phoneNumber
        ).orderBy("createdAt", descending: true).snapshots();

        return querySnapshot.map((querySnapshot) {
          List<Payment> payments = [];
          querySnapshot.docs.forEach((doc) {
            payments.add(Payment.fromJson(doc.data() as Map<String, dynamic>));
          });
          return payments;
        });

      }
    }catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<mTransaction.Transaction>> getAllPaymentTransaction(String paymentId) async {
    try {
      var doc = await myFirebaseFirestore().collectionGroup(config.transactionCollection).where("paymentId", isEqualTo: paymentId).get();
      return doc.docs.map((e) => mTransaction.Transaction.fromJson(e.data() as Map<String, dynamic>)).toList();
    }catch(e){
      print(e);
      throw e;
    }
  }


  //create Transaction
  Future<bool> createPaymentTransaction(mTransaction.Transaction paymentTransaction) async {
    try {
      await myFirebaseFirestore()
          .collection(config.propertyCollection)
          .doc(paymentTransaction.propertyId)
          .collection(config.contractCollection)
          .doc(paymentTransaction.contractId)
          .collection(config.paymentCollection)
          .doc(paymentTransaction.paymentId)
          .collection(config.transactionCollection)
          .doc(paymentTransaction.uid)
          .set(paymentTransaction.toJson());
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

  // create MomoTransaction
  Future<bool> createMomoTransaction(MomoTransaction momoTransaction) async {
    try {
      await myFirebaseFirestore()
          .collection(config.momoTransactionCollection).doc(momoTransaction.uid)
          .set(momoTransaction.toJson());
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  // update MomoTransaction
  Future<bool> updateMomoTransaction(MomoTransaction momoTransaction) async {
    try {
      await myFirebaseFirestore()
          .collection(config.momoTransactionCollection)
          .doc(momoTransaction.uid)
          .update(momoTransaction.toJson() as Map<String, dynamic>);
      return true;
    }catch(e){
      print(e);
      throw e;
    }
  }

  Stream<List<MomoTransaction>> getAllMomoTransactionStream(){
    try {
      if (GetStorage().read("user_role")=="owner"){
        Stream<QuerySnapshot> querySnapshotStream = myFirebaseFirestore().collectionGroup(config.momoTransactionCollection)
            .where("to", isEqualTo: firebaseUser?.phoneNumber).orderBy("date", descending: true).snapshots();

        return querySnapshotStream.map((querySnapshot){
          List<MomoTransaction> momoTransactions = [];
          querySnapshot.docs.forEach((doc) {
            momoTransactions.add(MomoTransaction.fromJson(doc.data() as Map<String, dynamic>));
          });
          return momoTransactions;
        });
      }else{
        Stream<QuerySnapshot> querySnapshotStream = myFirebaseFirestore().collectionGroup(config.momoTransactionCollection)
            .where("from", isEqualTo: firebaseUser?.phoneNumber).orderBy("date", descending: true).snapshots();
        return querySnapshotStream.map((querySnapshot) {
          List<MomoTransaction> momoTransactions = [];
          querySnapshot.docs.forEach((doc) {
            momoTransactions.add(MomoTransaction.fromJson(doc.data() as Map<String, dynamic>));
          });
          return momoTransactions;
        });
      }
    }catch(e){
      print(e);
      throw e;
    }
  }

  Stream<bool> makePayment(String propertyId, String amount, String? paymentNumber) async*{
    try {
      MtnMomoApi mtnMomoApi = await MtnMomoApi.instance;

      print("propertyId : $propertyId");

      // Get Property with propertyId
      Property property = await getProperty(propertyId);

      // Get Contract with propertyId
      Contract? contract = await getContract(propertyId);

      if (contract == null) throw Exception("CONTRACT_NOT_FOUND");

      // create MoMoTransaction Request
      MomoTransaction sendRequest = MomoTransaction(
        uid: Uuid().v4(),
      );

      // save MoMoTransaction Request on firebase
      bool isRequestSendCreated = await createMomoTransaction(sendRequest);

      if (!isRequestSendCreated) throw Exception("CAN_NOT_CREATE_PAYMENT_REQUEST");

      RequestToPay requestToPay = RequestToPay(
        amount: amount,
        currency: mtnMomoApi.config.currency,
        message: "PAYMENT_FOR_PROPERTY_${property.name.replaceAll(" ", "_")}",
        phoneNumber: paymentNumber != null ? paymentNumber : contract.tenantNumber1,
        externalId: contract.uid,
        note: "YOUR_PROPERTY_${property.name.replaceAll(" ", "_")}",
      );

      String uuid = Uuid().v4();
      sendRequest.fromTransactionId = uuid;
      sendRequest.externalId = contract.uid;
      sendRequest.type = "PAYMENT";
      sendRequest.from = paymentNumber !=null? paymentNumber : contract.tenantNumber1;
      sendRequest.propertyId = propertyId;
      sendRequest.amount = double.parse(amount);
      sendRequest.contractId = contract.uid;
      sendRequest.date = DateTime.now();

      bool update =await updateMomoTransaction(sendRequest);

      if (!update) throw Exception("INTERNAL_ERROR_PLEASE_TRY_AGAIN");

      bool isRequestToPayCreated = await mtnMomoApi.requestToPay(requestToPay, uuid);

      if (!isRequestToPayCreated) throw Exception("CAN_NOT_CREATE_PAYMENT_REQUEST");

      late StreamSubscription<PaymentStatus?> paymentSubscription;
      late PaymentStatus paymentStatus;

      final completer = Completer<void>();

      paymentSubscription = mtnMomoApi.getPaymentStatus(uuid).listen((myPaymentStatus) {
        print("Payment Verification");
        print(myPaymentStatus?.status);
        if (myPaymentStatus?.status != 'PENDING' || myPaymentStatus?.status != 'ONGOING'){
          // cancel subscription
          paymentStatus = myPaymentStatus!;
          paymentSubscription.cancel();
          completer.complete();
        }
      });

      await completer.future;

      sendRequest.status = paymentStatus.status;
      await updateMomoTransaction(sendRequest);

      print("je suis la");

      if (paymentStatus.status != 'SUCCESSFUL') throw Exception("PAYMENT_FAILED");

      MomoTransaction transferRequest = MomoTransaction(
        uid: Uuid().v4(),
      );

      // save MoMoTransaction Request on firebase
      bool isTransferRequestCreated = await createMomoTransaction(transferRequest);

      if (!isTransferRequestCreated) throw Exception("CAN_NOT_CREATE_TRANSFER_REQUEST");

      Transfer transfer = Transfer(
        amount: amount,
        currency: mtnMomoApi.config.currency,
        message: "TRANSFER_FROM_TENANT_IN_${property.name.replaceAll(" ", "_")}",
        phoneNumber: contract.ownerNumber,
        externalId: contract.uid,
        note: "YOUR_PROPERTY_${property.name.replaceAll(" ", "_")}",
      );

      String transferUid = Uuid().v4();
      transferRequest.toTransactionId = transferUid;
      transferRequest.externalId = contract.uid;
      transferRequest.type = "TRANSFER";
      transferRequest.to = contract.ownerNumber;
      transferRequest.propertyId = propertyId;
      transferRequest.amount = double.parse(amount);
      transferRequest.contractId = contract.uid;
      transferRequest.date = DateTime.now();

      print("Ici aussi");

      bool transferRequestUpdate = await updateMomoTransaction(transferRequest);

      if (!transferRequestUpdate) throw Exception("INTERNAL_ERROR_PLEASE_TRY_AGAIN");

      bool isTransferCreated = await mtnMomoApi.transfer(transfer, transferUid);

      if (!isTransferCreated) throw Exception("CAN_NOT_CREATE_TRANSFER");

      late StreamSubscription<TransferStatus?> transferSubscription;
      late TransferStatus transferStatus;

      final completerTransfer = Completer<void>();

      transferSubscription = mtnMomoApi.getTransferStatus(transferUid).listen((myTransferStatus) {
        print("Transfer Verification");
        print(myTransferStatus?.status);
        if (myTransferStatus?.status != 'pending' || myTransferStatus?.status != 'ongoing'){
          // cancel subscription
          transferStatus = myTransferStatus!;
          transferSubscription.cancel();
          completerTransfer.complete();
        }
      });

      await completerTransfer.future;

      transferRequest.status = transferStatus.status;
      await updateMomoTransaction(transferRequest);

      if (transferStatus.status != 'SUCCESSFUL') throw Exception("TRANSFER_FAILED");

      Get.showSnackbar(GetSnackBar(
        title: 'Success'.tr,
      message: "PAYMENT_SUCCESS".tr,
        icon: Icon(BootstrapIcons.check_circle_fill, color: Colors.green),
        duration: Duration(seconds: 2),
      ));

      await createPaymentAndTransaction(contract, property, amount, sendRequest.uid);

      print ("Good job");

      yield true;


    }catch(e){
      print(e);
      Get.showSnackbar(GetSnackBar(
        title: 'Error'.tr,
        message: e.toString().tr,
        icon: Icon(Icons.error, color: Colors.red),
        duration: Duration(seconds: 2),
      ));
      yield false;
    }

  }

  Future<bool> createPaymentAndTransaction(Contract contract, Property property, String amount, String transactionId) async {

    try{

      double amountPayed = double.parse(amount);
      double pricePerMonth = property.price;
      DateTime startMonth = contract.startPaiementDate;

      Payment? payment = await getLastPayment(contract.uid);

      print("payment : $payment");
      if (payment == null) {

        for (int i = 0; i < int.parse("${(amountPayed/pricePerMonth).ceil()}"); i++) {
            if (i!=0) {
              startMonth = startMonth.add(Duration(
                  days: DateTime(startMonth.year, startMonth.month + 1, 0).day));
            }else {
              startMonth = startMonth.add(Duration(
                  days: DateTime(startMonth.year, startMonth.month + 1, 0).day));
            }
            amountPayed = (amountPayed - pricePerMonth)>=0 ? amountPayed - pricePerMonth : amountPayed;
            String paymentId = Uuid().v4();
            await createPayment(new Payment(
              uid: paymentId,
              contractId: contract.uid,
              propertyId: property.uid,
              fromNumber: "${contract.tenantNumber1}",
              toNumber: "${contract.ownerNumber}",
              amount: amountPayed<=property.price? "${amountPayed}": "${property.price}",
              monthlyDate: startMonth,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ));

            await createPaymentTransaction(new mTransaction.Transaction(
                uid: Uuid().v4(),
                propertyId: property.uid,
                contractId: contract.uid,
                amount: amountPayed<=property.price? "${amountPayed}": "${property.price}",
                paymentId: paymentId,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                transactionId: transactionId
            ));
          }
        // update property
        property.lastPaymentAmount = amountPayed;
        property.lastPaymentMonth = startMonth;
        await updateProperty(property);

        return true;
      }else{
        // get payment amount
        if (double.parse(payment.amount )+ amountPayed <= property.price) {
          // update payment amount
          await updatePayment(new Payment(
            uid: payment.uid,
            contractId: contract.uid,
            propertyId: property.uid,
            fromNumber: "${contract.tenantNumber1}",
            toNumber: "${contract.ownerNumber}",
            amount: "${double.parse(payment.amount) + amountPayed}",
            monthlyDate: startMonth,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ));

          await createPaymentTransaction(new mTransaction.Transaction(
              uid: Uuid().v4(),
              propertyId: property.uid,
              contractId: contract.uid,
              amount: "$amountPayed",
              paymentId: payment.uid,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              transactionId: transactionId
          ));

          // update property
          property.lastPaymentAmount = double.parse(payment.amount) + amountPayed;
          property.lastPaymentMonth = startMonth;
          await updateProperty(property);

          return true;

        }else{


          double priceToCloseMonth = property.price - double.parse(payment.amount);
          print("Au debut on a $amountPayed");
          print("Pour clotuer la mois on a besoin de  $priceToCloseMonth");
          await updatePayment(new Payment(
            uid: payment.uid,
            contractId: contract.uid,
            propertyId: property.uid,
            fromNumber: "${contract.tenantNumber1}",
            toNumber: "${contract.ownerNumber}",
            amount: "${property.price }",
            monthlyDate: startMonth,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ));

          await createPaymentTransaction(new mTransaction.Transaction(
              uid: Uuid().v4(),
              propertyId: property.uid,
              contractId: contract.uid,
              amount: "${priceToCloseMonth}",
              paymentId: payment.uid,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              transactionId: transactionId
          ));

          double surplusAmount = amountPayed - priceToCloseMonth;

          print("Donc il reste $surplusAmount");
          print("Pour le mois $startMonth");

          do {
            startMonth = startMonth.add(Duration(
                days: DateTime(startMonth.year, startMonth.month + 1, 0).day));
            surplusAmount = (surplusAmount - pricePerMonth) >= 0
                ? surplusAmount - pricePerMonth
                : surplusAmount;
            print("On a $surplusAmount");
            String paymentId = Uuid().v4();
            await createPayment(new Payment(
              uid: paymentId,
              contractId: contract.uid,
              propertyId: property.uid,
              fromNumber: "${contract.tenantNumber1}",
              toNumber: "${contract.ownerNumber}",
              amount: "${surplusAmount}",
              monthlyDate: startMonth,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ));

            await createPaymentTransaction(new mTransaction.Transaction(
                uid: Uuid().v4(),
                propertyId: property.uid,
                contractId: contract.uid,
                amount: "${surplusAmount}",
                paymentId: paymentId,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                transactionId: transactionId
            ));
            if (surplusAmount < pricePerMonth) break;
          } while (surplusAmount > 0);

          // update property
          property.lastPaymentAmount = surplusAmount;
          print("Mois mis à jour $startMonth");
          property.lastPaymentMonth = startMonth;
          await updateProperty(property);

          return true;

        }
      }

    }catch(e){
      print(e);
      throw e;
    }

    return false;

  }

  void savePreferences(mUser.User user) async {
    print("Saving preferences");
    await GetStorage().write('user_first_name', user.firstName);
    await GetStorage().write('user_last_name', user.lastName);
    await GetStorage().write('user_role', user.role);
    await GetStorage().write('user_photo_url', user.photoURL);
  }

  void deletePreferences() async {
    print("Deleting preferences");
    await GetStorage().remove('user_first_name');
    await GetStorage().remove('user_last_name');
    await GetStorage().remove('user_role');
    await GetStorage().remove('user_photo_url');
  }

  void logout() async {
    print("Logging out");
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
    deletePreferences();
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

