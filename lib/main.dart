import 'package:flutter/material.dart';
import 'package:ranbowkart/Repository/UserRepository.dart';
import 'package:ranbowkart/screens/routes.dart' as routes;
import 'package:provider/provider.dart';
// import 'package:ranbowkart/screens/otp.dart';
// import 'package:ranbowkart/screens/signin.dart';
//import 'package:ranbowkart/screens/register.dart';
//import 'package:ranbowkart/screens/splash.dart';
//import 'package:ranbowkart/screens/signin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserRepository.instance())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RanbowKart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Racing Sans One', backgroundColor: Colors.white),
      onGenerateRoute: routes.generateRoute,
      initialRoute: "/",
    );
  }
}
