import 'package:eduventure/screens/applied_book_screen.dart';
import 'package:eduventure/screens/applied_management_screen.dart';
import 'package:eduventure/screens/issued_management_screen.dart';
import 'package:eduventure/screens/user_all_applied_books.dart';
import 'package:flutter/material.dart';

class LibraryManagementScreen extends StatelessWidget {
  const LibraryManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: DefaultTabController(
          length: 2,

          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(

                tabs: [
                  Tab(text: "Applied"),
                  Tab(text: "Issued"),
                ],
              ),
              title: const Text('Library Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            body: const  TabBarView(
              children: [
                AppliedManagementScreen(),
                IssuedManagementScreen(),
              ],
            ),
          ),
        ),

      );
  }
}
