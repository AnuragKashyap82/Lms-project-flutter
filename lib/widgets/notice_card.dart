import 'package:eduventure/animations/fade_animation.dart';
import 'package:flutter/material.dart';

class NoticeCard extends StatefulWidget {
  const NoticeCard({Key? key}) : super(key: key);

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  @override
  Widget build(BuildContext context) {
    return
      FadeAnimation(
        1.2, Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(25),
        ),
        child: FadeAnimation(
          1.3, ListTile(
            leading: FadeAnimation(1.4, Icon(Icons.school_rounded)),
            title: FadeAnimation(
              1.5, Text('Notice Title', style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700
              ),),
            ),
            subtitle: FadeAnimation(
              1.6, Text(
                "Notice Subtitles",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            trailing: FadeAnimation(
              1.7, Text("26/03/23", style: TextStyle(
                color: Colors.grey, fontSize: 14
              ),),
            ),
            onTap: () {},
          ),
        ),
    ),
      );
  }
}
