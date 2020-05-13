import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/shared/loading.dart';
import 'package:flutter/material.dart';

class NewAdmin extends StatefulWidget {

  final Function toggleView;
  NewAdmin({ this.toggleView });

  @override
  _NewAdminState createState() => _NewAdminState();
}

class _NewAdminState extends State<NewAdmin> {

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
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
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
                  Material(
                    color: Colors.indigo,
                    child: Align(

                      alignment: Alignment.bottomRight,
                      //<Widget>[
                      child: Material(
                        color: Colors.indigo,
                        child:FlatButton.icon(color: Colors.black,
                          icon: Icon(Icons.person,color: Colors.white,),
                          label: Text('Register',style: TextStyle( color: Colors.white),),
                          onPressed: () {},
                        ),

                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Material(
//                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0))),
                    color: Colors.indigo,
                    child: Align(

                      alignment: Alignment.bottomRight,
                      //<Widget>[
                      child: Material(
                        color: Colors.indigo,
                        child:FlatButton.icon(color: Colors.black26,
                          icon: Icon(Icons.person,color: Colors.white,),
                          label: Text('Sign In',style: TextStyle( color: Colors.white),),
                          onPressed: () => widget.toggleView(),
                        ),

                      ),
                    ),

                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,


            child: Container(
//            color: Colors.black,

              padding: EdgeInsets.fromLTRB(30,0,30,0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Form(
                  key: _formKey,
                  child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.fromLTRB(38,28,38,8),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: 'email'),
                          validator: (val) => val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: 'password'),
                          obscureText: true,
                          validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 40.0),
                        RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                setState(() => loading = true);
                                dynamic result = await _auth.registeradminWithEmailAndPassword(email, password);
                                if(result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Please supply a valid email';
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