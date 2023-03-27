import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/create_class_screen.dart';
import 'package:eduventure/screens/join_class_screen.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:eduventure/widgets/classroom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ClassroomScreen extends StatelessWidget {
  const ClassroomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Classroom"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").
            doc(FirebaseAuth.instance.currentUser?.uid).collection("classroom")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width > webScreenSize ? width * 0.3 : 0,
                      vertical: width > webScreenSize ? 15 : 0
                  ),
                  child: FadeAnimation(
                    1.1, ClassroomCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  ),
                ));
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
