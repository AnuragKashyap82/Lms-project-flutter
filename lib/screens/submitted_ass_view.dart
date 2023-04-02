import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '../animations/fade_animation.dart';

class SubmittedAssViewScreen extends StatefulWidget {
  final snap;

  const SubmittedAssViewScreen({Key? key, required this.snap})
      : super(key: key);

  @override
  State<SubmittedAssViewScreen> createState() => _SubmittedAssViewScreenState();
}

class _SubmittedAssViewScreenState extends State<SubmittedAssViewScreen> {
  bool _isLoading = false;
  TextEditingController _obtainedMarks = TextEditingController();

  late PdfController pdfController;

  loadController() {
    pdfController = PdfController(
        document: PdfDocument.openData(InternetFile.get(widget.snap['url'])));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadController();
  }

  @override
  Widget build(BuildContext context) {

    DocumentReference reference = FirebaseFirestore.instance
        .collection("classroom")
        .doc(widget.snap["classCode"])
        .collection("assignment")
        .doc(widget.snap["assignmentId"])
        .collection("submission")
        .doc(widget.snap["uid"]);

    void uploadMarks() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String, dynamic> data = {
          'marksObtained': _obtainedMarks.text,
        };
        await reference.update(data).whenComplete(() {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.snap['assignmentName'],
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: PdfView(
        controller: pdfController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              context: context,
              builder: (context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          1.1,
                          Row(
                            children: [
                              Icon(Icons.arrow_back),
                              Expanded(
                                child: Text(
                                  "Otained Marks",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: colorPrimary),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        FadeAnimation(
                          1.2,
                          Text(
                            "Provide marks to this student according to their submitted Assignment",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FadeAnimation(
                          1.3,
                          TextField(
                            controller: _obtainedMarks,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.assignment_outlined),
                              hintText: "Enter Obtained Marks",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: FadeAnimation(
                                1.4,
                                ElevatedButton(
                                    onPressed: () {
                                      if (_obtainedMarks.text.isEmpty) {
                                        showSnackBar(
                                            "Enter Marks Obtained", context);
                                      } else {
                                        uploadMarks();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder()),
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text("Submit")))),
                      ],
                    ),
                  ));
        },
        child: Icon(Icons.edit_note_outlined),
      ),
    );
  }
}
