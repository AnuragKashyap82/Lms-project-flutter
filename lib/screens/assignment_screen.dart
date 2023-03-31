import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/add_ass_screen.dart';
import 'package:eduventure/screens/ass_view_screen.dart';
import 'package:eduventure/widgets/assignment_card.dart';
import 'package:flutter/material.dart';

import '../widgets/notice_card.dart';

class AssignmentScreen extends StatefulWidget {
  final snap;
  const AssignmentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeAnimation(1.1, Text("Assignment Section")),
      ),

      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection("classroom").doc(widget.snap['classCode']).collection("assignment").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return   ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AssignmentViewScreen(
                            snap: snapshot.data!.docs[index].data()
                        )));
                      },
                      child: Container(
                        child: FadeAnimation(
                          1.1, AssignmentCard(
                          snap: snapshot.data!.docs[index].data(),
                        ),
                        ),
                      ),
                    ));

          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAssignmentScreen(snap: widget.snap)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
