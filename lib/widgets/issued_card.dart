import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/book_view_screen.dart';
import 'package:flutter/material.dart';

class IssuedCard extends StatefulWidget {
  final snap;
  const IssuedCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<IssuedCard> createState() => _IssuedCardState();
}

class _IssuedCardState extends State<IssuedCard> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12)),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: FadeAnimation(
                  1.4, Text(
                    widget.snap['subjectName'],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: FadeAnimation(
                  1.5, Text(
                    widget.snap['bookName'],
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: FadeAnimation(
                          1.6, Text(
                            "Book Id: ${widget.snap['bookId']}",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4),
                    child: FadeAnimation(
                      1.7, Text(
                        widget.snap['authorName'],
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4),
                    child: FadeAnimation(
                      1.7, Text(
                      "Issued Date: ${widget.snap['issueDate']}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                    ),
                  ),
                ],
              )
            ],
          ),
      ),
    );
  }
}
