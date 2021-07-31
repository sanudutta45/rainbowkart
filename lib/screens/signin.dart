import 'package:flutter/material.dart';
import 'package:ranbowkart/mixins/validationMixins.dart';
import 'package:ranbowkart/constants/constants.dart';

class Xyz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff36C69A),
        centerTitle: true,
        title: Text(
          "Login",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/images/rklogo.png'),
              width: 120,
              height: 120,
            ),
            SizedBox(height: 35),
            AppSignIn()
          ],
        ),
      ),
    );
  }
}

class AppSignIn extends StatefulWidget {
  @override
  _AppSignInState createState() => _AppSignInState();
}

class _AppSignInState extends State<AppSignIn> with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return EmailNotEntered;
                } else if (isEmailValid(value)) {
                  return EmailNotValid;
                }

                return null;
              },
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xff36C69A), width: 2.0)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xff36C69A), width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xff36C69A), width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xff36C69A), width: 2.0)),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Color(0xff36C69A),
                  ),
                  labelText: "Email",
                  labelStyle:
                      TextStyle(color: Color(0xff36C69A), fontSize: 15)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return PasswordNotEntered;
                } else if (isPasswordValid(value)) {
                  return PasswordNotValid;
                }
                return null;
              },
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xff36C69A), width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xff36C69A), width: 2.0)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xff36C69A), width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xff36C69A), width: 2.0)),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Color(0xff36C69A),
                  ),
                  labelText: "Password",
                  labelStyle:
                      TextStyle(color: Color(0xff36C69A), fontSize: 15)),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 30, 10),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xff36C69A),
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                  ),
                )),
          ),
          SizedBox(height: 25),
          Container(
              height: 50,
              child: ElevatedButton(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff36C69A),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
              )),
          GestureDetector(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 30, 10),
                child: Text(
                  "Does not have account ?",
                  style: TextStyle(
                    color: Color(0xff36C69A),
                    fontSize: 18,
                  ),
                )),
          ),
        ]));
  }
}
