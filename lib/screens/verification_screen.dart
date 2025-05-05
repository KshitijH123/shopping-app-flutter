import 'package:flutter/material.dart';
import 'package:interview_practice/screens/home_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<VerificationScreen> {
  final mobileController = TextEditingController();
  bool isOtpSent = false;

  void sentOtp() {
    final number = mobileController.text.trim();
    if (number.isEmpty) {
      return;
    }

    if (number.length != 10) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid Mobile Number')));
      return;
    }

    isOtpSent = true;
    mobileController.clear();
    setState(() {});
  }

  void verifyOtp() {
    final otp = mobileController.text.trim();
    if (otp.isEmpty) {
      return;
    }

    if (otp == '000000') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid OTP.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          spacing: 24,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isOtpSent
                  ? 'Enter Your OTP'
                  : 'Enter your mobile number to Get OTP',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText:
                    isOtpSent ? 'Enter your OTP' : 'Enter your mobile number',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: isOtpSent ? verifyOtp : sentOtp,
              child: Text(isOtpSent ? 'Verify' : 'Sent OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
