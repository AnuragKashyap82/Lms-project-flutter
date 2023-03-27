import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/add_notice_screen.dart';
import 'package:eduventure/widgets/notice_card.dart';
import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notice Section"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FadeAnimation(1.1, NoticeCard()),
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
