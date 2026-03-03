


import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen = SplashServices();
  @override
  void initState(){
    super.initState();
    splashScreen.islogin(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Flutter Firebase', style: TextStyle(fontSize: 30),),
      ),
    );
  }
}