import 'package:crud_firestore/pages/login_page.dart';
import 'package:crud_firestore/provider/provider_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth_stream.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<GoogleLoginProvider>(
          create: (_) => GoogleLoginProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = "Firestore CRUD";
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.tealAccent,
      ),
      routes: {
        "/authstream": (context) => AuthStream(),
        "/loginpage": (context) => LoginPage(),
      },
      debugShowCheckedModeBanner: false,
      home: AuthStream(),
    );
  }
}
