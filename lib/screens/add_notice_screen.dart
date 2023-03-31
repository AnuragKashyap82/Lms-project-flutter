import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/resource/storage_methods.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNoticeScreen extends StatefulWidget {
  const AddNoticeScreen({Key? key}) : super(key: key);

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {

  TextEditingController _noticeTitle = TextEditingController();
  TextEditingController _noticeNo = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _noticeNo.dispose();
    _noticeNo.dispose();
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
    ;
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    DocumentReference reference =  FirebaseFirestore.instance.collection("Notice").
    doc(timestamp);

    void uploadNotice() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String,dynamic> data = {
          'noticeTitle' : _noticeTitle.text,  // Updating Document Reference
          'noticeNo' : _noticeNo.text,  // Updating Document Reference
          'noticeId' : timestamp, // Updating Document Reference
          'noticeUrl' : url, // Updating Document Reference
          'dateTime' : dateTime, // Updating Document Reference
          'uid' : FirebaseAuth.instance.currentUser?.uid, // Updating Document Reference
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
        final  Reference storageReference = FirebaseStorage.instance.ref().child("Notice").child(timestamp);
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
        title: Text("Add Notice"),
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
      ),
      body:
      Container(
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            FadeAnimation(
              1.1,
              TextField(
                controller: _noticeTitle,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.line_axis),
                  hintText: "Notice Title",
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
                controller: _noticeNo,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.line_axis),
                  hintText: "Notice No",
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
              height: 40,
            ),
            FadeAnimation(
              1.3,
              Expanded(
                child: Container(
                  height: 46,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if(url == ""){
                          showSnackBar("Please Pick Pdf", context);
                        }else{
                          if(_noticeTitle.text.isEmpty){
                            showSnackBar("Enter Notice Title", context);
                          }else if(_noticeNo.text.isEmpty){
                            showSnackBar("Enter Notice No", context);
                          }else{
                            uploadNotice();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isLoading ? CircularProgressIndicator(color: Colors.white,) :
                      Text("Upload Notice")
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
