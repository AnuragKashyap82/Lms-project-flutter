import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:eduventure/widgets/applied_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../animations/fade_animation.dart';
import '../widgets/books_card.dart';

class UserAllAppliedBooksScreen extends StatefulWidget {
  final snap;

  const UserAllAppliedBooksScreen({Key? key, required this.snap})
      : super(key: key);

  @override
  State<UserAllAppliedBooksScreen> createState() =>
      _UserAllAppliedBooksScreenState();
}

bool _isLoading = false;

class _UserAllAppliedBooksScreenState extends State<UserAllAppliedBooksScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    String dateTime = date + "  " + tDate;

    void addUid(final snap1) async {
      setState(() {
        _isLoading = true;
      });
      DocumentReference reference1 = FirebaseFirestore.instance
          .collection("issuedBooks")
          .doc(snap1['uid']);
      try {
        Map<String, dynamic> data = {
          'uid': snap1['uid'],
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

    void deleteIssuedApplied(final snap1) async {
      setState(() {
        _isLoading = true;
      });
      DocumentReference reference1 = FirebaseFirestore.instance
          .collection("issuedApplied")
          .doc(widget.snap['uid'])
          .collection("Books")
          .doc(snap1['timestamp']);
      try {
        await reference1.delete().whenComplete(() {
          setState(() {
            _isLoading = true;
          });
          addUid(snap1);
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

    void _confirmIssue(final snap1) async {
      setState(() {
        _isLoading = true;
      });
      DocumentReference reference = FirebaseFirestore.instance
          .collection("issuedBooks")
          .doc(widget.snap['uid'])
          .collection("Books")
          .doc(snap1['timestamp']);
      try {
        Map<String, dynamic> data = {
          'issueDate': dateTime, // Updating Document Reference
          'timestamp':snap1['timestamp'],
          'uid': widget.snap['uid'],
          'authorName': snap1['authorName'],
          'bookId': snap1['bookId'],
          'bookName': snap1['bookName'],
          'subjectName': snap1['subjectName'],
        };
        await reference.set(data).whenComplete(() {
          setState(() {
            _isLoading = true;
          });
          deleteIssuedApplied(snap1);
          showSnackBar("done", context);
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
        title: Text("All Applied Books"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("issuedApplied")
              .doc(widget.snap['uid'])
              .collection("Books")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisExtent: 127),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: FadeAnimation(
                      1.1,
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return
                                    AlertDialog(
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
                                        height: 220,
                                        width: 300,
                                        child: SingleChildScrollView(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Issue Book",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "Book Name:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 42,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                    border: Border.all(
                                                        color: Colors
                                                            .blue.shade100),
                                                    color: Colors.blue.shade100,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      snapshot.data!.docs[index]
                                                          .data()['bookName'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Book Id:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 42,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                    border: Border.all(
                                                        color: Colors
                                                            .blue.shade100),
                                                    color: Colors.blue.shade100,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      snapshot.data!.docs[index]
                                                          .data()['bookId'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          width: 130,
                                                          height: 42,
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      shape:
                                                                          StadiumBorder()),
                                                              child: Text(
                                                                  "Cancel"))),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      SizedBox(
                                                          width: 130,
                                                          height: 42,
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                _confirmIssue(
                                                                    snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data());
                                                              },
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      shape:
                                                                          StadiumBorder()),
                                                              child: Text(
                                                                  "Confirm"))),
                                                    ]),
                                              ],
                                            ))),
                                  );
                                });
                          },
                          child: AppliedCard(
                              snap: snapshot.data!.docs[index].data()))),
                );
              },
            );
          }),
    );
  }
}
