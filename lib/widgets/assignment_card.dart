import 'package:eduventure/utils/colors.dart';
import 'package:flutter/material.dart';

class AssignmentCard extends StatefulWidget {
  final snap;
  const AssignmentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<AssignmentCard> createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(

        ),
        child: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Icon(Icons.assignment, color: colorPrimary,),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.snap['assignmentName'], style: TextStyle(color: colorPrimary, fontSize: 16),),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Teacher Name to be integrated", style: TextStyle(color: Colors.grey, fontSize: 14),),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.snap['dueDate'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                SizedBox(
                  height: 4,
                ),
                Text(widget.snap['dateTime'], style: TextStyle(color: Colors.grey, fontSize: 14),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
