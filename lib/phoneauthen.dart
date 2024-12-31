import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  // Send OTP to phone number
  Future<void> _sendOtp() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, '/chatbot');
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  // Verify OTP entered by the user
  Future<void> _verifyOtp() async {
    if (_verificationId == null) return;

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: _otpController.text,
    );

    try {
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/chatbot');
    } catch (e) {
      print("Error verifying OTP: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _phoneController, decoration: InputDecoration(hintText: 'Phone number')),
            ElevatedButton(onPressed: _sendOtp, child: Text('Send OTP')),
            if (_verificationId != null)
              Column(
                children: [
                  TextField(controller: _otpController, decoration: InputDecoration(hintText: 'Enter OTP')),
                  ElevatedButton(onPressed: _verifyOtp, child: Text('Verify OTP')),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
