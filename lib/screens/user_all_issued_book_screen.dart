import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:eduventure/widgets/applied_card.dart';
import 'package:eduventure/widgets/issued_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserAllIssuedBooksScreen extends StatefulWidget {
  final snap;

  const UserAllIssuedBooksScreen({Key? key, required this.snap})
      : super(key: key);

  @override
  State<UserAllIssuedBooksScreen> createState() =>
      _UserAllIssuedBooksScreenState();
}
bool _isLoading = false;

class _UserAllIssuedBooksScreenState extends State<UserAllIssuedBooksScreen> {
  @override
  Widget build(BuildContext context) {

    var _qtyCountData  = {};

    DateTime time = DateTime.now();

    void increaseBookCount(String bookQty, String timestamp) async {
      setState(() {
        _isLoading = true;
      });
      int qtyCount = int.parse(bookQty);
      String newQtyCount = (qtyCount + 1).toString();
      DocumentReference ref = FirebaseFirestore.instance
          .collection("books")
          .doc(timestamp);
      try {
        Map<String, dynamic> data = {
          'bookQty': newQtyCount,
        };
        await ref.update(data).whenComplete(() {
          setState(() {
            _isLoading = true;
            Navigator.pop(context);
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

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    String dateTime = date + "  " + tDate;

    void checkQtyCount(String timestamp) async {
        try {
          var qtyCountSnap = await FirebaseFirestore.instance
              .collection("books")
              .doc(timestamp)
              .get();
          if(qtyCountSnap.exists){
            setState(() {
              _qtyCountData = qtyCountSnap.data()!;
            });
            increaseBookCount(_qtyCountData['bookQty'], timestamp);

          }else{

          }
          setState(() {});
        } catch (e) {
          showSnackBar(e.toString(), context);
        }
        setState(() {
          _isLoading = false;
        });
    }

    void addUid(final snap1) async {
      setState(() {
        _isLoading = true;
      });
      DocumentReference reference1 = FirebaseFirestore.instance
          .collection("returnedBooks")
          .doc(snap1['uid']);
      try {
        Map<String, dynamic> data = {
          'uid': snap1['uid'],
        };
        await reference1.set(data).whenComplete(() {
          setState(() {
            _isLoading = true;
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

    void deleteIssuedBooks(final snap1) async {
      setState(() {
        _isLoading = true;
      });
      DocumentReference reference1 = FirebaseFirestore.instance
          .collection("issuedBooks")
          .doc(widget.snap['uid'])
          .collection("Books")
          .doc(snap1['timestamp']);
      try {
        await reference1.delete().whenComplete(() {
          setState(() {
            _isLoading = true;
          });
          addUid(snap1);
          checkQtyCount(snap1['timestamp']);
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


    void _confirnReturn(final snap1) async {
      setState(() {
        _isLoading = true;
      });
      DocumentReference reference = FirebaseFirestore.instance
          .collection("returnedBooks")
          .doc(widget.snap['uid'])
          .collection("Books")
          .doc(snap1['timestamp']);
      try {
        Map<String, dynamic> data = {
          'returnedDate': dateTime, // Updating Document Reference
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
          deleteIssuedBooks(snap1);
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
        title: Text("All Issued Books"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("issuedBooks")
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
                                                      "Return Book",
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
                                                                _confirnReturn(
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
                                                              child: _isLoading ? CircularProgressIndicator(color: Colors.white,):
                                                              Text("Confirm"))

                                                      ),
                                                    ]),
                                              ],
                                            ))),
                                  );
                                });
                          },
                          child: IssuedCard(
                              snap: snapshot.data!.docs[index].data()))),
                );
              },
            );
          }),
    );
  }
}
