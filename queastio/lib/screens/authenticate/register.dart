import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String batch = 'Pharma';
  Set<String> items;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  // firebaseAuth = FirebaseAuth.getInstance();
  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    batch = batch == null ? 'Pharma' : batch;
    items=Set.from(['Pharma']);
    items.add('B-Tech');
    items.add('12th');

    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(fontSize:MediaQuery.of(context).size.height*0.09
//                        78.0
                            , fontWeight: FontWeight.bold),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                //   child: Text(
                //     '.',
                //     style: TextStyle(
                //         fontSize: 80.0,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.green),
                //   ),
                // )
              ],
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
                  // color: Colors.black,
                   padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Expanded(
                          child:
                          SizedBox(),

                        ),
                          Text("BATCH :",style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),),
                          Expanded(
                            child:
                              SizedBox(),

                          ),
                          Wrap(
//                            width: MediaQuery.of(context).size.width*0.4,
                            children:<Widget> [DropdownButton<String>(
                              value: batch,
                              underline: Container(
                                color: Color(0xff43b77d),
                                height: 2.0,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  batch = newValue;
                                });
                              },
                              items: items.map((item) {
                                return DropdownMenuItem(
                                    value: item, child: Text(item));
                              }).toList(),
                            ),]
                          ),Expanded(
                            child:
                            SizedBox(),

                          ),
                        ],
                      ),
//                      SizedBox(height: 40.0),
                      RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password,batch);
                            // dynamic user = result.user;
                            // user.send
                            if(result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                            // else{
                            //     // widget.toggleView();
                            //     return SignIn();
                            // }
                            // if(user.isEmailVerified){
                            // }
                            // FirebaseUser user = _auth.user;
                          }
                        }
                      ),
                      SizedBox(height: 25.0),
                      Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already A Member ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 15.0),
                InkWell(
                  onTap: ()=> widget.toggleView() ,
                  child: Text(
                    'SignIn',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
//                      SizedBox(height: MediaQuery.of(context).size.height*0.05),

                      SizedBox(height: MediaQuery.of(context).size.height*0.16,
                        child:Image.asset('assets/logo_.png') ),
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