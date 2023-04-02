import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/forgot_password_screen.dart';
import 'package:eduventure/screens/register_screen.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VerifyUniqueIdScreen extends StatefulWidget {
  const VerifyUniqueIdScreen({Key? key}) : super(key: key);

  @override
  State<VerifyUniqueIdScreen> createState() => _VerifyUniqueIdScreenState();
}

class _VerifyUniqueIdScreenState extends State<VerifyUniqueIdScreen> {

  TextEditingController _uniqueId = TextEditingController();
  TextEditingController _phoneNo = TextEditingController();

  bool _isLoading = false;
  var _uniqueIdData  = {

  };


  void checkUniqueId() async {
    if(_uniqueId.text.isNotEmpty){
      setState(() {
        _isLoading = true;
      });
      try {
        var uniqueIdSnap = await FirebaseFirestore.instance
            .collection("UniqueId")
            .doc(_uniqueId.text)
            .get();
        if(uniqueIdSnap.exists){
          setState(() {
             _uniqueIdData = uniqueIdSnap.data()!;
            print(_uniqueIdData['phone']);
          });

        }else{

        }
        setState(() {});
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
      setState(() {
        _isLoading = false;
      });
    }else{

    }

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
                        child: Lottie.asset(
                          "assets/raw/login.json",
                          frameRate: FrameRate.max,
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
                                    onPressed: () {
                                      checkUniqueId();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder()),
                                    child: _isLoading ? CircularProgressIndicator(color: Colors.white,):
                                    Text("Verify".toUpperCase())
                                )
                            )
                        ),
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
                                Container(
                                  width: double.infinity,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26),
                                    border: Border.all(color: Colors.grey)
                                  ),
                                  child: Center(
                                    child: Text("${_uniqueIdData['phone']}",style: TextStyle(
                                      fontWeight: FontWeight.bold,), textAlign: TextAlign.center
                                      ,),
                                  ),
                                )
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => RegisterScreen()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: StadiumBorder()),
                                        child:
                                            Text("send otp".toUpperCase())))),
                          ],
                        ),
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
