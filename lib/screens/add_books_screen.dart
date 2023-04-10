import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddBooksScreen extends StatefulWidget {
  const AddBooksScreen({Key? key}) : super(key: key);

  @override
  State<AddBooksScreen> createState() => _AddBooksScreenState();
}

class _AddBooksScreenState extends State<AddBooksScreen> {

  TextEditingController _subName = TextEditingController();
  TextEditingController _bookName = TextEditingController();
  TextEditingController _authorName = TextEditingController();
  TextEditingController _bookId = TextEditingController();
  TextEditingController _bookQty = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subName.dispose();
    _authorName.dispose();
    _bookName.dispose();
    _bookId.dispose();
    _bookQty.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    String dateTime = date + "  " + tDate;

    DocumentReference reference = FirebaseFirestore.instance.collection("books")
        .
    doc(timestamp);

    void uploadBook() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String, dynamic> data = {
          'authorName': _authorName.text, // Updating Document Reference
          'bookId': _bookId.text, // Updating Document Reference
          'bookName': _bookName.text, // Updating Document Reference
          'subjectName': _subName.text, // Updating Document Reference
          'bookQty': _bookQty.text, // Updating Document Reference
          'timestamp': timestamp, // Updating Document Reference
          'dateTime': dateTime, // Updating Document Reference
        };
        await reference.set(data).whenComplete(() {
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


    return
      Scaffold(
      appBar: AppBar(
        title: Text("Add books to library",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      ),
      body:
      Center(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          padding: MediaQuery
              .of(context)
              .size
              .width > webScreenSize
              ? EdgeInsets.symmetric(
              horizontal: MediaQuery
                  .of(context)
                  .size
                  .width / 3)
              : const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeAnimation(
                1.1,
                TextField(
                  controller: _subName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.book_outlined),
                    hintText: "SubjectName",
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
                  controller: _bookName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.book_online),
                    hintText: "Book Name",
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
                TextField(
                  controller: _authorName,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    hintText: "Author Name",
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
                1.4,
                TextField(
                  controller: _bookId,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    hintText: "Book Id/Book No.",
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
                1.5,
                TextField(
                  controller: _bookQty,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    hintText: "Book Quantity",
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
                1.6,
                Container(
                  height: 46,
                  width: double.infinity,
                  child:
                  ElevatedButton(
                      onPressed: () {
                        if (_subName.text.isNotEmpty && _bookName.text
                            .isNotEmpty && _authorName.text.isNotEmpty &&
                            _bookId.text.isNotEmpty &&
                            _bookQty.text.isNotEmpty) {
                          uploadBook();
                        } else {
                          showSnackBar(
                              "Please fill all the fields!!!", context);
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isLoading ? CircularProgressIndicator(
                        color: Colors.white,) :
                      Text("Upload Book".toUpperCase())
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
