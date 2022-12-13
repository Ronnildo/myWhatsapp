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
    apiKey: 'AIzaSyCGLlImr5I6i1JNBMwSKNjcqXaYpOrEClY',
    appId: '1:659447962891:web:b10c5149338b0c64a6560e',
    messagingSenderId: '659447962891',
    projectId: 'mywhatsapp-1115f',
    authDomain: 'mywhatsapp-1115f.firebaseapp.com',
    storageBucket: 'mywhatsapp-1115f.appspot.com',
    measurementId: 'G-ZT7BTK5TX7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgb_-XmInBCL0nNpLkwjyyKAXZVeQ8uLs',
    appId: '1:659447962891:android:36cf9e636845471fa6560e',
    messagingSenderId: '659447962891',
    projectId: 'mywhatsapp-1115f',
    storageBucket: 'mywhatsapp-1115f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1GzKB7rfVWe5AeJWaUvFY1i5quG0nYe0',
    appId: '1:659447962891:ios:b3ca173381550ca0a6560e',
    messagingSenderId: '659447962891',
    projectId: 'mywhatsapp-1115f',
    storageBucket: 'mywhatsapp-1115f.appspot.com',
    iosClientId: '659447962891-427n3b02hajumf1d6qki0fk8qq6h1k0u.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1GzKB7rfVWe5AeJWaUvFY1i5quG0nYe0',
    appId: '1:659447962891:ios:b3ca173381550ca0a6560e',
    messagingSenderId: '659447962891',
    projectId: 'mywhatsapp-1115f',
    storageBucket: 'mywhatsapp-1115f.appspot.com',
    iosClientId: '659447962891-427n3b02hajumf1d6qki0fk8qq6h1k0u.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsapp',
  );
}