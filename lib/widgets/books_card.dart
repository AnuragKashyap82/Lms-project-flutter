import 'package:eduventure/animations/fade_animation.dart';
import 'package:flutter/material.dart';

class BooksCard extends StatefulWidget {
  final snap;
  const BooksCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<BooksCard> createState() => _BooksCardState();
}

class _BooksCardState extends State<BooksCard> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.snap['subjectName'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.snap['bookName'],
                style: TextStyle(fontSize: 12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                      child: Text(
                        "Book Id: ${widget.snap['bookId']}",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,
                  )),
                  Text(
                    widget.snap['authorName'],
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,
                  ),
                ],
              )
            ],
          ),
      ),
    );
  }
}
