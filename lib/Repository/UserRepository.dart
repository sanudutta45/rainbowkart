import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ranbowkart/constants/auth.dart';
import 'package:ranbowkart/models/phoneVerification.dart';

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  late User _user;
  late int resetToken;
  late String verificationId;

  Status _status = Status.Uninitialized;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;
  User? get user => _user;

  Future<PhoneVerification> verifyPhone(String phoneNumber) async {
    final Completer<PhoneVerification> _completer =
        new Completer<PhoneVerification>();

    try {
      _status = Status.Authenticating;
      notifyListeners();

      await _auth.verifyPhoneNumber(
          phoneNumber: '+91$phoneNumber',
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            print("inside verification function");
            await _auth.signInWithCredential(credential);
            _completer.complete(PhoneVerification(
                status: "Success", message: "Phone verification completed"));
            _status = Status.Authenticated;
          },
          verificationFailed: (FirebaseAuthException e) {
            print("inside verification failed function");
            _status = Status.Unauthenticated;
            _completer.completeError(PhoneVerification(
                status: "Failed", message: "Failed to validate user"));
          },
          codeSent: (String verificationId, int? resendToken) {
            print("inside code sent function " + verificationId + " " + '$resendToken');
            this.verificationId = verificationId;
            // this.resetToken = resetToken;
            _completer.complete(PhoneVerification(
                status: "Success", message: "Code send successfully"));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});

      return _completer.future;
    } catch (e) {
      _status = Status.Unauthenticated;
      _completer.completeError(
          PhoneVerification(status: "Failed", message: "Something went wrong"));
      return _completer.future;
    }
  }

  Future<bool> signInWithOtp(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: this.verificationId, smsCode: smsCode);

      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _onAuthStateChanged(User? user) async {
    if (user == null)
      _status = Status.Unauthenticated;
    else {
      _user = user;
      _status = Status.Authenticated;
    }

    notifyListeners();
  }
}
