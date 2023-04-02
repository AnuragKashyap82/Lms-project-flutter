import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../utils/global_variables.dart';

class SubmittedAssCard extends StatefulWidget {
  final snap;
  const SubmittedAssCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<SubmittedAssCard> createState() => _SubmittedAssCardState();
}

class _SubmittedAssCardState extends State<SubmittedAssCard> {

  bool _isLoading = false;

  var _userData  = {};

  void getStudentName() async {
      setState(() {
        _isLoading = true;
      });
      try {
        var userSnap = await FirebaseFirestore.instance
            .collection("users")
            .doc(widget.snap['uid'])
            .get();
        if(userSnap.exists){
          setState(() {
            _userData = userSnap.data()!;
          });

        }else{

        }
        setState(() {});
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
      setState(() {
        _isLoading = false;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudentName();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: _isLoading ? Center(child: CircularProgressIndicator(color: colorPrimary,))
      : Container(
        height: 60,
        width: 600,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
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
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          1.2,
                          Text(
                            _userData['name'],
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        FadeAnimation(
                          1.3,
                          Text(
                            "${widget.snap['marksObtained']}/${widget.snap['fullMarks']}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeAnimation(
                    1.4,
                    Container(
                        padding: EdgeInsets.all(12),
                        child: Text(widget.snap['dateTime'], style: TextStyle(color: Colors.grey, fontSize: 14),))
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
