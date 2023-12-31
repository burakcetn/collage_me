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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0mjE_Fr7K3DwLpTTAzqXmGc4bxHMuv9c',
    appId: '1:28292794510:android:23a366b719357d4fd021df',
    messagingSenderId: '28292794510',
    projectId: 'collageapp-84f9c',
    storageBucket: 'collageapp-84f9c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBj-C2oIdk4o-LaaVNnPFnvnDDzWq3P96k',
    appId: '1:28292794510:ios:db3029676828e07ed021df',
    messagingSenderId: '28292794510',
    projectId: 'collageapp-84f9c',
    storageBucket: 'collageapp-84f9c.appspot.com',
    iosClientId: '28292794510-ml1udi6grbrjha012sj9ua0volftkh10.apps.googleusercontent.com',
    iosBundleId: 'com.example.collageMe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBj-C2oIdk4o-LaaVNnPFnvnDDzWq3P96k',
    appId: '1:28292794510:ios:7d209c6229f90e87d021df',
    messagingSenderId: '28292794510',
    projectId: 'collageapp-84f9c',
    storageBucket: 'collageapp-84f9c.appspot.com',
    iosClientId: '28292794510-er7mpii624ou7co5ttjrnkq9r61euj5a.apps.googleusercontent.com',
    iosBundleId: 'com.example.collageMe.RunnerTests',
  );
}
