import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../utils/global_variables.dart';
import 'add_result_screen.dart';
import 'all_result_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

String semester = "Select Your Semester";
String branch = "Select Your branch";
bool _isLoading = false;

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeAnimation(
                  1.1,
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              alignment: Alignment(0.0, 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                top: 10.0,
                              ),
                              insetPadding:
                                  EdgeInsets.symmetric(horizontal: 21),
                              content: Container(
                                  height: 280,
                                  width: 300,
                                  child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Select Your Semester",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                semester = "1st Semester";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "1st Semester",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                semester = "2nd Semester";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "2nd Semester",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                semester = "3rd Semester";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "3rd Semester",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                semester = "4th Semester";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "4th Semester",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                semester = "5th Semester";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "5th Semester",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                semester = "6th Semester";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "6th Semester",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ))),
                            );
                          });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(color: Colors.blue.shade100),
                          color: Colors.blue.shade100),
                      child: Center(
                        child: Text(
                          "${semester}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 8,
              ),
              FadeAnimation(
                  1.2,
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              alignment: Alignment(0.0, 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                top: 10.0,
                              ),
                              insetPadding:
                                  EdgeInsets.symmetric(horizontal: 21),
                              content: Container(
                                  height: 250,
                                  width: 300,
                                  child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Select Your branch",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                branch = "cse";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "CSE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                branch = "me";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "ME",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                branch = "ece";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "ECE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                branch = "ee";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "EE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                branch = "ce";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "CE",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ))),
                            );
                          });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(color: Colors.blue.shade100),
                          color: Colors.blue.shade100),
                      child: Center(
                        child: Text(
                          "${branch}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              FadeAnimation(
                1.3,
                Container(
                  height: 46,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (semester == "Select Your Semester") {
                          showSnackBar("Select Your Semester", context);
                        } else if (branch == "Select Your branch") {
                          showSnackBar("Select Your branch", context);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllResultScreen(
                                        branch: branch,
                                        semester: semester,
                                      )));
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Check Result")),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddResultScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
