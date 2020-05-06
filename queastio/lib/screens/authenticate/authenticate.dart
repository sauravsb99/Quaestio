import 'package:flutter/material.dart';
import 'package:queastio/screens/authenticate/register.dart';
import 'package:queastio/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  bool showSignIn = true;
  void toggleView(){
    setState(()=> showSignIn = !showSignIn );
  }
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}