import 'package:queastio/services/auth.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override

  Widget build(BuildContext context) {

    final emailField = TextFormField(
      validator: (val) => val.isEmpty ? 'Enter an email' : null,
      onChanged: (val) {
        setState(() => email = val);
      },
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(11.0))),
    );

    final passwordField =  TextFormField(
      obscureText: true,
      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
      onChanged: (val) {
        setState(() => password = val);
      },
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
            child:Text("Sign in"),
            onPressed: () async {
              if(_formKey.currentState.validate()){
                dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                if(result == null) {
                  setState(() {
                    error = 'Could not sign in with those credentials';
                  });
                }
              }
            }
        )
    );

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              emailField,
              SizedBox(height: 20.0),
              passwordField,
              SizedBox(height: 20.0),
              loginButton,
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),

//      body: Container(padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
////          SizedBox(
////            height: 155.0,
////            child: Image.asset(
////              "assets/logo.png",
////              fit: BoxFit.contain,
////            ),
////          ),
//          SizedBox(height: 45.0),
//          emailField,
//          SizedBox(height: 25.0),
//          passwordField,
////          SizedBox(
////            height: 35.0,
////          ),
////
////        loginButon,
//          SizedBox(
//              height: 15.0),
//          loginButton,
//
//        ],
//      ),

      ),
    );
  }

//  loginButton({Text child, Future<Null> Function() onPressed}) {}
}