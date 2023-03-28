import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClassroomPostMsgScreen extends StatefulWidget {
  final snap;
  const ClassroomPostMsgScreen({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ClassroomPostMsgScreen> createState() => _ClassroomPostMsgScreenState();
}

class _ClassroomPostMsgScreenState extends State<ClassroomPostMsgScreen> {
  TextEditingController _msg = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    String dateTime = date +"  "+ tDate;

    DocumentReference reference =  FirebaseFirestore.instance.collection("classroom").
    doc(widget.snap['classCode']).collection("postMsg").doc(timestamp);

    void postClassMsg() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String,dynamic> data = {
          'classCode' : widget.snap['classCode'],
          'classMsg' : _msg.text,  // Updating Document Reference
          'timestamp' : timestamp,  // Updating Document Reference
          'dateTime' : dateTime,  // Updating Document Reference
          'uid' : FirebaseAuth.instance.currentUser?.uid, // Updating Document Reference
        };
        await reference.set(data).whenComplete((){
          Navigator.pop(context);
        });

      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(e.toString(), context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: FadeAnimation(1.1, Text("Share with you class")),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 100, left: 16, right: 16),
          child: FadeAnimation(
            1.2,
            TextField(
              controller: _msg,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autofocus: true,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "post your Doubts or class related message",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none),
              ),
            ),
          )),
      floatingActionButton: FadeAnimation(
        1.3,
        FloatingActionButton(
            child:
            _isLoading? CircularProgressIndicator(color: Colors.white,) :
            Icon(
              Icons.send_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              if(_msg == ""){

              }else{
                postClassMsg();
              }
            }),
      ),
    );
  }
}
