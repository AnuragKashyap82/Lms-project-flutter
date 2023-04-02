import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClassPostMsgCard extends StatefulWidget {
  final snap;

  const ClassPostMsgCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<ClassPostMsgCard> createState() => _ClassPostMsgCardState();
}

class _ClassPostMsgCardState extends State<ClassPostMsgCard> {
  var userData = {};
  var isLoading = false;
  bool _isOwnMsg = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.snap['uid'])
          .get();

      userData = userSnap.data()!;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      if (widget.snap['uid'] == FirebaseAuth.instance.currentUser?.uid) {
        _isOwnMsg = true;
      } else {
        _isOwnMsg = false;
      }
    });

    return
      Padding(
      padding: const EdgeInsets.all(4),
      child: isLoading
          ? Container()
          : Container(
              height: 80,
              width: 600,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          1.1,
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1679687189714-6a0e57adc199?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeAnimation(
                                1.2,
                                Text(
                                  userData['name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              FadeAnimation(
                                1.3,
                                Text(
                                  widget.snap['classMsg'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FadeAnimation(
                          1.4,
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: ListView(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shrinkWrap: true,
                                          children: [
                                            'Delete',
                                          ]
                                              .map((e) => InkWell(
                                                    onTap: () async {
                                                      if (_isOwnMsg) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("classroom")
                                                            .doc(widget.snap['classCode'])
                                                            .collection(
                                                                "postMsg")
                                                            .doc(widget.snap['timestamp'])
                                                            .delete()
                                                            .then((value) => {
                                                                  Navigator.pop(
                                                                      context)
                                                                });
                                                      } else {
                                                        Navigator.pop(context);
                                                        print(
                                                            "Tu khud teacher hai lowde ....q dellete kar rha bsdk");
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      child: Text(e),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ));
                            },
                            icon: Icon(Icons.more_vert),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: FadeAnimation(
                        1.5,
                        Text(
                          widget.snap['dateTime'],
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
