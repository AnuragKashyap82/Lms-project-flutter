import 'dart:async';

import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/home_page.dart';
import 'package:eduventure/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              FadeAnimation(
              1.1,Container(
                    width: 280,
                    height: 280,
                    child: Lottie.asset(
                      "assets/raw/splash.json",
                      frameRate: FrameRate.max,
                    ))),
            FadeAnimation(
              1.3,Text(
                  "Eduventure",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ))
              ],
            )),
      ),
    );
  }
}
