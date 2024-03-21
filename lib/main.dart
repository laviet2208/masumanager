import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/LoginScreen.dart';
import 'package:masumanager/MasuShipManager/login_screen.dart';
Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyD-09bxgKHW4FKs3xfZ2QijmEYIhTkHtz8",
        authDomain: "masuship-5b377.firebaseapp.com",
        databaseURL: "https://masuship-5b377-default-rtdb.firebaseio.com",
        projectId: "masuship-5b377",
        storageBucket: "masuship-5b377.appspot.com",
        messagingSenderId: "788990781107",
        appId: "1:788990781107:web:44af977453d566b1df72c6",
        measurementId: "G-EFP189VS2Y"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MasuShip Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const login_screen(),
    );
  }
}