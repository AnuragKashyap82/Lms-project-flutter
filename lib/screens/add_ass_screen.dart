import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/global_variables.dart';

class AddAssignmentScreen extends StatefulWidget {
  final snap;

  const AddAssignmentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {

  TextEditingController _assNameController = TextEditingController();
  TextEditingController _fullMarksController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String pickedDate = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        pickedDate = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  UploadTask? task;
  File? file;
  String url = "";
  bool _isUploading = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String dateTime = date;
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    DocumentReference reference =  FirebaseFirestore.instance.collection("classroom").doc(widget.snap['classCode']).collection("assignment").
    doc(timestamp);

    void uploadAss() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String,dynamic> data = {
          'assignmentId' : timestamp,  // Updating Document Reference
          'assignmentName' : _assNameController.text,  // Updating Document Reference
          'classCode' : widget.snap['classCode'], // Updating Document Reference
          'dueDate' : pickedDate, // Updating Document Reference
          'dateTime' : dateTime, // Updating Document Reference// Updating Document Reference
          'uid' : FirebaseAuth.instance.currentUser?.uid, // Updating Document Reference
          'url' : url,
        };
        await reference.set(data).whenComplete((){
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
        final  Reference storageReference = FirebaseStorage.instance.ref().child("Assignment").child(timestamp);
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
        title: FadeAnimation(1.1, Text("Add Assignment",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _isUploading ? Center(child: CircularProgressIndicator(color: Colors.white, )):Icon(Icons.picture_as_pdf_outlined),
            ),
            onTap: ()  {
              getPdfAndUpload();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            FadeAnimation(
              1.1,
              TextField(
                controller: _assNameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.assignment_outlined),
                  hintText: "Assignment Name",
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
                controller: _fullMarksController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.book_online_outlined),
                  hintText: "Full Marks",
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
                onTap: () => _selectDate(context),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: Colors.blue.shade100),
                    color: Colors.blue.shade100
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.calendar_month_outlined,),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(pickedDate,style: TextStyle(
                            fontWeight: FontWeight.bold), textAlign: TextAlign.start
                            ,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            FadeAnimation(
              1.4,
              Expanded(
                child: Container(
                  height: 46,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if(url == ""){
                          showSnackBar("Please Pick Pdf", context);
                        }else{
                          if(_assNameController.text.isEmpty){
                            showSnackBar("Enter Ass Name", context);
                          }else if(_fullMarksController.text.isEmpty){
                            showSnackBar("Enter Full Marks No", context);
                          }else if(pickedDate == ""){
                            showSnackBar("Enter Full Marks No", context);
                          }else{
                            uploadAss();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child:  _isLoading ? CircularProgressIndicator(color: Colors.white,) :
                      const Text('Upload')
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
