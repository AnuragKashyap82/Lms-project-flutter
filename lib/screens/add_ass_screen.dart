import 'package:eduventure/animations/fade_animation.dart';
import 'package:flutter/material.dart';

class AddAssignmentScreen extends StatelessWidget {
  final snap;
  const AddAssignmentScreen({
    Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeAnimation(1.1, Text("Add Assignment")),
      ),
    );
  }
}
