

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/posts/add_post.dart';
import 'package:flutter_firebase_app/ui/auth/login_screen.dart';
import 'package:flutter_firebase_app/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Post Screen'),
      actions: [
        IconButton(onPressed: (){
          _auth.signOut().then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
          }).onError((error, stackTrace){
            Utils().toastmessage(error.toString());
          });
        }, icon: Icon(Icons.logout_outlined))
      ],),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPost()));
      }, child: Icon(Icons.add),),
    );
  }
}