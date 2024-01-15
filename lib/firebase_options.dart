
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      // case TargetPlatform.macOS:
      //   return macos;
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
 static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfH5jOcFsfBf4big2_CWKC68ujXEVJ3Ho',
    appId: '1:11749380327:android:f8ef54ffe9ad5dd0019242',
    messagingSenderId: '11749380327',
    projectId: 'smart-bill-eda08',
    databaseURL: "https://smart-bill-eda08-default-rtdb.firebaseio.com",
    storageBucket: 'smart-bill-eda08.appspot.com',
    // iosClientId: '492798704115-637bi24vqqdt0ifdnvg0c2af80jqh5eg.apps.googleusercontent.com',
    iosBundleId: 'com.example.smart_school_bill',
  );
  static const FirebaseOptions web = FirebaseOptions(
   apiKey: 'AIzaSyAfH5jOcFsfBf4big2_CWKC68ujXEVJ3Ho',
    appId: '1:11749380327:android:f8ef54ffe9ad5dd0019242',
    databaseURL: "https://smart-bill-eda08-default-rtdb.firebaseio.com",
    messagingSenderId: '11749380327',
    projectId: 'smart-bill-eda08',
    storageBucket: 'smart-bill-eda08.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfH5jOcFsfBf4big2_CWKC68ujXEVJ3Ho',
    appId: '1:11749380327:android:f8ef54ffe9ad5dd0019242',
    databaseURL: "https://smart-bill-eda08-default-rtdb.firebaseio.com",
    messagingSenderId: '11749380327',
    projectId: 'smart-bill-eda08',
    storageBucket: 'smart-bill-eda08.appspot.com',
  );  

}
