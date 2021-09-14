import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:ranbowkart/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ranbowkart/Repository/UserRepository.dart';
import 'package:provider/provider.dart';
// import 'package:ranbowkart/models/PhoneVerification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Otp extends StatelessWidget {
  final String phoneNumber;
  const Otp({Key? key, required this.phoneNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff36C69A),
        centerTitle: true,
        title: Text(
          "OTP Verification",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child:
                  Image.asset('assets/images/otp.png', width: 120, height: 120),
              // width: 120,
              // height: 120,
            ),
            SizedBox(height: 10),
            OtpForm(phoneNumber: phoneNumber)
          ],
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  final String phoneNumber;
  const OtpForm({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> with CodeAutoFill {
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool hasError = false;
  bool serverError = false;
  String otpCode = "";
  late String verificationId;
  late int? resendToken;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    listenForCode();
    errorController = StreamController<ErrorAnimationType>();
    verifyPhone();
  }

  Future<void> verifyPhone() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + widget.phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            print("inside verification function");
            await _auth.signInWithCredential(credential);
            Navigator.pushReplacementNamed(context, "home");
          },
          verificationFailed: (FirebaseAuthException e) {
            print("inside verification failed function");
          },
          codeSent: (String verificationId, int? resendToken) {
            print("inside code sent function " +
                verificationId +
                " " +
                '$resendToken');
            this.verificationId = verificationId;
            this.resendToken = resendToken;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      setState(() {
        serverError = true;
      });
    }
  }

  @override
  void dispose() {
    errorController!.close();
    cancel();
    super.dispose();
  }

  @override
  void codeUpdated() {
    print('$code!');
    setState(() {
      otpCode = code!;
      textEditingController.text = code!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 35),
            child: PinCodeTextField(
              appContext: context,
              autoFocus: true,
              pastedTextStyle: TextStyle(
                  color: Colors.green.shade600, fontWeight: FontWeight.bold),
              length: 6,
              obscureText: true,
              obscuringCharacter: "*",
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                // if (v != null && v.length < 3) {
                //   return "I m from validator";
                // } else {
                //   return null;
                // }
                return null;
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(9),
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                activeFillColor: Colors.white,
                fieldHeight: 50,
                fieldWidth: 45,
                selectedColor: Color(0xFF91D3B3),
                inactiveColor: Color(0xFF91D3B3),
                activeColor: Color(0xFF91D3B3),
              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              enablePinAutofill: true,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                print("completed");
              },
              onChanged: (value) {
                print(value);
                setState(() {
                  otpCode = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to past $text");
                return true;
              },
            ),
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Text(
          hasError ? "*Please fill up all the cells properly" : "",
          style: TextStyle(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Didn't receive the code? ",
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "RESEND",
              style: TextStyle(
                  color: Color(0xFF91D3B3),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
      SizedBox(height: 14),
      Container(
          height: 50,
          child: ElevatedButton(
            child: Text(
              'Verify',
              style: TextStyle(fontSize: 25),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xff36C69A),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            onPressed: () async {
              formKey.currentState!.validate();

              if (otpCode.length != 6 ||
                  !await Provider.of<UserRepository>(context, listen: false)
                      .signInWithCredential(otpCode, verificationId)) {
                errorController!.add(ErrorAnimationType.shake);
                setState(() => hasError = true);
              } else {
                Navigator.pushReplacementNamed(context, "home");
              }
            },
          )),
    ]);
  }
}

// ignore: non_constant_identifier_names
//DefaultButton({String? text, Null Function()? press}) {}
