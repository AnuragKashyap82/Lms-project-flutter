import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/global_variables.dart';
import 'home_page.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _isLoadingDetails = false;
  var _userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadUserDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadUserDetails() async {
    setState(() {
      _isLoadingDetails = true;
    });
    try {
      var sellerSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (sellerSnap.exists) {
        setState(() {
          _isLoadingDetails = false;
        });
        setState(() {
          _userData = sellerSnap.data()!;
        });
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          setState(() {
            _isLoadingDetails = false;
          });
        }
      } else {}
    } catch (e) {
     showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: _isLoadingDetails
            ? Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 1,
            ))
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const  Text(
                  "Email is not verified!!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const  Text(
                  "Verification Email has been sent to your registered Email, verify from there then you can be logged in",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: Colors.black54,
                  ),
                ),
                const   SizedBox(
                  height: 12,
                ),
                Text(
                  "Email: ${_userData['email']}",
                  style:const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
