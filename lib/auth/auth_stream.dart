import 'package:crud_firestore/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';

import '../pages/login_page.dart';

class AuthStream extends StatefulWidget {
  const AuthStream({super.key});

  @override
  State<AuthStream> createState() => _AuthStreamState();
}

class _AuthStreamState extends State<AuthStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Scaffold(
                backgroundColor: Colors.tealAccent,
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          }
          final user = snapshot.data;
          if (user != null) {
            debugPrint("------------USER IS LOGGED IN----------------");
            debugPrint(user.toString());
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            });
            return Container(
              color: Colors.purpleAccent,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            debugPrint("------------USER IS NOT LOGGED IN----------------");
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            });
            return Container(
              color: Colors.lightBlueAccent,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }));
  }
}
