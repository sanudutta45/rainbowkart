import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ranbowkart/constants/auth.dart';
// import 'package:ranbowkart/models/PhoneVerification.dart';

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  late User _user;

  Status _status = Status.Uninitialized;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;
  User? get user => _user;

  Future<bool> signInWithCredential(String smsCode, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

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
