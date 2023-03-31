import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '../utils/colors.dart';

class NoticeViewScreen extends StatefulWidget {
  final snap;
  const NoticeViewScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<NoticeViewScreen> createState() => _NoticeViewScreenState();
}

class _NoticeViewScreenState extends State<NoticeViewScreen> {

  late PdfController pdfController;
  loadController(){
    pdfController = PdfController(document: PdfDocument.openData(InternetFile.get(widget.snap['noticeUrl'])));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.snap['noticeTitle']}\n${widget.snap['noticeNo']}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),

      body:Center(
        child: PdfView(controller: pdfController,),
      ),



      floatingActionButton: SpeedDial(
        direction: SpeedDialDirection.up,
        icon: Icons.add,
        //icon on Floating action button
        activeIcon: Icons.close,
        //icon when menu is expanded on button
        backgroundColor: colorPrimary,
        //background color of button
        foregroundColor: Colors.white,
        //font color, icon color in button
        activeBackgroundColor: colorPrimary,
        //background color when menu is expanded
        activeForegroundColor: Colors.white,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.1,
        elevation: 12.0,
        //shadow elevation of button
        shape: CircleBorder(),
        //shape of button

        children: [
          SpeedDialChild(
            //speed dial child
            child: Icon(Icons.edit_outlined),
            backgroundColor: colorPrimary,
            foregroundColor: Colors.white,
            onTap: (){

            },
          ),
          SpeedDialChild(
            //speed dial child
            child: Icon(Icons.delete_outline),
            backgroundColor: colorPrimary,
            foregroundColor: Colors.white,
            onTap: (){

            },
          ),
          SpeedDialChild(
            child: Icon(Icons.download_outlined),
            backgroundColor: colorPrimary,
            foregroundColor: Colors.white,
            onTap: () {

            },
          ),

          //add more menu item children here
        ],
      ),
    );
  }
}
