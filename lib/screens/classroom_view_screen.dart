import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/assignment_screen.dart';
import 'package:eduventure/screens/post_msg_screen.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:eduventure/widgets/class_post_msg_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'attendance_screen.dart';

class ClassroomViewScreen extends StatefulWidget {
  final snap;

  const ClassroomViewScreen({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ClassroomViewScreen> createState() => _ClassroomViewScreenState();
}

class _ClassroomViewScreenState extends State<ClassroomViewScreen> {
  bool _isTeacher  = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if(widget.snap['uid'] == FirebaseAuth.instance.currentUser?.uid){
      setState(() {
        _isTeacher = true;
      });
    }else{

    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FadeAnimation(1.1, Text(widget.snap['subjectName'], style: TextStyle(fontSize: 16),)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("classroom").
                doc(widget.snap['classCode']).collection("postMsg")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2,),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: width > webScreenSize ? width * 0.3 : 0,
                                  vertical: width > webScreenSize ? 15 : 0
                              ),
                              child: FadeAnimation(
                                1.1, ClassPostMsgCard(
                                snap: snapshot.data!.docs[index].data(),
                              ),
                              ),
                            ),
                          ));
                })
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
            ),
            child: FadeAnimation(
              1.1, Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FadeAnimation(
                    1.2, SizedBox(
                      child: IconButton(
                        icon: Icon(Icons.assignment_outlined),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AssignmentScreen(snap: widget.snap)));
                        },
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.3, SizedBox(
                      child: IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomPostMsgScreen(snap: widget.snap)));
                        },
                      ),
                    ),
                  ),
                  _isTeacher ?
                  SizedBox(
                    child: FadeAnimation(
                      1.4, IconButton(
                        icon: Icon(Icons.mark_as_unread),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen(snap: widget.snap)));
                        },
                      ),
                    ),
                  ): SizedBox(width: 0, height: 0,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
