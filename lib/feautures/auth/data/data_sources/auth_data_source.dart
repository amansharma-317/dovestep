import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//responsible for interacting with Firebase's authentication API

class FirebasePhoneDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";
  User? currentUser;

  Future<void> sendOTP(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print('verification completed');
        print(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verificationFailed error : ' + e.toString());
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
        print('timeout');
      },
    );
  }
//replace UserCredential return type with bool
  Future<bool> verifyOTP(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      //return await _auth.signInWithCredential(credential);
      final UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
      currentUser = FirebaseAuth.instance.currentUser!;
      print(user);

      if (currentUser!.uid != "") {
        print('user authenticated');
        print(currentUser!.uid);
        return true;
      } else {
        print('uid is null');
        return false;
      }
    } catch (e) {
      // Handle verification failure
      print('errorin OTP datasource' + e.toString());
      return false;
    }
  }

  Future<bool> resendOTP(String verificationId, int? resendToken) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (resendToken != null) {
      try {
        await _auth.verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential credential) {
            print('verification completed');
            print(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print('verificationFailed error : ' + e.toString());
            throw e;
          },
          forceResendingToken: resendToken,
          codeSent: (String verificationId, int? resendToken) {
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            this.verificationId = verificationId;
            print('timeout');
          },
        );
        return true;
      } catch (e) {
        print(e.toString());
        return false;
      }
    } else {
      print('Resend token is not available on iOS devices.');
      return false; // Handle resend unavailable scenario (iOS)
    }
  }




}

















/*
This class, FirebasePhoneDataSource, acts as the interface to interact directly with Firebase's authentication service. It utilizes Firebase's FirebaseAuth instance to perform phone authentication operations.

sendOTP Function:

Initiates the process by sending an OTP to the provided phone number using verifyPhoneNumber.
Handles various callbacks like verificationCompleted, verificationFailed, codeSent, etc., which are part of the Firebase Phone Auth process. You'd typically complete these methods with relevant logic.
verifyOTP Function:

Verifies the received OTP against the verification ID using signInWithCredential.
Returns a UserCredential if authentication is successful; otherwise, it catches any exceptions and handles the verification failure.
*/
