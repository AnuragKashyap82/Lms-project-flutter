import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/widgets/atten_percent_widgets.dart';
import 'package:eduventure/widgets/students_widgets.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../widgets/students_report_widgets.dart';

class MonthlyAttendanceScreen extends StatefulWidget {
  final snap;

  const MonthlyAttendanceScreen({Key? key, required this.snap})
      : super(key: key);

  @override
  State<MonthlyAttendanceScreen> createState() =>
      _MonthlyAttendanceScreenState();
}

class _MonthlyAttendanceScreenState extends State<MonthlyAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.snap['subjectName'],
          style: TextStyle(fontSize: 16),
        ),
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
                            itemBuilder: (context, index) => GestureDetector(
                              child: GestureDetector(
                                child: Container(
                                  width: double.infinity,
                                  height: 85,
                                  child: FadeAnimation(
                                    1.1,
                                    AttendancePercentWidget(
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
                // _selectDate(context);
              },
              child: Container(
                height: 50.0,
                color: Colors.blue,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){

                        },
                        child:
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Center(
                                  child: Icon(
                                    Icons.calendar_month_sharp,
                                    color: Colors.white,
                                    size: 16,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Center(
                                child: Text(
                                  "April",
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
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Center(
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                    size: 16,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Center(
                                child: Text(
                                  "2023",
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
