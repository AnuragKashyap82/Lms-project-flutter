import 'package:eduventure/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eduventure',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: "SegSemiBold",
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: Text("Anurag Kashyap", style: TextStyle(fontSize: 26, color: Colors.black, fontFamily: 'SegSemiBold'),)),
        ),
      ),
    );
  }
}
