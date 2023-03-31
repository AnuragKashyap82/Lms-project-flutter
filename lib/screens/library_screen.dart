import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/add_books_screen.dart';
import 'package:eduventure/screens/book_view_screen.dart';
import 'package:eduventure/screens/library_management_screen.dart';
import 'package:eduventure/screens/my_books_screen.dart';
import 'package:eduventure/utils/colors.dart';
import 'package:eduventure/widgets/books_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../utils/global_variables.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);


  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}


class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    int _count = 2;

    setState(() {
      if(size < 300){
        _count = 2;
      }else if(size > 300 && size < 400){
        _count = 2;
      }else if(size > 400 && size < 500){
        _count = 3;
      }else if(size > 500 && size < 600){
        _count = 3;
      }else if(size > 600 && size < 700){
        _count = 4;
      }else if(size > 700 && size < 800){
        _count = 5;
      }else if(size > 800 && size < 900){
        _count = 5;
      }else if(size > 900 && size < 1000){
        _count = 6;
      }else if(size > 1000 && size < 1100){
        _count = 6;
      }else if(size > 1100 && size < 1200){
        _count = 7;
      }else if(size > 1200 && size < 1300){
        _count = 7;
      }else if(size > 1300 && size < 1400){
        _count = 8;
      }else if(size > 1400 && size < 1500){
        _count = 8;
      }else if(size > 1500 && size < 1600){
        _count = 9;
      }
    });


    return Scaffold(
      appBar: AppBar(
        title: FadeAnimation(
            1.1,
            Text(
              "Library",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        actions: [
          FadeAnimation(
              1.2,
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyBooksScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.library_books,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("books").snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return
                GridView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _count, mainAxisExtent:  120),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: FadeAnimation(
                      1.3, GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookViewScreen(snap: snapshot.data!.docs[index].data())));
                      },
                        child: BooksCard(
                          snap: snapshot.data!.docs[index].data(),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),

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
            child: Icon(Icons.edit_outlined),
            backgroundColor: colorPrimary,
            foregroundColor: Colors.white,
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LibraryManagementScreen()));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add_outlined),
            backgroundColor: colorPrimary,
            foregroundColor: Colors.white,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBooksScreen()));
            },
          ),

          //add more menu item children here
        ],
      ),
    );
  }
}
