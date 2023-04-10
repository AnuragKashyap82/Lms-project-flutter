
import 'package:eduventure/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC0BPF82RrpIqW3ZLzVPbA_Ym64wQemfCU',
          appId: '1:855282251591:web:def5a50475b981e2ec3e62',
          messagingSenderId: '855282251591',
          projectId: 'eduventure-flutter',
          storageBucket: 'eduventure-flutter.appspot.com')
    );
  }else{
    await Firebase.initializeApp();
  }
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