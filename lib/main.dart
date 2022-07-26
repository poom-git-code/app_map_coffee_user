import 'package:app_map_coffee_user/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Get.put(LocationController());
  runApp(
    const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
  );
}