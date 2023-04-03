import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JoinClassScreen extends StatefulWidget {
  const JoinClassScreen({Key? key}) : super(key: key);

  @override
  State<JoinClassScreen> createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  TextEditingController _classCode = TextEditingController();
  bool _isLoading = false;
  var userData = {};
  var teacherNameData = {};

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _classCode.dispose();
  }

  void loadClassDetails() async {
    setState(() {
      _isLoading = true;
    });
    var userSnap = await FirebaseFirestore.instance
        .collection("classroom")
        .doc(_classCode.text)
        .get();

    userData = userSnap.data()!;
    loadTeacherName();

  }

  void loadTeacherName() async {
    setState(() {
      _isLoading = true;
    });
    var nameSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(userData['uid'])
        .get();

    teacherNameData = nameSnap.data()!;
    joinClass();
  }

  void joinClass() async {
    setState(() {
      _isLoading = true;
    });
    DocumentReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("classroom")
        .doc(_classCode.text);
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, dynamic> data = {
        'classCode': _classCode.text,
        'className': userData['className'], // Updating Document Reference
        'subjectName': userData['subjectName'], // Updating Document Reference
        'theme': userData['theme'], // Updating Document Reference
        'uid': userData['uid'], // Updating Document Reference
        'name': teacherNameData['name'], // Updating Document Reference
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
    }
  }

  void checkAlreadyJoined() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var classSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("classroom")
          .doc(_classCode.text)
          .get();

      if (classSnap.exists) {
        showSnackBar("Already Joined!!!", context);
        setState(() {
          _isLoading = false;
        });
      } else {
        loadClassDetails();
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void checkIfClassExists() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var classSnap = await FirebaseFirestore.instance
          .collection("classroom")
          .doc(_classCode.text)
          .get();

      if (classSnap.exists) {
        checkAlreadyJoined();
      } else {
        showSnackBar("Class Code Does Not Exits", context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Class"),
      ),
      body: Container(
        padding: EdgeInsets.all(26),
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            FadeAnimation(
              1.1,
              TextField(
                controller: _classCode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.book_outlined),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  hintText: "Classroom Code",
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
              height: 40,
            ),
            FadeAnimation(
              1.3,
              Container(
                height: 46,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      checkIfClassExists();
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    child: _isLoading ? CircularProgressIndicator(color: Colors.white,) :
                    Text("Join Class".toUpperCase())
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
