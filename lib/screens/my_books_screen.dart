import 'package:eduventure/screens/applied_book_screen.dart';
import 'package:eduventure/screens/issued_book_screen.dart';
import 'package:eduventure/screens/returened_book_screen.dart';
import 'package:flutter/material.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Applied"),
                Tab(text: "Issued"),
                Tab(text: "Returned"),
              ],
            ),
            title: const Text('My Books', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          ),
          body: const TabBarView(
            children: [
              AppliedBookScreen(),
              IssuedBookScreen(),
              ReturnedBookScreen(),
            ],
          ),
        ),
      ),

    );
  }
}
