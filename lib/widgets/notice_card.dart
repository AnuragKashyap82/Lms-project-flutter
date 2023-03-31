import 'package:eduventure/animations/fade_animation.dart';
import 'package:flutter/material.dart';

import '../screens/notice_view_screen.dart';

class NoticeCard extends StatefulWidget {
  final snap;

  const NoticeCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.all(4),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Icon(
                Icons.school_rounded,
                size: 36, color: Colors.blueGrey.shade400,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snap['noticeTitle'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.snap['noticeNo'],
                      style: TextStyle(
                          fontWeight: FontWeight.w100, fontSize: 12),
                    ),
                  ]),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.snap['dateTime'],
                      style:
                          TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
