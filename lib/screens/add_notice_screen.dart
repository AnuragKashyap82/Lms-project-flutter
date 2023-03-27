import 'dart:convert';
import 'dart:io';

import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/resource/storage_methods.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddNoticeScreen extends StatefulWidget {
  const AddNoticeScreen({Key? key}) : super(key: key);

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    // final fileName = file != null ? base64Decode(file!.path) : "No files Selected";

    final Storage storage = Storage();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notice"),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.attach_file),
            ),
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ['png', 'jpg'],
              );
              if (result == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("No files Selected"),
                ));
                return null;
              }
              final path = result.files.single.path!;
              final fileName = result.files.single.name;

              print(path);
              print(fileName);

              storage.uploadFile(path, fileName).then((value) => print("Done"));
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
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.line_axis),
                  hintText: "Notice Title",
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: Text("Upload Notice".toUpperCase())),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
