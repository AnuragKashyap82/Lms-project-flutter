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
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FadeAnimation(1.1, Text(widget.snap['subjectName'])),
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
                      child: CircularProgressIndicator(),
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
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
            ),
            child: FadeAnimation(
              1.1, Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FadeAnimation(
                    1.2, IconButton(
                      icon: Icon(Icons.assignment_outlined),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AssignmentScreen(snap: widget.snap)));
                      },
                    ),
                  ),
                  FadeAnimation(
                    1.3, IconButton(
                      icon: Icon(Icons.edit_outlined),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomPostMsgScreen(snap: widget.snap)));
                      },
                    ),
                  ),
                  FadeAnimation(
                    1.4, IconButton(
                      icon: Icon(Icons.mark_as_unread),
                      onPressed: () {

                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
