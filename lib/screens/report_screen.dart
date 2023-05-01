import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/screens/monthly_attendance_screen.dart';
import 'package:eduventure/widgets/students_report_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../animations/fade_animation.dart';

class ReportScreen extends StatefulWidget {
  final snap;

  const ReportScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime selectedDate = DateTime.now();
  String pickedDate =
      "${DateFormat('d').format(DateTime.now())}-${DateFormat('MMMM').format(DateTime.now())}-${DateTime.now().year.toString()}";
  String pickedMonth = "April";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2013, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      if (picked.month == 4) {
        setState(() {
          pickedMonth = "April";
        });
      } else if (picked == 1) {
        setState(() {
          pickedMonth = "January";
        });
      } else if (picked == 2) {
        setState(() {
          pickedMonth = "February";
        });
      } else if (picked == 3) {
        setState(() {
          pickedMonth = "Marck";
        });
      } else if (picked == 5) {
        setState(() {
          pickedMonth = "January";
        });
      } else if (picked == 6) {
        setState(() {
          pickedMonth = "January";
        });
      } else if (picked == 7) {
        setState(() {
          pickedMonth = "January";
        });
      } else if (picked == 8) {
        setState(() {
          pickedMonth = "January";
        });
      } else if (picked == 9) {
        setState(() {
          pickedMonth = "January";
        });
      } else if (picked == 10) {
        setState(() {
          pickedMonth = "January";
        });
      } else if (picked == 11) {
        setState(() {
          pickedMonth = "January";
        });
      } else if (picked == 12) {
        setState(() {
          pickedMonth = "January";
        });
      }
      setState(() {
        pickedDate = "${picked.day}-$pickedMonth-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.snap['subjectName'],
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MonthlyAttendanceScreen(
                            snap: widget.snap,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.date_range,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("classroom")
                          .doc(widget.snap['classCode'])
                          .collection("Attendance")
                          .doc(pickedDate)
                          .collection("Students")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        }
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => GestureDetector(
                                  child: GestureDetector(
                                    child: Container(
                                      width: double.infinity,
                                      height: 85,
                                      child: FadeAnimation(
                                        1.1,
                                        StudentReportsWidgets(
                                          snap:
                                              snapshot.data!.docs[index].data(),
                                          classCode: widget.snap['classCode'],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                      })
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                height: 50.0,
                color: Colors.blue,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Icon(
                        Icons.date_range_sharp,
                        color: Colors.white,
                        size: 16,
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      Center(
                        child: Text(
                          pickedDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
