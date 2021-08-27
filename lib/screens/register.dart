import 'package:flutter/material.dart';
import 'package:ranbowkart/constants/constants.dart';
import 'package:ranbowkart/mixins/validationMixins.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff36C69A),
        centerTitle: true,
        title: Text(
          "Register",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Container(),
            SizedBox(height: 35),
            RegisterScreen()
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with InputValidationMixin {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;
  late String sponsorCode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return EmailNotEntered;
              } else if (!isEmailValid(value)) {
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
                labelStyle: TextStyle(color: Color(0xff36C69A), fontSize: 15)),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) => password = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return PasswordNotEntered;
              } else if (!isPasswordValid(value)) {
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
                labelStyle: TextStyle(color: Color(0xff36C69A), fontSize: 15)),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) => confirmPassword = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ComfirmPasswordNotEntered;
              } else if (!isConfirmPasswordMatch(password, value)) {
                return PasswordNotMatched;
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
                  Icons.password_sharp,
                  color: Color(0xff36C69A),
                ),
                labelText: "confirm Password",
                labelStyle: TextStyle(color: Color(0xff36C69A), fontSize: 15)),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) => sponsorCode = value,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                return PasswordNotEntered;
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
                labelText: "Sponsor code",
                labelStyle: TextStyle(color: Color(0xff36C69A), fontSize: 15)),
          ),
        ), //sponsorcode
        SizedBox(height: 25),
        Container(
            height: 50,
            child: ElevatedButton(
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 25),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff36C69A),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();
                }
              },
            )),
      ]),
    );
  }
}
