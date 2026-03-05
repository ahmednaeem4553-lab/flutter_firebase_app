import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/ui/auth/code_verification.dart';
import 'package:flutter_firebase_app/utils/utils.dart';
import 'package:flutter_firebase_app/widgets/round_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneController = TextEditingController();
  bool isloading = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Login'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: '12345678',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(width: 1.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            RoundButton(
              title: 'Login',
              isloading: isloading,
              onTap: () {
                setState(() {
                  isloading = true;
                });
                _auth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                  verificationCompleted: (_) {
                    setState(() {
                      isloading = false;
                    });
                  },
                  verificationFailed: (e) {
                    setState(() {
                      isloading = false;
                    });
                    Utils().toastmessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token) {
                    setState(() {
                      isloading = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CodeVerification(verificationId: verificationId),
                      ),
                    );
                  },
                  codeAutoRetrievalTimeout: (e) {
                    setState(() {
                      isloading = false;
                    });
                    Utils().toastmessage(e.toString());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
