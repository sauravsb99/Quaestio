import 'package:flutter/material.dart';
import 'package:queastio/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();
  @override

  Widget build(BuildContext context) {

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

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async{
          dynamic result = await _auth.signInAnon();
          if(result == null){
            print('Eroor signing in');
          }else{
            print('Welcome ');
            print(result.uid);
          }
         },
          child: Text("Login",textAlign: TextAlign.center,style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold))
        )
    );

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Quaestion'),
      ),

      body: Container(padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
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
          SizedBox(
              height: 15.0),
          loginButton,

        ],
      ),
      ),

    );
  }

//  loginButton({Text child, Future<Null> Function() onPressed}) {}
}