import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/resource/firestore_methods.dart';
import 'package:flutter/material.dart';
import '../utils/global_variables.dart';

class AttendancePercentWidget extends StatefulWidget {
  final snap;
  final String classCode;

  const AttendancePercentWidget({Key? key,required this.snap, required this.classCode}) : super(key: key);

  @override
  State<AttendancePercentWidget> createState() => _AttendancePercentWidgetState();
}

class _AttendancePercentWidgetState extends State<AttendancePercentWidget> {
  bool _isLoading = false;
  var _studentsData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadUserDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadUserDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.snap['uid'])
          .get();
      if (userSnap.exists) {
        setState(() {
          _studentsData = userSnap.data()!;
        });
      } else {}
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("student widget gets called!!!");
    return _isLoading
        ? Container()
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_studentsData['name']}",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            const  SizedBox(
                height: 4,
              ),
              Text(
                "${_studentsData['studentId']}",
                style: const  TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
         const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "?? %",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )
          )
        ],
      ),
    );
  }
}
