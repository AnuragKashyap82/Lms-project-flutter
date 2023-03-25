import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/login_screen.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
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
                ?  EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
                : const EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(

              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  FadeAnimation(
                  1.0,Container(
                        width: 180,
                        height: 180,
                        child: Lottie.asset(
                          "assets/raw/forgot.json",
                          frameRate: FrameRate.max,
                        ))),
                FadeAnimation(
                  1.1,Text("Welcome",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ))),
                FadeAnimation(
                  1.2,Text("Reset your password using your registered email")),
                    Form(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            FadeAnimation(
                            1.3,TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  hintText: "Enter your Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(26)
                                  ),
                                ),
                              )),
                              const SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  height: 46,
                                  child: FadeAnimation(
                                      1.4,ElevatedButton(
                                      onPressed: () async {

                                      },
                                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                                      child: Text("Send password link".toUpperCase())))),
                            ],
                          ),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         FadeAnimation(
                          1.5,Text("or")),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FadeAnimation(
                            1.6,OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(),
                                  foregroundColor: Colors.black,
                                  side: BorderSide(color: Colors.black),
                                  padding: EdgeInsets.symmetric(vertical: 15)),
                              icon: Image(
                                image: AssetImage("assets/images/google.png"),
                                width: 24,
                              ),
                              onPressed: () {},
                              label: Text("SignIn with Google"))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          1.7,TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text("back to login", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),)
                        )),
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
