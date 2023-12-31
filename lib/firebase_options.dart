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
    apiKey: 'AIzaSyAi-nnET8-2kY4--KPoXHVd0XzkD0D1S-4',
    appId: '1:30672406437:web:bdae5995887e5b160e0a4c',
    messagingSenderId: '30672406437',
    projectId: 'rewind-6e900',
    authDomain: 'rewind-6e900.firebaseapp.com',
    storageBucket: 'rewind-6e900.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHl45uRuscDtC3Rif6FLa3uIvLCBjV2to',
    appId: '1:30672406437:android:4827904d56a095c60e0a4c',
    messagingSenderId: '30672406437',
    projectId: 'rewind-6e900',
    storageBucket: 'rewind-6e900.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDe78IReaTsHW5gg270Reb2BTJlDuO1vxQ',
    appId: '1:30672406437:ios:4d6f55c4a0ee20f00e0a4c',
    messagingSenderId: '30672406437',
    projectId: 'rewind-6e900',
    storageBucket: 'rewind-6e900.appspot.com',
    iosBundleId: 'com.example.rewind',
  );
}
