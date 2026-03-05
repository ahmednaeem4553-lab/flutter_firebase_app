import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/posts/post_screen.dart';
import 'package:flutter_firebase_app/ui/auth/login_with_phone_number.dart';
import 'package:flutter_firebase_app/ui/auth/signup_screen.dart';
import 'package:flutter_firebase_app/utils/utils.dart';
import 'package:flutter_firebase_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isloading = false;

  final _auth = FirebaseAuth.instance;
  final form_key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    if (form_key.currentState!.validate()) {
                  setState(() {
                    isloading = true;
                  });
                  _auth.signInWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(), 
                      )
                      .then((value) { 
                        Utils().toastmessage(value.user!.email.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
                        setState(() {
                          isloading = false;
                        });
                      })
                      .onError((error, stackTrace) {
                        debugPrint(error.toString());
                        Utils().toastmessage(error.toString());
                        setState(() {
                          isloading = false;
                        });
                      });
                }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Login', style: TextStyle(color: Colors.white)),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: form_key,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email Please';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      // helperText: 'Valid Email Only',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password Please';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      // helperText: 'Valid Password Only',
                      prefixIcon: Icon(Icons.password_rounded),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            RoundButton(
              title: 'Login',
              onTap: () {
                login();
              },
            ),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginWithPhoneNumber()));
            }, child: Text('Login with Phone Number')),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
