import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/posts/add_post.dart';
import 'package:flutter_firebase_app/posts/firestore/add_firestore_data.dart';
import 'package:flutter_firebase_app/ui/auth/login_screen.dart';
import 'package:flutter_firebase_app/utils/utils.dart';

class FirestorelistScreen extends StatefulWidget {
  const FirestorelistScreen({super.key});

  @override
  State<FirestorelistScreen> createState() => _FirestorelistScreenState();
}

class _FirestorelistScreenState extends State<FirestorelistScreen> {

  // Firebase Auth instance for logout
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final firestore = FirebaseFirestore.instance.collection('users').snapshots();
    CollectionReference ref = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Firestore'),
        actions: [
          // Logout button
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              auth
                  .signOut()
                  .then((_) {
                    // After logout go to login screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  })
                  .onError((error, _) {
                    Utils().toastmessage(error.toString());
                  });
            },
          ),
        ],
      ),

      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(stream: firestore, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator(color: Colors.white,);
            }
            if(snapshot.hasError){
              return Text('Some Error');
            }
            return Expanded(child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                  'title': 'BreakEven Closed'
                }).then((value){
                  Utils().toastmessage('Updated');
                }).onError((error, stackTrace) {
                  Utils().toastmessage(error.toString());
                },);
              },
              title: Text(snapshot.data!.docs[index]['id'].toString()),
              subtitle: Text(snapshot.data!.docs[index]['title'].toString()),
            );
          }));
          }),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFirestoreData()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// // ── Search Box ──────────────────────────────────────────
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: TextFormField(
          //     controller: searchController,
          //     decoration: InputDecoration(
          //       suffixIcon: searchController.text.isEmpty
          //           ? null // hide icon when field is empty
          //           : IconButton(
          //               icon: Icon(Icons.close),
          //               onPressed: () {
          //                 setState(() {
          //                   searchController.clear(); // clears the text
          //                 });
          //               },
          //             ),
          //       hintText: 'Search by title...',
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(40),
          //       ),
          //     ),
          //     // Rebuild the list every time user types something
          //     onChanged: (_) => setState(() {}),
          //   ),
          // ),

          // ── Posts List ──────────────────────────────────────────
          // Expanded(
          //   child: StreamBuilder(
          //     stream: dbRef.onValue, // listens to Firebase in real time
          //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //       // Still loading
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(child: CircularProgressIndicator());
          //       }

          //       // Error from Firebase
          //       if (snapshot.hasError) {
          //         return Center(child: Text('Error loading posts.'));
          //       }

          //       // Firebase returned nothing
          //       if (snapshot.data?.snapshot.value == null) {
          //         return Center(child: Text('No posts yet.'));
          //       }

          //       // ── Convert Firebase data to a List ────────────────
          //       // Firebase returns a Map like: { "-abc": {title: ..., id: ...}, ... }
          //       // We only need the values, so we convert to a List
          //       Map<dynamic, dynamic> dataMap =
          //           snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          //       List<dynamic> allPosts = dataMap.values.toList();

          //       // ── Filter based on search input ───────────────────
          //       String searchText = searchController.text.toLowerCase().trim();

          //       List<dynamic> filteredPosts = searchText.isEmpty
          //           ? allPosts // show everything if search is empty
          //           : allPosts.where((post) {
          //               // safely read title, default to empty string if null
          //               String postTitle = (post['title'] ?? '')
          //                   .toString()
          //                   .toLowerCase();
          //               // keep this post only if title contains what user typed
          //               return postTitle.contains(searchText);
          //             }).toList();

          //       // Nothing matched the search
          //       if (filteredPosts.isEmpty) {
          //         return Center(child: Text('No posts match your search.'));
          //       }

          //       // ── Build the List ─────────────────────────────────
          //       return ListView.builder(
          //         itemCount: filteredPosts.length,
          //         itemBuilder: (context, index) {
          //           // safely read each field, fallback if null
          //           String title = (filteredPosts[index]['title'] ?? 'No Title')
          //               .toString();
          //           String id = (filteredPosts[index]['id'] ?? 'No ID')
          //               .toString();

          //           return ListTile(
          //             title: Text(title), // what you saved in Firebase
          //             subtitle: Text(id),
          //             trailing: PopupMenuButton(
          //               itemBuilder: (context) => [
          //                 PopupMenuItem(
          //                   child: ListTile(
          //                     leading: Icon(Icons.edit),
          //                     trailing: Text('Edit'),
          //                   ),
          //                 ),
          //                 PopupMenuItem(
          //                   child: ListTile(
          //                     leading: Icon(Icons.delete),
          //                     trailing: Text('Delete'),
          //                   ),
          //                 ),
                        
          //               ],
          //             ), // post id
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),