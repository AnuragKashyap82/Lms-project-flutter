import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/resource/auth_methods.dart';
import 'package:eduventure/screens/forgot_password_screen.dart';
import 'package:eduventure/screens/home_page.dart';
import 'package:eduventure/screens/register_screen.dart';
import 'package:eduventure/screens/verify_email_screen.dart';
import 'package:eduventure/screens/verify_unique_id_screen.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString());
    if (res == "Success") {
      if(firebaseAuth.currentUser!.emailVerified){
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }else{
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Email id not Verifiefd!!", context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VerifyEmailScreen()));
      }

    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(res, context);
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                          Icons.emoji_emotions_sharp,
                          size: 160,
                          color: colorPrimary,
                        )),
                  ),
                  FadeAnimation(
                      1.1,
                      Text("Welcome Back",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ))),
                  FadeAnimation(
                      1.2, Text("Make it work, make it right, make it fast")),
                  Form(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                            1.3,
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                hintText: "anurag@kashyap.com",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        FadeAnimation(
                            1.4,
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              obscureText: _isPasswordVisible,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint),
                                  hintText: "Enter your Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(26)),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() =>
                                        _isPasswordVisible = !_isPasswordVisible
                                        );
                                      },
                                    icon: _isPasswordVisible
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                  )),
                            )),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: FadeAnimation(
                                    1.5,
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("Need Help?")))),
                            Align(
                                alignment: Alignment.centerRight,
                                child: FadeAnimation(
                                    1.6,
                                    TextButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              context: context,
                                              builder: (context) => Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Forgot Password",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                        Text(
                                                          "Select one of the options given below to reset your passeord",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 14),
                                                        ),
                                                        SizedBox(
                                                          height: 30.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () => {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ForgotPasswordScreen()))
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .grey
                                                                    .shade200),
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .mail_outline_rounded,
                                                                  size: 60,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Email",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    Text(
                                                                      "Rest via E-mail Verification",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .grey
                                                                    .shade200),
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .mobile_friendly_rounded,
                                                                  size: 60,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Phone No.",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    Text(
                                                                      "Rest via Phone Verification",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                        },
                                        child: Text("Forgot Password?")))),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: FadeAnimation(
                                1.7,
                                ElevatedButton(
                                    onPressed: () {
                                      loginUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder()),
                                    child: _isLoading ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)
                                        : Text("Login".toUpperCase())
                                )
                            )
                        ),
                      ],
                    ),
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeAnimation(1.8, Text("or")),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: FadeAnimation(
                            1.9,
                            OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(26)),
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
                          2.0,
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VerifyUniqueIdScreen()));
                              },
                              child: Text.rich(TextSpan(
                                  text: "Don't have an account?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  children: const [
                                    TextSpan(
                                        text: " Sign Up",
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
