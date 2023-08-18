import 'package:crud_firestore/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 450,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://rurutek.com/jio/assets/img/login-animate.gif")),
            ),
          ),
          Text(
            "CRUD User Login",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(17, 17, 10, 40),
            child: Consumer<GoogleLoginProvider>(
              builder: (context,provider,child) {
                return Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: TextButton.icon(
                      onPressed: () => provider.googleLogin(context),
                      icon: Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Login with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
