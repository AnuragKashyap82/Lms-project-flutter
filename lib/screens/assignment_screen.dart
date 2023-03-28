import 'package:eduventure/animations/fade_animation.dart';
import 'package:eduventure/screens/add_ass_screen.dart';
import 'package:flutter/material.dart';

class AssignmentScreen extends StatefulWidget {
  final snap;
  const AssignmentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeAnimation(1.1, Text("Assignment Section")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAssignmentScreen(snap: widget.snap)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
