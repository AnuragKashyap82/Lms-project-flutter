import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/login_screen.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
      SafeArea(
        child: Scaffold(
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
                  1.1,Container(
                        width: 180,
                        height: 180,
                        child: Lottie.asset(
                          "assets/raw/login.json",
                          frameRate: FrameRate.max,
                        ))),
                FadeAnimation(
                  1.2,Text("Welcome",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ))),
                FadeAnimation(
                  1.3,Text("Make it work, make it right, make it fast")),
                    Form(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            FadeAnimation(
                            1.4,TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person_outline_outlined),
                                  hintText: "Enter your Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(26)
                                  ),
                                ),
                              )),
                              const SizedBox(
                                height: 10.0,
                              ),
                          FadeAnimation(
                            1.5,TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  hintText: "Enter your Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(26)
                                  ),),

                              )),
                              const SizedBox(
                                height: 10.0,
                              ),
                          FadeAnimation(
                            1.6,TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_outlined),
                                  hintText: "Enter your Phone No",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(26)
                                  ),),
                              )),
                              const SizedBox(
                                height: 10.0,
                              ),
                          FadeAnimation(
                            1.7,TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.fingerprint),
                                    hintText: "Enter your Password",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(26)
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.remove_red_eye))
                                ),
                              )),
                              const SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  height: 46,
                                  child: FadeAnimation(
                                      1.8,ElevatedButton(
                                      onPressed: () async {

                                      },
                                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                                      child: Text("Sign Up".toUpperCase())))),
                            ],
                          ),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         FadeAnimation(
                          1.9,Text("or")),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FadeAnimation(
                            2.0,OutlinedButton.icon(
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
                              label: Text("SignIn with Google")),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          2.1,TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text.rich(
                                TextSpan(
                                    text: "Already have an account?",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    children: const [
                                      TextSpan(
                                          text: " Sign In",
                                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)
                                      )
                                    ]
                                )
                            ))),
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
