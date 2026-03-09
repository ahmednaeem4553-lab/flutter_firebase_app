import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/utils/utils.dart';
import 'package:flutter_firebase_app/widgets/round_button.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postController = TextEditingController();
  bool isloading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add post!')),
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
                databaseRef
                    .child(DateTime.now().millisecondsSinceEpoch.toString())
                    .set({
                      'id' : DateTime.now().millisecondsSinceEpoch.toString(),
                      'title': postController.text.toString()})
                    .then((value) {
                      setState(() {
                        isloading = false;
                      });
                      Utils().toastmessage('Post Added!');
                    })
                    .onError((error, stackTrace) {
                      setState(() {
                        isloading = false;
                      });
                      Utils().toastmessage(error.toString());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
