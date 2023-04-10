import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/screens/material_details_screen.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../widgets/material_card.dart';

class AllMaterialsScreen extends StatelessWidget {
  final String semester;
  final String branch;
  const AllMaterialsScreen({Key? key, required this.semester, required this.branch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${semester} - ${branch}"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Materials")
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialDetailsScreen(
                        snap: snapshot.data!.docs[index].data()
                    )));
                  },
                  child: Container(
                    child: FadeAnimation(
                      1.1,
                      MaterialCard(
                        snap: snapshot.data!.docs[index].data(),
                      ),
                    ),
                  ),
                ));
          }),
    );
  }
}
