import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  // const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Image.asset('assets/images/splash.png'),
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
          )
        ],
      ),
    ));
  }
}
