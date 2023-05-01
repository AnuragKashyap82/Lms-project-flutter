import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/screens/edit_profile_screen.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../utils/global_variables.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  var _userData = {

  };

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52.0),
        child: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade100,
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: colorPrimary,
            ))
          : Align(
              alignment: Alignment.topCenter,
              child:
              Container(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.1,
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(_userData["photoUrl"]),
                          ),
                        ),
                        FadeAnimation(
                            1.2,
                            Text(_userData["name"],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ))),
                        FadeAnimation(1.3, Text(_userData["email"])),
                        FadeAnimation(1.4, Text(_userData["studentId"])),
                        FadeAnimation(1.5, Text(_userData["phoneNo"])),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FadeAnimation(
                              1.6,
                              Column(
                                children: [
                                  Text(
                                    "Country",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "India",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                            FadeAnimation(
                              1.7,
                              Column(
                                children: [
                                  Text(
                                    "State",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Jharkhand",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                            FadeAnimation(
                              1.8,
                              Column(
                                children: [
                                  Text(
                                    "City",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Giridih",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          1.9,
                          Container(
                            height: 0.4,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        FadeAnimation(
                          1.9,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  _userData["completeAddress"],
                                  maxLines: 1,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        FadeAnimation(
                          1.9,
                          Container(
                            height: 0.4,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        FadeAnimation(
                          2.0,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "Registration No: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text(_userData["regNo"]),
                              ],
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2.1,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "DOB: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text(_userData["dob"]),
                              ],
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2.2,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "Branch:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text(_userData["branch"]),
                              ],
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2.3,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "Semester: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text(_userData["semester"]),
                              ],
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2.4,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "Session: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text(_userData["session"]),
                              ],
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2.5,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      "Seat Type: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text(_userData["seatType"]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

      floatingActionButton: FadeAnimation(
        2.6,
        FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()));
          },
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}
