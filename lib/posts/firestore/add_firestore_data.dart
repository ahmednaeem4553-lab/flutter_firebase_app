import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/utils/utils.dart';
import 'package:flutter_firebase_app/widgets/round_button.dart';

class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {

  final firestore = FirebaseFirestore.instance.collection('users');
  final postController = TextEditingController();
  bool isloading = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Data to Firestore')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              controller: postController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Share your thoughts!',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(width: 0.5),
                ),
              ),
            ),
            SizedBox(height: 20),
            RoundButton(
              title: 'Post',
              isloading: isloading,
              onTap: () {
                setState(() {
                  isloading = true;
                });

                String id = DateTime.now().millisecondsSinceEpoch.toString();

                firestore.doc(id).set({
                  'title' : postController.text.toString(),
                  'id' : id
                }).then((value){
                  setState(() {
                  isloading = false;
                  Utils().toastmessage('Post Added to Firestore');
                });
                }).onError((error, stackTrace) {
                  setState(() {
                  isloading = false;
                });
                  Utils().toastmessage(error.toString());
                },);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// final databaseRef = FirebaseDatabase.instance.ref('Post');

// String id = DateTime.now().millisecondsSinceEpoch.toString();

                // databaseRef
                //     .child(id)
                //     .set({
                //       'id' : id,
                //       'title': postController.text.toString()})
                //     .then((value) {
                //       setState(() {
                //         isloading = false;
                //       });
                //       Utils().toastmessage('Post Added!');
                //     })
                //     .onError((error, stackTrace) {
                //       setState(() {
                //         isloading = false;
                //       });
                //       Utils().toastmessage(error.toString());
                //     });