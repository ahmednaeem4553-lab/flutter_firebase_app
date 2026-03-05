

import 'package:flutter/material.dart';

class CodeVerification extends StatefulWidget {

  final String verificationId;
  const CodeVerification({super.key, required this.verificationId});

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verification'),
      backgroundColor: Colors.orange,),
      body: Column(
        children: [],
      ),
    );
  }
}