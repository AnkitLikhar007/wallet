// @dart=2.9
import 'package:flutter/material.dart';
import 'package:scotwallet/screens/login.dart';
import 'package:scotwallet/screens/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

