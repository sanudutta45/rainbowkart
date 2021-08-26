import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:ranbowkart/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otp extends StatelessWidget {
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
            OtpForm("+880210439")
          ],
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  // const OtpForm({Key? key}) : super(key: key);

  final String phoneNumber;

  OtpForm(this.phoneNumber);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
            child: PinCodeTextField(
              appContext: context,
              autoFocus: true,
              pastedTextStyle: TextStyle(
                  color: Colors.green.shade600, fontWeight: FontWeight.bold),
              length: 4,
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
                  currentText = value;
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
            onPressed: () {
              formKey.currentState!.validate();

              if (currentText.length != 4 || currentText != "1234") {
                errorController!.add(ErrorAnimationType.shake);
                setState(() => hasError = true);
              } else {
                setState(() {
                  hasError = false;
                });
              }
            },
          )),
    ]);
  }
}

// ignore: non_constant_identifier_names
//DefaultButton({String? text, Null Function()? press}) {}
