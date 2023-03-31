
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/user_all_applied_books.dart';
import 'package:eduventure/utils/global_variables.dart';
import 'package:flutter/material.dart';

class UserAppliedCard extends StatefulWidget {
  final snap;
  const UserAppliedCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<UserAppliedCard> createState() => _UserAppliedCardState();
}

class _UserAppliedCardState extends State<UserAppliedCard> {
  var userData = {};
  var isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {
      isLoading = true;
    });
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.snap['uid'])
          .get();

      userData = userSnap.data()!;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return
    isLoading? Center(child: CircularProgressIndicator()):
      FadeAnimation(
        1.2, Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(0),
        ),
        child: FadeAnimation(
          1.3, ListTile(
          leading: FadeAnimation(1.4, CircleAvatar( radius: 26, backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1679687189714-6a0e57adc199?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'))),
          title: FadeAnimation(
            1.5, Text(userData['name'], style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700
          ),),
          ),
          subtitle: FadeAnimation(
            1.6, Text(
            userData['email'],
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          ),
        ),
        ),
      ),
      );
  }
}
