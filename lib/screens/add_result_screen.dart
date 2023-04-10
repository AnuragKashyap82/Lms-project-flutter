import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../animations/fade_animation.dart';

class AddResultScreen extends StatefulWidget {
  const AddResultScreen({Key? key}) : super(key: key);

  @override
  State<AddResultScreen> createState() => _AddResultScreenState();
}
class _AddResultScreenState extends State<AddResultScreen> {

  TextEditingController _resultYear = TextEditingController();
  String semester = "Select Your Semester";
  String branch = "Select Your branch";
  bool _isLoading = false;
  UploadTask? task;
  File? file;
  String url = "";
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {

    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String dateTime = date;
    ;
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    DocumentReference reference =  FirebaseFirestore.instance.collection("Result").
    doc(semester).collection(branch).doc(timestamp);

    DocumentReference ref =  FirebaseFirestore.instance.collection("Result").
    doc(semester);

    void uploadSemester() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String,dynamic> data = {
          'semester' : semester, // Updating Document Reference
        };
        await ref.set(data).whenComplete((){
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
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

    void uploadResult() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String,dynamic> data = {
          'semester' : semester,  // Updating Document Reference
          'resultYear' : _resultYear.text,  // Updating Document Reference
          'branch' : branch,  // Updating Document Reference
          'resultUrl' : url, // Updating Document Reference
          'dateTime' : dateTime, // Updating Document Reference
          'uid' : FirebaseAuth.instance.currentUser?.uid, // Updating Document Reference
        };
        await reference.set(data).whenComplete((){
          uploadSemester();
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

    Future getPdfAndUpload() async {

      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['pdf']);

      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No files Selected"),
        ));
        return null;
      }
      setState(() {
        _isUploading = true;
      });
      final path = result.files.single.path!;

      DateTime time = DateTime.now();
      String timestamp = time.millisecondsSinceEpoch.toString();

      File file = File(path);
      try{
        final  Reference storageReference = FirebaseStorage.instance.ref().child("Result").child(timestamp);
        UploadTask uploadTask = storageReference.putFile(file);
        url = await (await uploadTask).ref.getDownloadURL();
        showSnackBar(url, context);
        setState(() {
          _isUploading = false;
        });
      }on FirebaseException catch(e){
        setState(() {
          _isUploading = false;
        });
        print(e);
        showSnackBar(e.toString(), context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isUploading ? CircularProgressIndicator(color: Colors.white, ):Icon(Icons.attach_file),
            ),
            onTap: ()  {
              getPdfAndUpload();
            },
          )
        ],
        title: Text("Add Result Screen"),
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
                  controller: _resultYear,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    hintText: "Result Year",
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
                        } else if(branch == "Select Your branch") {
                          showSnackBar("Select Your branch", context);
                        }else if(url == ""){
                          showSnackBar("Pick Result PDF", context);
                        }else if(_resultYear.text.isEmpty){
                          showSnackBar("Enter Result Year", context);
                        }else{
                          uploadResult();
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isLoading
                          ? Center(
                            child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                          )
                          : Text("Upload Result")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
