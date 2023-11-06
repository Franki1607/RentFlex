import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseAuthenfication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
