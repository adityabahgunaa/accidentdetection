import 'package:accident_response_app/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAyj_ooZ17McePY8-Bc2qMQW6CJmx96nTk",
        appId: "1:944756957683:android:80c13d3eeda767e5fd7286",
        messagingSenderId: "944756957683",
        projectId: "accidentdetectionsystem-368ed"
      ),
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization failed:$e');
}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Accident_response_app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent)
        
        
      ),
      home: const SplashScreen(),
      
    );
  }
}

