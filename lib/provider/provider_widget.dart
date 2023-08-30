 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  Future<void> googleLogin(context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      AuthCredential credential = await GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      addUser(userCredential, context);
    } catch (e) {
      print("GOOGLELOGIN ERROR : " + e.toString());
    }
  }

  Future<void> addUser(
      UserCredential userCredential, BuildContext context) async {
    try {
      final _firestore = await FirebaseFirestore.instance;
      final users = await _firestore.collection("users");
      final _uid = await _auth.currentUser!.uid;
      await users.doc(_uid).set({
        "name": userCredential.user!.displayName,
        "email": userCredential.user!.email,
        "img": userCredential.user!.photoURL,
        "mobile": userCredential.user!.phoneNumber,
        "uid": userCredential.user!.uid,
      }).whenComplete(
          () => Navigator.pushReplacementNamed(context, "/authstream"));
    } catch (e) {
      print("ADD USER ERROR : " + e.toString());
    }
  }

  Future<void> googleSignOut(context) async {
    try {
      final signOutReport = GoogleSignIn().signOut();
      signOutReport.whenComplete(
          () => Navigator.pushReplacementNamed(context, "/loginpage"));
    } catch (e) {
      print("SIGN OUT ERROR : " + e.toString());
    }
  }
}

class CRUD extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  static int sc = 0;

  Future<void> addData(fname, lname) async {
    DateTime date = DateTime.now();
    await _firestore.doc("$sc").set({
      "id": sc,
      "fname": fname,
      "lname": lname,
      "date": date,
    });
    sc++;
  }
}
