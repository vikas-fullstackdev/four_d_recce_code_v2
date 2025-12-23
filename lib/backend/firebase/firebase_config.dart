import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

Future initFirebase() async {
  // Skip Firebase initialization on unsupported platforms (Linux, Windows, macOS)
  if (!kIsWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
    return;
  }
  
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCG7g7vJgAS7epSb1P3_SAkvpgkI5HPAQ0",
            authDomain: "fourdrecce.firebaseapp.com",
            projectId: "fourdrecce",
            storageBucket: "fourdrecce.firebasestorage.app",
            messagingSenderId: "466725892915",
            appId: "1:466725892915:web:1a38cc67f8b6f93b744446",
            measurementId: "G-B3Q1FQ0B8W"));
  } else {
    await Firebase.initializeApp();
  }
}
