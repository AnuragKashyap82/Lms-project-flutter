import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClassroomCard extends StatefulWidget {
  final snap;

  const ClassroomCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ClassroomCard> createState() => _ClassroomCardState();
}


class _ClassroomCardState extends State<ClassroomCard> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isTeacher = true;
  AssetImage _image = AssetImage("");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.snap['theme'] == "1"){
      _image = AssetImage("assets/images/class_bd_three.jpg");
    }else if(widget.snap['theme'] == "2"){
      _image = AssetImage("assets/images/class_bg_five.jpg");
    }else if(widget.snap['theme'] == "3"){
      _image = AssetImage("assets/images/class_bg_four.jpg");
    }else if(widget.snap['theme'] == "4"){
      _image = AssetImage("assets/images/class_bg_one.jpg");
    }else if(widget.snap['theme'] == "5"){
      _image = AssetImage("assets/images/class_bg_two.jpg");
    }
  }

  @override
  Widget build(BuildContext context) {

    log("Clkassroom");

    setState(() {
      if (widget.snap['uid'] == FirebaseAuth.instance.currentUser?.uid) {
        _isTeacher = true;
      } else {
        _isTeacher = false;
      }
    });

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 180,
        width: 600,
        decoration: BoxDecoration(
            image: DecorationImage(image: _image, fit: BoxFit.cover),
            border: null,
            borderRadius: BorderRadius.circular(26),
            color: Colors.orangeAccent),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FadeAnimation(
                      1.2,
                      Text(
                        widget.snap['subjectName'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.3,
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  Dialog(
                                    child: ListView(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                      shrinkWrap: true,
                                      children: [
                                        'UnEnroll',
                                      ]
                                          .map((e) =>
                                          InkWell(
                                            onTap: () async {
                                              if(_isTeacher){
                                                Navigator.pop(context);
                                                print("Tu khud teacher hai lowde ....q dellete kar rha bsdk");
                                              }else{
                                                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid)
                                                    .collection("classroom").doc(widget.snap['classCode'])
                                                    .delete()
                                                    .then((value) => {
                                                      Navigator.pop(context)
                                                });
                                              }
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12,
                                                  horizontal: 16),
                                              child: Text(e),
                                            ),
                                          ))
                                          .toList(),
                                    ),
                                  ));
                        },
                        child: Icon(Icons.more_vert, color: Colors.white,)),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Expanded(
                    child: FadeAnimation(
                      1.4,
                      Text(
                        widget.snap['className'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Expanded(
                    child: FadeAnimation(
                      1.5,
                      Text(
                        "(" + widget.snap['name'] + ")",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  FadeAnimation(
                    1.6,
                    Text(
                      "Class Code",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  FadeAnimation(
                    1.7,
                    Text(
                      widget.snap['classCode'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
