import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queastio/services/auth.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  AuthService _auth = AuthService();
  final emailField = TextField(
    obscureText: false,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(11.0))),
  );

  final passwordField = TextField(
    obscureText: true,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(11.0))),
  ); //password

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//          SizedBox(
//            height: 155.0,
//            child: Image.asset(
//              "assets/logo.png",
//              fit: BoxFit.contain,
//            ),
//          ),
          SizedBox(height: 45.0),
            emailField,
          SizedBox(height: 25.0),
            passwordField,
//          SizedBox(
//            height: 35.0,
//          ),
//
//        loginButon,


    ],
    ),
    );
  }
}

