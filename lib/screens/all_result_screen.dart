import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/screens/result_screen.dart';
import 'package:eduventure/screens/result_view_screen.dart';
import 'package:eduventure/widgets/result_card.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';

class AllResultScreen extends StatefulWidget {
  final String semester;
  final String branch;

  const AllResultScreen(
      {Key? key, required this.semester, required this.branch})
      : super(key: key);

  @override
  State<AllResultScreen> createState() => _AllResultScreenState();
}

class _AllResultScreenState extends State<AllResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${semester} - ${branch}"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Result")
              .doc(semester)
              .collection(branch)
              .snapshots(),
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
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ResultViewScreen(
                            snap: snapshot.data!.docs[index].data()
                        )));
                      },
                      child: Container(
                        child: FadeAnimation(
                          1.1,
                          ResultCard(
                            snap: snapshot.data!.docs[index].data(),
                          ),
                        ),
                      ),
                    ));
          }),
    );
  }
}
