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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDPvQvBT96kVKayg5gRiTbxZrCqM1K-tZk',
    appId: '1:815384566673:web:5c1b0e0c22acc2f454d830',
    messagingSenderId: '815384566673',
    projectId: 'innstagram-clone-app',
    authDomain: 'innstagram-clone-app.firebaseapp.com',
    storageBucket: 'innstagram-clone-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDV2EyYMi1R38IWuDpAM3pXwoDQIyzldIA',
    appId: '1:815384566673:android:faff09f86016a6ca54d830',
    messagingSenderId: '815384566673',
    projectId: 'innstagram-clone-app',
    storageBucket: 'innstagram-clone-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwh5xMdw5XANMPB2z4jItjXb6daXnFGuw',
    appId: '1:815384566673:ios:5a1ff0ac87ef432654d830',
    messagingSenderId: '815384566673',
    projectId: 'innstagram-clone-app',
    storageBucket: 'innstagram-clone-app.appspot.com',
    iosClientId: '815384566673-ifcjiep9bv5h2ohjfujq6euh741cf2f2.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramCloneCoding',
  );
}
