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
    apiKey: 'AIzaSyCmdEHWyJbWJZPBx4EGjYioywvUq-omAsY',
    appId: '1:1090346749026:web:16539d311eac1aac29953b',
    messagingSenderId: '1090346749026',
    projectId: 'fir-chat-2fefe',
    authDomain: 'fir-chat-2fefe.firebaseapp.com',
    storageBucket: 'fir-chat-2fefe.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhNw_uHVsg9-qguMVcDi1Th9vIvlv5Ybk',
    appId: '1:1090346749026:android:6899ad892a43d7dc29953b',
    messagingSenderId: '1090346749026',
    projectId: 'fir-chat-2fefe',
    storageBucket: 'fir-chat-2fefe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBp23Ry1paT2z1JKjvvdfCMEjDfSYb1gA8',
    appId: '1:1090346749026:ios:031e460c7df7e34329953b',
    messagingSenderId: '1090346749026',
    projectId: 'fir-chat-2fefe',
    storageBucket: 'fir-chat-2fefe.appspot.com',
    iosClientId: '1090346749026-6svqlttlvo5bs65ed78fkk77vmodji5q.apps.googleusercontent.com',
    iosBundleId: 'com.example.chtapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBp23Ry1paT2z1JKjvvdfCMEjDfSYb1gA8',
    appId: '1:1090346749026:ios:6943cd987664c21129953b',
    messagingSenderId: '1090346749026',
    projectId: 'fir-chat-2fefe',
    storageBucket: 'fir-chat-2fefe.appspot.com',
    iosClientId: '1090346749026-4k9jnj4at4ilunmt96grgmdd4p4titva.apps.googleusercontent.com',
    iosBundleId: 'com.example.chtapp.RunnerTests',
  );
}