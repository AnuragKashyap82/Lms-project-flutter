import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/forgot_password_screen.dart';
import 'package:eduventure/screens/register_screen.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class VerifyUniqueIdScreen extends StatefulWidget {
  const VerifyUniqueIdScreen({Key? key}) : super(key: key);

  @override
  State<VerifyUniqueIdScreen> createState() => _VerifyUniqueIdScreenState();
}

class _VerifyUniqueIdScreenState extends State<VerifyUniqueIdScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _uniqueId = TextEditingController();
  TextEditingController countryController = TextEditingController();

  bool _isLoading = false;

  bool _isCodeSent = false;
  bool _isOtpVerified = false;
  String btnText = "Send Otp";
  String verify = "";
  var phone = "";
  var code = "";

  var _uniqueIdData = {};

  void checkUniqueId() async {
        try {
          var uniqueIdSnap = await FirebaseFirestore.instance
              .collection("UniqueId")
              .doc(_uniqueId.text)
              .get();
          if (uniqueIdSnap.exists) {
            setState(() {
              _isLoading = false;
              _uniqueIdData = uniqueIdSnap.data()!;
              phone = _uniqueIdData['phone'];
            });
          } else {
            setState(() {
              _isLoading = false;
            });
            showSnackBar("No Student id Found", context);
          }
          setState(() {});
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(e.toString(), context);
        }
  }

  void checkAlreadyRegUniqueId() async {
    if(_uniqueId.text.isNotEmpty){
      setState(() {
        _isLoading = true;
      });
      try {
        var uniqueIdSnap = await FirebaseFirestore.instance
            .collection("alreadyRegUniqueId")
            .doc(_uniqueId.text)
            .get();
        if (uniqueIdSnap.exists) {
          setState(() {
            _isLoading = false;
          });
          showSnackBar("StudentId Already Registered!!!", context);

        } else {
          checkUniqueId();
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(e.toString(), context);
      }
    }else{
      setState(() {
        _isLoading = false;
      });
      showSnackBar("Enter UniqueId", context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
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
                    1.0,
                    Container(
                        width: 180,
                        height: 180,
                        child: Icon(
                          Icons.verified_user_outlined,
                          size: 160,
                          color: colorPrimary,
                        )),
                  ),
                  FadeAnimation(
                      1.1,
                      Text("Verify your student id",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ))),
                  FadeAnimation(
                      1.2,
                      Text(
                        "First verify your student id to register in Eduventure",
                        textAlign: TextAlign.center,
                      )),
                  Form(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          1.3,
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _uniqueId,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_clock),
                              hintText: "Enter your Student Id",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: FadeAnimation(
                                1.4,
                                ElevatedButton(
                                    onPressed: () {
                                      checkAlreadyRegUniqueId();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder()),
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          )
                                        : Text("Verify".toUpperCase())))),
                      ],
                    ),
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                          child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeAnimation(
                                1.3,
                                _isCodeSent
                                    ? TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          code = value;
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.phone_in_talk),
                                          hintText: "Enter your Otp",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(26)),
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 52,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(26),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Center(
                                          child: Text(
                                            "${_uniqueIdData['phone']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                                width: double.infinity,
                                height: 46,
                                child: FadeAnimation(
                                    1.4,
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (phone.length != 10) {
                                            showSnackBar(
                                                "Phone No. should contain 10 digits!!!",
                                                context);
                                          } else {
                                            if (!_isCodeSent) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              try {
                                                await FirebaseAuth.instance
                                                    .verifyPhoneNumber(
                                                  phoneNumber:
                                                      '${countryController.text + phone}',
                                                  verificationCompleted:
                                                      (PhoneAuthCredential
                                                          credential) {},
                                                  verificationFailed:
                                                      (FirebaseAuthException
                                                          e) {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                  },
                                                  codeSent: (String
                                                          verificationId,
                                                      int? resendToken) async {
                                                    setState(() {
                                                      _isLoading = false;
                                                      _isCodeSent = true;
                                                      verify = verificationId;
                                                      btnText = "Verify Otp";
                                                    });
                                                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyVerify()));
                                                  },
                                                  codeAutoRetrievalTimeout:
                                                      (String
                                                          verificationId) {},
                                                );
                                              } catch (e) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                showSnackBar(
                                                    "Otp send failed!!!",
                                                    context);
                                              }
                                            } else if (_isCodeSent) {
                                              try {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                PhoneAuthCredential credential =
                                                    PhoneAuthProvider
                                                        .credential(
                                                            verificationId:
                                                                verify,
                                                            smsCode: code);

                                                // Sign the user in (or link) with the credential
                                                await auth
                                                    .signInWithCredential(
                                                        credential)
                                                    .then((value) {
                                                  setState(() {
                                                    _isOtpVerified = true;
                                                    _isLoading = false;
                                                    auth.signOut();
                                                    showSnackBar(
                                                        "Otp Verified!!",
                                                        context);

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                RegisterScreen(
                                                                  phoneNo:
                                                                      _uniqueIdData[
                                                                          'phone'],
                                                                  uniqueId:
                                                                      _uniqueIdData[
                                                                          'studentId'],
                                                                )));
                                                  });
                                                });
                                              } catch (e) {
                                                showSnackBar(
                                                    "Wrong Otp", context);
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                              }
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: StadiumBorder()),
                                        child: Text(btnText)))),
                          ],
                        ),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          2.0,
                          TextButton(
                              onPressed: () {},
                              child: Text.rich(TextSpan(
                                  text:
                                      "In case you face any difficulty in verifying your student id. kindly contact us",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  children: const [
                                    TextSpan(
                                        text: " Need Help",
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
