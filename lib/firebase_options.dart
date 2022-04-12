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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7QHQ88Blci9gGj_GgbLMEjf7H524J7FI',
    appId: '1:320791552196:web:662bc2eb492246b7722991',
    messagingSenderId: '320791552196',
    projectId: 'meowchat-918de',
    authDomain: 'meowchat-918de.firebaseapp.com',
    storageBucket: 'meowchat-918de.appspot.com',
    measurementId: 'G-GV1PG7QLDR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC4SpakahKP6SQ0lbGX0ruM2HriJJWJw4',
    appId: '1:320791552196:android:ba18672bb3d4b6c1722991',
    messagingSenderId: '320791552196',
    projectId: 'meowchat-918de',
    storageBucket: 'meowchat-918de.appspot.com',
  );
}