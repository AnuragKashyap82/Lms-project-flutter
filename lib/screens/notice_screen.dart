import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/add_notice_screen.dart';
import 'package:eduventure/screens/notice_view_screen.dart';
import 'package:eduventure/widgets/classroom_card.dart';
import 'package:eduventure/widgets/notice_card.dart';
import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: Text("Notice Section",style: TextStyle(fontSize: 16),),
      ),
      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Notice").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return   ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeViewScreen(
                            snap: snapshot.data!.docs[index].data()
                        )));
                      },
                      child: Container(
                        child: FadeAnimation(
                          1.1, NoticeCard(
                          snap: snapshot.data!.docs[index].data(),
                        ),
                        ),
                      ),
                    ));

          }
          ),



      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNoticeScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
