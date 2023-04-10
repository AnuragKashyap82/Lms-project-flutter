import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../utils/global_variables.dart';

class AddStudentIdScreen extends StatefulWidget {
  const AddStudentIdScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentIdScreen> createState() => _AddStudentIdScreenState();
}

class _AddStudentIdScreenState extends State<AddStudentIdScreen> {
  TextEditingController _studentId = TextEditingController(text: "20901100");
  TextEditingController _phoneNo = TextEditingController();
  String userType = "Select User Type";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String docName = _studentId.text.toString();
    DocumentReference reference =
        FirebaseFirestore.instance.collection("UniqueId").doc(docName);

    void addStudentId() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String, dynamic> data = {
          'phone': _phoneNo.text, // Updating Document Reference
          'studentId': _studentId.text,
          'userType': userType,
        };
        await reference.set(data).whenComplete(() {
          setState(() {
            _isLoading = false;
          });
          showSnackBar('Added Id', context);
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(e.toString(), context);
        setState(() {
          _isLoading = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Student Id",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                TextField(
                  controller: _studentId,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_add_alt_1),
                    hintText: "Unique Id",
                    filled: true,
                    fillColor: Colors.blue.shade100,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FadeAnimation(
                1.2,
                TextField(
                  controller: _phoneNo,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_in_talk),
                    hintText: "Phone No.",
                    fillColor: Colors.blue.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FadeAnimation(
                  1.3,
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
                                  height: 110,
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
                                                "Select User type",
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
                                                userType = "user";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Text(
                                                "user",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                userType = "admin";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 16, bottom: 16),
                                              child: Text(
                                                "admin",
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
                          "${userType}",
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
                1.4,
                Container(
                  height: 46,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_studentId.text.isEmpty) {
                          showSnackBar("Enter Student Id", context);
                        } else if (_phoneNo.text.isEmpty) {
                          showSnackBar("Enter Phone No", context);
                        } else if (userType == "Select User Type") {
                          showSnackBar("Select User Type", context);
                        } else {
                          addStudentId();
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Add Unique Id")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
