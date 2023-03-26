import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<String> loginUser({
  required String email,
  required String password,
}) async {
  String res = "No user found";
  try {
    if (email.isNotEmpty &&
        password.isNotEmpty){
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "Success";
    }else{
      res = "Please enter all the fields";
    }

  } on FirebaseAuthException catch (e) {
    if (e.code == "invalid-email") {
      res = "The email is badly formatted";
    } else if (e.code == "wrong-password") {
      res = "The password is Incorrect";
    }else if (e.code == "weak-password") {
      res = "The password is weak 6 characters must";
    }
  }
  catch (err) {
    res = err.toString();
  }
  return res;
}

Future<String> signUpUser({
  required String email,
  required String password,
  required String cPassword,
  required String name,
}) async {
  String res = "Some Error Occured";
  try {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        cPassword == password) {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection("users").add({
        "name": name,
        "uid": cred.user!.uid,
        "email": email,
      });

      res = "Success";
    }
  } on FirebaseAuthException catch (err) {
    if (err.code == "invalid-email") {
      res = "The email is badly formatted";
    } else if (err.code == "weak-password") {
      res = "The password is weak 6 characters must";
    }
  } catch (err) {
    res = err.toString();
    print(err.toString());
  }
  return res;
}

}