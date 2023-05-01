import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FireStoreMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future createTodayAttendance({
    required String year,
    required String month,
    required String date,
    required String classCode,
  }) async {

    await firebaseFirestore.collection("classroom").doc(classCode)
    .collection("Attendance").doc("$date-$month-$year")
        .set({
      "active": true,
      "date": "$date-$month-$year",
      "month": "$month",
      "year": "$year",
    });
  }

  Future increaseClassCount({
    required String year,
    required String month,
    required String classCode,
    required int classCount,
  }) async {

    await firebaseFirestore.collection("classroom").doc(classCode)
        .collection("ClassCount").doc("$month-$year")
        .set({
      "month": "$month",
      "year": "$year",
      "classCount": "$classCount",
    });
  }

  Future markAttendancePresent({
    required String classCode,
    required String uid,
  }) async {

    String year = DateTime.now().year.toString();
    String month = DateFormat('MMMM').format(DateTime.now());
    String date = DateFormat('d').format(DateTime.now());

    await firebaseFirestore.collection("classroom").doc(classCode)
        .collection("Attendance").doc("$date-$month-$year").collection("Students").doc(uid)
        .set({
      "date": "$date-$month-$year",
      "month": "$month",
      "year": "$year",
      "attendance": "present",
      "uid": "$uid",
    });
  }

  Future markAttendanceAbsent({
    required String classCode,
    required String uid,
  }) async {

    String year = DateTime.now().year.toString();
    String month = DateFormat('MMMM').format(DateTime.now());
    String date = DateFormat('d').format(DateTime.now());

    await firebaseFirestore.collection("classroom").doc(classCode)
        .collection("Attendance").doc("$date-$month-$year").collection("Students").doc(uid)
        .set({
      "date": "$date-$month-$year",
      "month": "$month",
      "year": "$year",
      "attendance": "absent",
      "uid": "$uid",
    });
  }

}
