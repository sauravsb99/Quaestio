import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/shared/loading.dart';
import 'package:flutter/material.dart';

class AdminRegister extends StatefulWidget {

  final Function toggleView;
  AdminRegister({ this.toggleView });

  @override
  _AdminRegisterState createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
//      backgroundColor: Colors.indigo,
      appBar: AppBar(
//        backgroundColor: Colors.indigo,
        elevation: 10.0,
        title: Text('Register'),
      ),
      body: Wrap(
        children: <Widget>[
          Container(
            child: Padding(

              padding: EdgeInsets.fromLTRB(30,MediaQuery.of(context).size.height*0.2,30,0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child:SizedBox(width: 20,
//                      child:Text('hiyo',textScaleFactor: 5,style: TextStyle(fontFamily: 'Jost') ,textAlign: TextAlign.left,),
                    ),
                  ),
                  SizedBox(width: 5,),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,


            child: Container(
//            color: Colors.black,

              padding: EdgeInsets.fromLTRB(30,0,30,0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Form(
                  key: _formKey,
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.fromLTRB(38,28,38,8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[SizedBox(height: MediaQuery.of(context).size.height*0.2,
                      child:Image.asset("assets/logo_ok.png"),
                      ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(fillColor: Colors.transparent ,hintText: 'E-mail'),
                          validator: (val) => val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(fillColor: Colors.transparent ,hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 40.0),
                        RaisedButton(
                            color: Color(0xff43b77d),
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
//                                setState(() => loading = true);
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("You Are Being Logged in as the New Admin. You will be Logged out of our current account")));
                                dynamic result = await _auth.registeradminWithEmailAndPassword(email, password);
                                if(result == null) {
                                  setState(() {
//                                    loading = false;
                                    error = 'Please supply a valid email';
                                  });
                                }
                                else{
                                  setState(() {

//                                    loading = false;
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            }
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}