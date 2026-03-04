import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/utils/utils.dart';
import 'package:flutter_firebase_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isloading = false;
  final form_key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signup() {
    if (form_key.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString(),
          )
          .then((value) {
            setState(() {
              isloading = false;
            });
          })
          .onError((error, stackTrace) {
            Utils().toastmessage(error.toString());
            setState(() {
              isloading = false;
            });
          });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('SignUp', style: TextStyle(color: Colors.white)),
        ),
        automaticallyImplyLeading: true,
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
            RoundButton(title: 'Signup', isloading: isloading, onTap: () {
              signup();
            }),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
