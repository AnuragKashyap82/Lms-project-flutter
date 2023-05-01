import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/resource/firestore_methods.dart';
import 'package:eduventure/screens/report_screen.dart';
import 'package:eduventure/widgets/students_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../animations/fade_animation.dart';

class AttendanceScreen extends StatefulWidget {
  final snap;

  const AttendanceScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool _isLoading = false;
  bool _isClassCreated = false;
  var _classCountData= {};
  int noOfStudents = 0;
  int attendanceCount = 0;
  int totalClassCount = 0;
  String currentYear = DateTime
      .now()
      .year
      .toString();
  String currentMonthName = DateFormat('MMMM').format(DateTime.now());
  String currentDay = DateFormat('d').format(DateTime.now());

  void getAttendanceCount() {
    String year = DateTime
        .now()
        .year
        .toString();
    String month = DateFormat('MMMM').format(DateTime.now());
    String date = DateFormat('d').format(DateTime.now());
    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('classroom')
        .doc(widget.snap['classCode'])
        .collection("Attendance")
        .doc("$date-$month-$year")
        .collection("Students");
    collectionRef.get().then((QuerySnapshot snapshot) {
      setState(() {
        attendanceCount = snapshot.size;
      });
    });
  }

  void getTotalNoClass()async  {
    String year = DateTime
        .now()
        .year
        .toString();
    String month = DateFormat('MMMM').format(DateTime.now());
      try {
        var userSnap = await FirebaseFirestore.instance
            .collection("classroom")
            .doc(widget.snap['classCode'])
        .collection("ClassCount")
        .doc("$month-$year")
            .get();
        if (userSnap.exists) {
          setState(() {
            _classCountData = userSnap.data()!;
          });
        } else {}
        setState(() {});
      } catch (e) {

      }

  }

  void getNoOfStudents() {
    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('classroom')
        .doc(widget.snap['classCode'])
        .collection("students");
    collectionRef.get().then((QuerySnapshot snapshot) {
      setState(() {
        noOfStudents = snapshot.size;
      });
    });
  }

  void checkClassCreated() async {
    try {
      var classCreatedSnap = await FirebaseFirestore.instance
          .collection("classroom")
          .doc(widget.snap['classCode'])
          .collection("Attendance")
          .doc("$currentDay-$currentMonthName-$currentYear")
          .get();
      if (classCreatedSnap.exists) {
        setState(() {
          _isClassCreated = true;
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkClassCreated();
    getNoOfStudents();
    getAttendanceCount();
    getTotalNoClass();
  }

  @override
  Widget build(BuildContext context) {
    void createTodayClass() async {
      setState(() {
        _isLoading = true;
      });

      await FireStoreMethods()
          .createTodayAttendance(
        year: currentYear,
        month: currentMonthName,
        date: currentDay,
        classCode: widget.snap['classCode'],
      )
          .then((value) {
        FireStoreMethods().increaseClassCount(year: currentYear,
            month: currentMonthName,
            classCode: widget.snap['classCode'],
            classCount: _classCountData['classCount'] + 1);
        setState(() {
          _isLoading = false;
          _isClassCreated = true;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.snap['subjectName'],
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                "${_classCountData['classCount']}",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.snap['className']}",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Total No Of Students: $noOfStudents",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                "Total No Of Attendance: $attendanceCount",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 52,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2 - 32,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ReportScreen(
                                      snap: widget.snap,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Text("Report"),
                    ),
                  ),
                  !_isClassCreated
                      ? SizedBox(
                    height: 52,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2 - 32,
                    child: ElevatedButton(
                        onPressed: () async {
                          createTodayClass();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: _isLoading
                            ? CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                            : Text("Create Attendance")),
                  )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Quick Attendance",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 16,
              ),
              _isClassCreated
                  ? noOfStudents == attendanceCount
                  ? Center(
                  child: Container(
                    child: Text(
                      "All Attendance are marked",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.normal),
                    ),
                  ))
                  : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("classroom")
                      .doc(widget.snap['classCode'])
                      .collection("students")
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
                        itemBuilder: (context, index) =>
                            GestureDetector(
                              child: GestureDetector(
                                child: Container(
                                  width: double.infinity,
                                  height: 85,
                                  child: FadeAnimation(
                                    1.1,
                                    StudentWidgets(
                                      snap: snapshot.data!.docs[index]
                                          .data(),
                                      classCode:
                                      widget.snap['classCode'],
                                    ),
                                  ),
                                ),
                              ),
                            ));
                  })
                  : Center(
                child: Container(
                  child: Text(
                    "No Class Created!!!!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
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
