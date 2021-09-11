import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ranbowkart/constants/auth.dart';
import 'package:ranbowkart/models/PhoneVerification.dart';

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  late User _user;
  int? resetToken;
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
            _completer
                .complete(PhoneVerification(status: true, isVerified: true));
            _status = Status.Authenticated;
            notifyListeners();
          },
          verificationFailed: (FirebaseAuthException e) {
            print("inside verification failed function");
            _status = Status.Unauthenticated;
            notifyListeners();
            _completer.completeError(PhoneVerification(status: false));
          },
          codeSent: (String verificationId, int? resendToken) {
            print("inside code sent function " +
                verificationId +
                " " +
                '$resendToken');
            this.verificationId = verificationId;
            this.resetToken = resetToken;
            _completer.complete(PhoneVerification(status: true));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});

      return _completer.future;
    } catch (e) {
      _status = Status.Unauthenticated;
      _completer
          .completeError(PhoneVerification(status: false, isVerified: false));
      return _completer.future;
    }
  }

  Future<bool> signInWithCredential(String smsCode) async {
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
