


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/ui/auth/login_screen.dart';

class SplashServices {

  void islogin(BuildContext context){
    Timer(Duration(seconds: 3), ()=>
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
    );
  }
}