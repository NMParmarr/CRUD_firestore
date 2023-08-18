import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/provider/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   GoogleSignIn()
  //       .signOut()
  //       .then((value) => Navigator.pushReplacementNamed(context, "/loginpage"));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final _users = FirebaseFirestore.instance.collection('users');
    String getUserId() {
      try {
        String _uid;
        final _auth = FirebaseAuth.instance;
        _uid = _auth.currentUser!.uid;
        return _uid;
      } catch (e) {
        print("GET USER ID ERROR : " + e.toString());
      }
      return "";
    }

    return FutureBuilder(
        future: _users.doc(getUserId()).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            String img = data['img'] ??
                'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png';

            return Scaffold(
              key: _scaffoldKey,
              // endDrawer: Drawer(),
              drawer: Drawer(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.tealAccent,
                          radius: 50,
                          child: ClipOval(
                              child: Image.network(
                            img,
                            fit: BoxFit.cover,
                          )),
                        ),
                        Text(data['name']),
                        Consumer<GoogleLoginProvider>(
                            builder: (context, provider, child) {
                          return ElevatedButton(
                              onPressed: () => provider.googleSignOut(context),
                              child: Text("Logout"));
                        })
                      ],
                    ),
                  ),
                ),
              ),
              appBar: AppBar(
                title: Text("Neon CRUD"),
              ),
              body: Center(
                  child: Column(
                children: [],
              )),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.teal,
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            );
          }
        });
  }
}
