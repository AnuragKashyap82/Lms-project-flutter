import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/resource/auth_methods.dart';
import 'package:eduventure/screens/home_page.dart';
import 'package:eduventure/screens/login_screen.dart';
import 'package:eduventure/screens/verify_email_screen.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  final String phoneNo;
  final String uniqueId;
  const RegisterScreen({Key? key, required this.phoneNo, required this.uniqueId}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();



  bool _isPasswordVisible = true;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cPasswordController.dispose();
  }
  void sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user!= null && !user.emailVerified) {
      await user.sendEmailVerification();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerifyEmailScreen()));
    }

  }

  void registerAlreadyUniqueId() async {
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String tDate = DateFormat("HH:mm").format(DateTime.now());
    try {
      Map<String,dynamic> data = {
        "name" : _nameController.text,
        "email" : _emailController.text,
        "uniqueId" : widget.uniqueId,
        "dateTime" : "$date  $tDate",
        'uid' : FirebaseAuth.instance.currentUser?.uid, // Updating Document Reference
      };
      DocumentReference reference =  FirebaseFirestore.instance.collection("alreadyRegUniqueId").
      doc(widget.uniqueId);
      await reference.set(data).whenComplete((){
        sendVerificationEmail();
        
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

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        phoneNo: widget.phoneNo,
        studentId: widget.uniqueId,
        name: _nameController.text,
        cPassword: _cPasswordController.text).then((value) {
      if (value != 'Success') {
        showSnackBar(value, context);
      } else {
        registerAlreadyUniqueId();
      }
    });


  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                      1.1,
                      Container(
                          width: 180,
                          height: 180,
                          child: Icon(
                            Icons.emoji_emotions_sharp,
                            size: 160,
                            color: colorPrimary,
                          ))),
                  FadeAnimation(
                      1.2,
                      Text("Welcome",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ))),
                  FadeAnimation(
                      1.3, Text("Make it work, make it right, make it fast")),
                  Form(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                            1.4,
                            TextFormField(
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              controller: _nameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                hintText: "Enter your Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26)),
                              ),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FadeAnimation(
                            1.5,
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                hintText: "Enter your Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26)),
                              ),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FadeAnimation(
                            1.6,
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              obscureText: _isPasswordVisible,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint),
                                  hintText: "Enter your password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(26)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() => _isPasswordVisible =
                                          !_isPasswordVisible);
                                    },
                                    icon: _isPasswordVisible
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                  )),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FadeAnimation(
                            1.7,
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              obscureText: _isPasswordVisible,
                              controller: _cPasswordController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint),
                                  hintText: "Confirm your Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(26)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() => _isPasswordVisible =
                                          !_isPasswordVisible);
                                    },
                                    icon: _isPasswordVisible
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                  )),
                            )),
                        const SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: FadeAnimation(
                                1.8,
                                ElevatedButton(
                                    onPressed: () async {
                                      signUpUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder()),
                                    child: _isLoading ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)
                                        : Text("Sign Up".toUpperCase())
                                ))),
                      ],
                    ),
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeAnimation(1.9, Text("or")),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: FadeAnimation(
                            2.0,
                            OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(),
                                    foregroundColor: Colors.black,
                                    side: BorderSide(color: Colors.black),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15)),
                                icon: Image(
                                  image: AssetImage("assets/images/google.png"),
                                  width: 24,
                                ),
                                onPressed: () {},
                                label: Text("SignIn with Google")),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          2.1,
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text.rich(TextSpan(
                                  text: "Already have an account?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  children: const [
                                    TextSpan(
                                        text: " Sign In",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600))
                                  ])))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
