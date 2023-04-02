import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/screens/submitted_ass_view.dart';
import 'package:eduventure/widgets/submitted_ass_card.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';

class SubmittedAssStudent extends StatefulWidget {
  final snap;
  const SubmittedAssStudent({Key? key, required this.snap}) : super(key: key);

  @override
  State<SubmittedAssStudent> createState() => _SubmittedAssStudentState();
}

class _SubmittedAssStudentState extends State<SubmittedAssStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submitted Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("classroom").doc(widget.snap['classCode']).collection("assignment")
          .doc(widget.snap["assignmentId"])
          .collection("submission")
              .snapshots(),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubmittedAssViewScreen(snap: snapshot.data!.docs[index].data(),)));
                      },
                      child: Container(
                        child: FadeAnimation(
                          1.1, SubmittedAssCard(
                          snap: snapshot.data!.docs[index].data(),
                        ),
                        ),
                      ),
                    ));

          }
      ),
    );
  }
}
