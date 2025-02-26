// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    } else {
      return FirebaseOptions(
        apiKey: "AIzaSyDZ7s_s8XK0NnqaZlmgYbWHoPAmpHFDl4g",
  authDomain: "projectnext-e32d4.firebaseapp.com",
  projectId: "projectnext-e32d4",
  storageBucket: "projectnext-e32d4.firebasestorage.app",
  messagingSenderId: "545581456636",
  appId: "1:545581456636:web:1a1f79e5c2f3e1d6f58b79",
  measurementId: "G-1P6SZP449V"
      );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDZ7s_s8XK0NnqaZlmgYbWHoPAmpHFDl4g',
    appId: '1:545581456636:web:1a1f79e5c2f3e1d6f58b79',
    messagingSenderId: '545581456636',
    projectId: 'projectnext-e32d4',
    authDomain: 'projectnext-e32d4.firebaseapp.com',
    storageBucket: 'projectnext-e32d4.firebaseapp.com',
    measurementId: 'G-1P6SZP449V',
  );
}


