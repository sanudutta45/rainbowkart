import 'package:flutter/material.dart';
import 'package:ranbowkart/screens/home.dart';
import 'package:ranbowkart/screens/notFound.dart';
import 'package:ranbowkart/screens/otp.dart';
import 'package:ranbowkart/screens/signin.dart';
import 'package:ranbowkart/screens/splash.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Splash());
    case 'login':
      return MaterialPageRoute(builder: (context) => SignIn());
    case 'otp':
      final String phoneNumber = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => Otp(phoneNumber: phoneNumber));
    case 'home':
      return MaterialPageRoute(builder: (context) => Home());
    default:
      return MaterialPageRoute(builder: (context) => NotFound());
  }
}
