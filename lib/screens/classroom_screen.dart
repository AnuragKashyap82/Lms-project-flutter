import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/classroom_view_screen.dart';
import 'package:eduventure/screens/create_class_screen.dart';
import 'package:eduventure/screens/join_class_screen.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:eduventure/widgets/classroom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key? key}) : super(key: key);

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    int _count = 2;

    setState(() {
      if(size < 400){
        _count = 1;
      }else if(size > 400 && size < 500){
        _count = 1;
      }else if(size > 500 && size < 600){
        _count = 1;
      }else if(size > 600 && size < 800){
        _count = 2;
      }else if(size > 800 && size < 1000){
        _count = 3;
      }else if(size > 1000 && size < 1200){
        _count = 3;
      }else if(size > 1200 && size < 1400){
        _count = 4;
      }else if(size > 1400 && size < 1600){
        _count = 4;
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Classroom", style: TextStyle(fontSize: 16),),
      ),
      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").
            doc(FirebaseAuth.instance.currentUser?.uid).collection("classroom")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 2,),
              );
            }
            return
              GridView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _count, mainAxisExtent:  186),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                        ClassroomViewScreen(
                            snap: snapshot.data!.docs[index].data()
                        )));
                  },
                    child: Container(
                      child: FadeAnimation(
                        1.1, ClassroomCard(
                          snap: snapshot.data!.docs[index].data(),
                        ),
                      ),
                    ),
                  );
                },
              );
          }),

      floatingActionButton: SpeedDial(
        direction: SpeedDialDirection.up,
        icon: Icons.add,
        //icon on Floating action button
        activeIcon: Icons.close,
        //icon when menu is expanded on button
        backgroundColor: colorPrimary,
        //background color of button
        foregroundColor: Colors.white,
        //font color, icon color in button
        activeBackgroundColor: colorPrimary,
        //background color when menu is expanded
        activeForegroundColor: Colors.white,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.1,
        elevation: 12.0,
        //shadow elevation of button
        shape: CircleBorder(),
        //shape of button

        children: [
          SpeedDialChild(
            //speed dial child
            child: Icon(Icons.add),
            backgroundColor: colorPrimary,
            foregroundColor: Colors.white,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateClassScreen()));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.class_outlined),
            backgroundColor: colorPrimary,
            foregroundColor: Colors.white,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> JoinClassScreen()));
            },
          ),

          //add more menu item children here
        ],
      ),

    );
  }
}
