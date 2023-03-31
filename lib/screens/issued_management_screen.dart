import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/user_all_issued_book_screen.dart';
import 'package:eduventure/widgets/user_applied_card.dart';
import 'package:flutter/material.dart';

class IssuedManagementScreen extends StatefulWidget {
  const IssuedManagementScreen({Key? key}) : super(key: key);

  @override
  State<IssuedManagementScreen> createState() => _IssuedManagementScreenState();
}

class _IssuedManagementScreenState extends State<IssuedManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("issuedBooks").snapshots(),
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
                    crossAxisCount: 1, mainAxisExtent:  65),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: FadeAnimation(
                      1.3, GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserAllIssuedBooksScreen(
                            snap: snapshot.data!.docs[index].data()
                        )));
                      },
                      child: UserAppliedCard(
                        snap: snapshot.data!.docs[index].data(),
                      ),
                    ),
                    ),
                  );
                },
              );
          }),
    );
  }
}
