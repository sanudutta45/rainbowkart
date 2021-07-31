import 'package:flutter/material.dart';
//import 'package:ranbowkart/screens/splash.dart';
import 'package:ranbowkart/screens/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RanbowKart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Racing Sans One', backgroundColor: Colors.white),
      // home: Splash(),
      home: Xyz(),
    );
  }
}
