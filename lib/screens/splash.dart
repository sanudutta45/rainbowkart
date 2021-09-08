import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _hasError = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      Navigator.pushReplacementNamed(context, "login");
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          // Image.asset('assets/images/splash.png'),
          SizedBox(height: 35),
          Image.asset(
            'assets/images/rklogo.png',
            height: 180,
          ),
          SizedBox(height: 70),
          Text(
            "Welcome \nto \nour store",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff20963a),
                fontSize: 30,
                fontWeight: FontWeight.w400,
                height: 0.9),
          ),
          Text(
            _hasError ? "Please check your connection" : "",
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));
  }
}
