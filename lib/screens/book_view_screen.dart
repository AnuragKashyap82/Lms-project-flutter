import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookViewScreen extends StatefulWidget {
  final snap;

  const BookViewScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<BookViewScreen> createState() => _BookViewScreenState();
}

class _BookViewScreenState extends State<BookViewScreen> {
  bool _isAvailable = true;
  bool _isButtonDisabled = false;
  bool _isLoading = false;
  bool _alreadyIssued = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAvailable();
    checkAleadyIssued();
  }

  void checkAvailable() {
    if (widget.snap['bookQty'] == "" || widget.snap['bookQty'] == "0") {
      setState(() {
        _isAvailable = false;
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isAvailable = true;
        _isButtonDisabled = false;
      });
    }
  }

  void checkAleadyIssued() async {
    try {
      var uniqueIdSnap = await FirebaseFirestore.instance
          .collection("issuedApplied")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("Books")
          .doc(widget.snap['timestamp'])
          .get();
      if (uniqueIdSnap.exists) {
        setState(() {
          _alreadyIssued = true;
        });
      } else {}
      setState(() {

      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    String dateTime = date + "  " + tDate;

    int qtyCount = int.parse(widget.snap['bookQty']);
    String newQtyCount = (qtyCount - 1).toString();

    DocumentReference ref = FirebaseFirestore.instance
        .collection("books")
        .doc(widget.snap['timestamp']);

    DocumentReference reference = FirebaseFirestore.instance
        .collection("issuedApplied")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("Books")
        .doc(widget.snap['timestamp']);

    DocumentReference reference1 = FirebaseFirestore.instance
        .collection("issuedApplied")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString());

    void addUid() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String, dynamic> data = {
          'uid': FirebaseAuth.instance.currentUser?.uid,
        };
        await reference1.set(data).whenComplete(() {
          setState(() {
            _isLoading = true;
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

    void decreaceBookCount() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String, dynamic> data = {
          'bookQty': newQtyCount,
        };
        await ref.update(data).whenComplete(() {
          setState(() {
            _isLoading = true;
            addUid();
          });

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

    void ApplyForIssueBook() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String, dynamic> data = {
          'authorName': widget.snap['authorName'], // Updating Document Reference
          'bookId': widget.snap['bookId'], // Updating Document Reference
          'bookName':widget.snap['bookName'], /// Updating Document Reference
          'subjectName': widget.snap['subjectName'], /// Updating Document Reference
          'appliedDate': dateTime, // Updating Document Reference
          'timestamp': widget.snap['timestamp'],
          'uid': FirebaseAuth.instance.currentUser?.uid,
        };
        await reference.set(data).whenComplete(() {
          setState(() {
            _isLoading = true;
          });
          decreaceBookCount();
          showSnackBar(newQtyCount, context);

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
        title: Text(widget.snap['subjectName'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: Center(
        child: FadeAnimation(
          1.1,
          Card(
            elevation: 15,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(26))),
            color: Colors.blue.shade100,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 300,
                height: 380,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FadeAnimation(
                      1.2,
                      Text(
                        "Book Name:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    FadeAnimation(
                      1.3,
                      Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.grey.shade200),
                            color: Colors.grey.shade200),
                        child: Center(
                          child: FadeAnimation(
                            1.4,
                            Text(
                              widget.snap['bookName'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.5,
                      Text(
                        "Author Name:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    FadeAnimation(
                      1.6,
                      Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.grey.shade200),
                            color: Colors.grey.shade200),
                        child: Center(
                          child: FadeAnimation(
                            1.7,
                            Text(
                              widget.snap['authorName'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.8,
                      Text(
                        "Book Id:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    FadeAnimation(
                      1.9,
                      Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.grey.shade200),
                            color: Colors.grey.shade200),
                        child: Center(
                          child: FadeAnimation(
                            2.0,
                            Text(
                              widget.snap['bookId'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      2.1,
                      Text(
                        "Quantity Available:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    FadeAnimation(
                      2.2,
                      Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.grey.shade200),
                            color: Colors.grey.shade200),
                        child: Center(
                          child: FadeAnimation(
                            2.3,
                            Text(
                              widget.snap['bookQty'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2.5,
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_isButtonDisabled) {
                                showSnackBar("Book Not Available", context);
                              } else if(_alreadyIssued){
                                showSnackBar("Already Issued!!", context);
                              }else{
                                ApplyForIssueBook();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder()),
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("Issue".toUpperCase())),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
