// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCzdEVqKfK34au9-t92BV1wlmkKTvjRen4',
    appId: '1:756416253347:web:5f4c58b1d02eb856821e16',
    messagingSenderId: '756416253347',
    projectId: 'rentflex-237738',
    authDomain: 'rentflex-237738.firebaseapp.com',
    storageBucket: 'rentflex-237738.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKxiGArbA1sIEPPwn_xE1XO24TBSXjcNI',
    appId: '1:756416253347:android:02991d063bb47883821e16',
    messagingSenderId: '756416253347',
    projectId: 'rentflex-237738',
    storageBucket: 'rentflex-237738.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDn9epHyBnW0FwHxdcaPJnugIywTttxFQ4',
    appId: '1:756416253347:ios:63af99a6ded7f651821e16',
    messagingSenderId: '756416253347',
    projectId: 'rentflex-237738',
    storageBucket: 'rentflex-237738.appspot.com',
    iosBundleId: 'com.findev.rentFlex',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDn9epHyBnW0FwHxdcaPJnugIywTttxFQ4',
    appId: '1:756416253347:ios:8efa47161043f359821e16',
    messagingSenderId: '756416253347',
    projectId: 'rentflex-237738',
    storageBucket: 'rentflex-237738.appspot.com',
    iosBundleId: 'com.findev.rentFlex.RunnerTests',
  );
}
