import 'package:flutter/material.dart';
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
      String phoneNumber = settings.arguments.toString();
      return MaterialPageRoute(builder: (context) => Otp(phoneNumber: phoneNumber));
    default:
      return MaterialPageRoute(builder: (context) => NotFound());
  }
}
