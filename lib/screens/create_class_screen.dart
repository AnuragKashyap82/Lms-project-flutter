import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateClassScreen extends StatefulWidget {

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {

  TextEditingController _subName = TextEditingController();
  TextEditingController _className = TextEditingController();
  TextEditingController _selectTheme = TextEditingController();
  bool _isLoading = false;
  var userData = {};

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subName.dispose();
    _className.dispose();
    _selectTheme.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      userData = userSnap.data()!;

    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {

    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();

    DocumentReference ref = FirebaseFirestore.instance.collection("classroom").
    doc(timestamp);

    DocumentReference reference =  FirebaseFirestore.instance.collection("users").
        doc(FirebaseAuth.instance.currentUser?.uid).collection("classroom").doc(timestamp);

    void joinYourSelf() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String,dynamic> data = {
          'classCode' : timestamp,
          'className' : _className.text,  // Updating Document Reference
          'subjectName' : _subName.text,  // Updating Document Reference
          'theme' : _selectTheme.text,  // Updating Document Reference
          'uid' : FirebaseAuth.instance.currentUser?.uid,  // Updating Document Reference
          'name' : userData['name'],  // Updating Document Reference
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
      }
    }

    void createClass() async{
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String,dynamic> data = {
          'classCode' : timestamp,
          'className' : _className.text,  // Updating Document Reference
          'subjectName' : _subName.text,
          'theme' : _selectTheme.text,// Updating Document Reference
          'uid' : FirebaseAuth.instance.currentUser?.uid,
          'name' : userData['name'],// Updating Document Reference
        };
         await ref.set(data).whenComplete((){
          joinYourSelf();
        });

      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(e.toString(), context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Class"),
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
                controller: _className,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.book_online),
                  hintText: "ClassName/branch/sem",
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
                controller: _selectTheme,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.book_online),
                  hintText: "range  1 to 5",
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
              1.4,
              Expanded(
                child: Container(
                  height: 46,
                  width: double.infinity,
                  child:
                  ElevatedButton(
                      onPressed: () {
                        if(_subName.text.isEmpty || _className.text.isEmpty ){
                          showSnackBar("Please Fill all the fields!!!", context);
                        }else if (int.parse(_selectTheme.text) >= 1 && int.parse(_selectTheme.text) < 6){
                          createClass();
                        }else{
                          showSnackBar("Range Value 1 to 5", context);
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: _isLoading ? CircularProgressIndicator(color: Colors.white,) :
                      Text("Create Class".toUpperCase())
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
