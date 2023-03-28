import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/add_books_screen.dart';
import 'package:eduventure/widgets/books_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../utils/global_variables.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeAnimation(
            1.1,
            Text(
              "Library",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        actions: [
          FadeAnimation(
              1.2,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.library_books,
                  size: 18,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("books").snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: FadeAnimation(
                            1.1,
                            BooksCard(
                              snap: snapshot.data!.docs[index].data(),
                            ),
                          ),
                        ),
                      ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddBooksScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
