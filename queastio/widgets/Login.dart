import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//fast access of widgets



final emailField = TextField(
  decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "Email",
      border:
      OutlineInputBorder(borderRadius: BorderRadius.circular(11.0))),
);

final PasswordField = TextField(
  obscureText: true,
  decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "Password",
      border:
      OutlineInputBorder(borderRadius: BorderRadius.circular(11.0))),
);

final loginButon = Material(
  elevation: 5.0,
  borderRadius: BorderRadius.circular(30.0),
  color: Color(0xff01A0C7),
  child: MaterialButton(
    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    onPressed: () {},
    child: Text("Login",textAlign: TextAlign.center,style: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold)),
  ),
);
