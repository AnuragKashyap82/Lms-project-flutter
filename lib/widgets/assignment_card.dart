import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/global_variables.dart';

class AssignmentCard extends StatefulWidget {
  final snap;
  const AssignmentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<AssignmentCard> createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {

  bool _alreadySubmitted = false;
  bool _notSubmitted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadIfSubmitted();
  }

  void loadIfSubmitted() async {
    try {
      var submittedSnap = await FirebaseFirestore.instance
          .collection("classroom")
          .doc(widget.snap['classCode'])
          .collection("assignment")
          .doc(widget.snap['assignmentId'])
          .collection("submission")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (submittedSnap.exists) {
        setState(() {
          _alreadySubmitted = true;
        });
      } else {
        setState(() {
          _notSubmitted = true;
        });
      }

    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(

        ),
        child: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Icon(Icons.assignment, color: _alreadySubmitted ?  Colors.grey:
            colorPrimary
              ,),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.snap['assignmentName'], style: TextStyle(color: colorPrimary, fontSize: 16),),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Teacher Name to be integrated", style: TextStyle(color: Colors.grey, fontSize: 14),),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.snap['dueDate'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                SizedBox(
                  height: 4,
                ),
                Text(widget.snap['dateTime'], style: TextStyle(color: Colors.grey, fontSize: 14),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
