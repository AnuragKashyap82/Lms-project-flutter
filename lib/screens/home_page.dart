import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/add_student_id_screen.dart';
import 'package:eduventure/screens/classroom_screen.dart';
import 'package:eduventure/screens/library_screen.dart';
import 'package:eduventure/screens/login_screen.dart';
import 'package:eduventure/screens/notice_screen.dart';
import 'package:eduventure/screens/profile_screen.dart';
import 'package:eduventure/screens/result_screen.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/global_variables.dart';
import 'material_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var auth = FirebaseAuth.instance;
  bool _isLoading = false;

  var _userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadUserDetails();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadUserDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (userSnap.exists) {
        setState(() {
          _userData = userSnap.data()!;
        });
      } else {}
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          backgroundColor: Colors.blue.shade100,
          title: Text(
            "Eduventure",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(color:  colorPrimary,))
      : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              child: FadeAnimation(
                1.1,
                PhysicalModel(
                  color: Colors.white,
                  elevation: 8,
                  shadowColor: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          1.2,
                          Icon(
                            Icons.add_circle_outline,
                            size: 24,
                            color: Colors.grey[900],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeAnimation(
                                    1.3,
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfileScreen()));
                                      },
                                      child: Text(
                                        "Hello, ${_userData["name"]}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  FadeAnimation(
                                    1.4,
                                    Text(
                                      "Have a great day",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: FadeAnimation(
                                1.5,
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfileScreen()));
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        _userData["photoUrl"]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 18, bottom: 4),
              child: FadeAnimation(
                1.6,
                Text(
                  "Dashboard Section",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoticeScreen()));
                    },
                    child: FadeAnimation(
                      1.7,
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.all(32),
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.blue.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              1.8,
                              Icon(
                                (Icons.school_rounded),
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              1.9,
                              Text(
                                "Notice",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              2.0,
                              Text(
                                "All official notice are here",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FadeAnimation(
                              2.1,
                              Row(
                                children: [
                                  Text(
                                    "See all notice",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    size: 24,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassroomScreen()));
                    },
                    child: FadeAnimation(
                      1.7,
                      Container(
                        padding: EdgeInsets.all(32),
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.blue.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              1.8,
                              Icon(
                                (Icons.class_outlined),
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              1.9,
                              Text(
                                "Classroom",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              2.0,
                              Text(
                                "You can create or join class",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FadeAnimation(
                              2.1,
                              Row(
                                children: [
                                  Text(
                                    "See all classes",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    size: 24,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LibraryScreen()));
                    },
                    child: FadeAnimation(
                      1.7,
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(32),
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.blue.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              1.8,
                              Icon(
                                (Icons.library_add),
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              1.9,
                              Text(
                                "Library",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              2.0,
                              Text(
                                "Here all books are available for issue or reading",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FadeAnimation(
                              2.1,
                              Row(
                                children: [
                                  Text(
                                    "See all books",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    size: 24,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 18, bottom: 4),
              child: FadeAnimation(
                1.6,
                Text(
                  "Admin Section",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddStudentIdScreen()));
                    },
                    child: FadeAnimation(
                      1.7,
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.all(32),
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.blue.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              1.8,
                              Icon(
                                (Icons.add_circle_outlined),
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              1.9,
                              Text(
                                "Add Student Id",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              2.0,
                              Text(
                                "Add student id of newly admitted students",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FadeAnimation(
                              2.1,
                              Row(
                                children: [
                                  Text(
                                    "Add all student Id",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    size: 24,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 18, bottom: 4),
              child: FadeAnimation(
                1.6,
                Text(
                  "Result Section",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultScreen()));
                    },
                    child: FadeAnimation(
                      1.7,
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.all(32),
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.blue.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              1.8,
                              Icon(
                                (Icons.school_outlined),
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              1.9,
                              Text(
                                "Result",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              2.0,
                              Text(
                                "Here you can see all your results",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FadeAnimation(
                              2.1,
                              Row(
                                children: [
                                  Text(
                                    "See all Results",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    size: 24,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialsScreen()));
                    },
                    child: FadeAnimation(
                      1.7,
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.all(32),
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.blue.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              1.8,
                              Icon(
                                (Icons.my_library_books_outlined),
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              1.9,
                              Text(
                                "Materials",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FadeAnimation(
                              2.0,
                              Text(
                                "All materials are available here",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FadeAnimation(
                              2.1,
                              Row(
                                children: [
                                  Text(
                                    "See all Materials",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    size: 24,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  height: 52,
                  child: FadeAnimation(
                      1.7,
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            signOut();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder()),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Logout")))),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) => navigate());

  }

  void navigate() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()));
  }
}
