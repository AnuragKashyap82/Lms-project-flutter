import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/widgets/returned_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';

class ReturnedBookScreen extends StatelessWidget {
  const ReturnedBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("returnedBooks").
          doc(FirebaseAuth.instance.currentUser?.uid).collection("Books")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return
              GridView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, mainAxisExtent:  128),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: FadeAnimation(
                        1.1, ReturnedCard(snap: snapshot.data!.docs[index].data())
                    ),
                  );
                },
              );
          }),
    );
  }
}
