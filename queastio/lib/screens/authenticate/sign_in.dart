import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Column(
              // key: _formKey,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
//                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  15.0,
                                  MediaQuery.of(context).size.height * 0.1,
                                  0.0,
                                  0.0),
                              child: Text('Welcome',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.09
//                            78.0
                                      ,
                                      fontWeight: FontWeight.bold)),
                            ),
//                      ],
//                    ),
//                  ),
//                  Container(
//                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
//                    child:
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                              child: Text('Back',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.09
//                            78.0
                                      ,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                      //   child: Text('.',
                      //       style: TextStyle(
                      //           fontSize: 80.0,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.indigo)),
                      // )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: Center(
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
//            color: Colors.black,

                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        // color: Colors.black,
                        padding:
                            EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            TextFormField(
                              // decoration: textInputDecoration.copyWith(hintText: 'email'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              onTap: () {
                                setState(() {
                                  error = '';
                                });
                              },
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              // ),
                            ),
                            // SizedBox(
                            //     // height: 20.0,
                            //     ),
                            TextFormField(
                              // decoration: textInputDecoration.copyWith(hintText: 'password'),
                              obscureText: true,
                              validator: (val) => val.length < 6
                                  ? 'Enter a password 6+ chars long'
                                  : null,
                              onTap: () {
                                setState(() {
                                  error = '';
                                });
                              },
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              alignment: Alignment(1.0, 0.0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  _auth.sendPasswordReset(email);
                                  print("sending mail");
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            RaisedButton(
                                color: Colors.green,
                                elevation: 7.0,
                                // borderRadius: BorderRadius.circular(20.0),
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);

                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            'Could not sign in with those credentials';
                                      });
                                    }
                                  }
                                }),
                            // SizedBox(height: 40.0),
                            // RaisedButton(
                            //     color: Colors.pink[400],
                            //     child:Text("Reset Password",style: TextStyle( color: Colors.white),),
                            //     onPressed: () async {
                            //         _auth.sendPasswordReset(email);
                            //         print("sending mail");

                            //     }
                            // ),

//                        Expanded(
//                          child:Container(
//                            color:Colors.black87,
//                          child: Text("",textAlign:TextAlign.end),
////                height: 15.0
//                        ),),
//                      SizedBox(height: MediaQuery.of(context).size.height*0.08
//                        ,),
                            SizedBox(height: 20.0),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.16,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/logo_EEE.png?alt=media&token=a3186033-a2f8-411b-8335-eabdf6a05c80"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //     ),
                //   ],
                // ),
                // Container(
                //   // key: _formKey,
                //     padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                //     child : Form(
                //       // key: _formKey,
                //     child: Column(
                //       key: _formKey,
                //       children: <Widget>[
                //         TextFormField(
                //           validator: (val) => val.isEmpty ? 'Enter an email' : null,
                //               onChanged: (val) {
                //                 setState(() => email = val);
                //               },
                //           decoration: InputDecoration(
                //               labelText: 'EMAIL',

                //               labelStyle: TextStyle(
                //                   fontFamily: 'Montserrat',
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.grey),
                //               focusedBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.green))),
                //         ),
                //         SizedBox(height: 20.0),
                //         TextFormField(
                //           validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                //               onChanged: (val) {
                //                 setState(() => password = val);
                //               },
                //           decoration: InputDecoration(
                //               labelText: 'PASSWORD',
                //               labelStyle: TextStyle(
                //                   fontFamily: 'Montserrat',
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.grey),
                //               focusedBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.green))),
                //           obscureText: true,
                //         ),
                //         SizedBox(height: 5.0),
                //         Container(
                //           alignment: Alignment(1.0, 0.0),
                //           padding: EdgeInsets.only(top: 15.0, left: 20.0),
                //           child: InkWell(
                //             onTap: () async {
                //                     _auth.sendPasswordReset(email);
                //                     print("sending mail");

                //                 },
                //             child: Text(
                //               'Forgot Password',
                //               style: TextStyle(
                //                   color: Colors.green,
                //                   fontWeight: FontWeight.bold,
                //                   fontFamily: 'Montserrat',
                //                   decoration: TextDecoration.underline),
                //             ),
                //           ),
                //         ),
                //         SizedBox(height: 40.0),
                //         RaisedButton(
                //                 color: Colors.green,
                //                 child:Text("Sign in",style: TextStyle( color: Colors.white),),
                //                 onPressed: () async {
                //                   if(_formKey.currentState.validate()){
                //                     setState(() => loading = true);
                //                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                //                     if(result == null) {
                //                       setState(() {
                //                         loading = false;
                //                         error = 'Could not sign in with those credentials';
                //                       });
                //                     }
                //                   }
                //                 }
                //             ),
                //         // Container(

                //         //   height: 40.0,
                //         //   child: Material(
                //         //     borderRadius: BorderRadius.circular(20.0),
                //         //     shadowColor: Colors.greenAccent,
                //         //     color: Colors.green,
                //         //     elevation: 7.0,
                //         //     child: GestureDetector(
                //         //       onTap: () async {
                //         //           if(_formKey.currentState.validate()){
                //         //             setState(() => loading = true);
                //         //             dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                //         //             if(result == null) {
                //         //               setState(() {
                //         //                 loading = false;
                //         //                 error = 'Could not sign in with those credentials';
                //         //               });
                //         //             }
                //         //           }
                //         //         },
                //         //       child: Center(
                //         //         child: Text(
                //         //           'LOGIN',
                //         //           style: TextStyle(
                //         //               color: Colors.white,
                //         //               fontWeight: FontWeight.bold,
                //         //               fontFamily: 'Montserrat'),
                //         //         ),
                //         //       ),
                //         //     ),
                //         //   ),
                //         // ),
                //         // SizedBox(height: 20.0),
                //         // Container(
                //         //   height: 40.0,
                //         //   color: Colors.transparent,
                //         //   child: Container(
                //         //     decoration: BoxDecoration(
                //         //         border: Border.all(
                //         //             color: Colors.black,
                //         //             style: BorderStyle.solid,
                //         //             width: 1.0),
                //         //         color: Colors.transparent,
                //         //         borderRadius: BorderRadius.circular(20.0)),
                //         //     child: Row(
                //         //       mainAxisAlignment: MainAxisAlignment.center,
                //         //       children: <Widget>[
                //         //         Center(
                //         //           child:
                //         //               ImageIcon(AssetImage('assets/facebook.png')),
                //         //         ),
                //         //         SizedBox(width: 10.0),
                //         //         Center(
                //         //           child: Text('Log in with facebook',
                //         //               style: TextStyle(
                //         //                   fontWeight: FontWeight.bold,
                //         //                   fontFamily: 'Montserrat')),
                //         //         )
                //         //       ],
                //         //     ),
                //         //   ),
                //         // )
                //       ],
                //     ))),
                Expanded(
                  child: Text("", textAlign: TextAlign.end),
//                height: 15.0
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to Quaestio ?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () => widget.toggleView(),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ));
//     Scaffold(
//       backgroundColor: Colors.indigo,
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         elevation: 0.0,
//         title: Text('Sign In'),
//       ),

//       body: Wrap(
//         children: <Widget>[
//           Container(
//             child: Padding(

//               padding: EdgeInsets.fromLTRB(30,MediaQuery.of(context).size.height*0.2,30,0),
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child:SizedBox(width: 20,
// //                      child:Text('hiyo',textScaleFactor: 5,style: TextStyle(fontFamily: 'Jost') ,textAlign: TextAlign.left,),
//                     ),
//                   ),
//                   Material(
//                     color: Colors.indigo,
//                     child: Align(

//                       alignment: Alignment.bottomRight,
//                       //<Widget>[
//                       child: Material(
//                         color: Colors.indigo,
// //                      borderRadius: BorderRadius.circular(50),
// //                      borderOnForeground: true,
// ////                  shadowColor: Colors.white,
// //                  elevation: 14.0,

//                         child:FlatButton.icon(color: Colors.black26,
//                           icon: Icon(Icons.person,color: Colors.white,),
//                           label: Text('Register',style: TextStyle( color: Colors.white),),
//                           onPressed: ()=> widget.toggleView() ,
//                         ),

//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 5,),
//                   Material(
//                     shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0))),
//                     color: Colors.indigo,
//                     child: Align(

//                       alignment: Alignment.bottomRight,
//                       //<Widget>[
//                       child: Material(
//                         color: Colors.indigo,
// //                      borderRadius: BorderRadius.circular(50),
// //                      borderOnForeground: true,
// ////                  shadowColor: Colors.white,
// //                  elevation: 14.0,

//                         child:FlatButton.icon(color: Colors.black,
//                           icon: Icon(Icons.person,color: Colors.white,),
//                           label: Text('Sign In',style: TextStyle( color: Colors.white),),
//                           onPressed: () {},
//                         ),

//                       ),
//                     ),

//                   )
//                 ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,

//             child: Container(
// //            color: Colors.black,

//               padding: EdgeInsets.fromLTRB(30,0,30,0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                 child: Form(
//                   key: _formKey,
//                   child: Container(
//                     color: Colors.black,
//                     padding: EdgeInsets.fromLTRB(38,28,38,8),
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(height: 20.0),
//                         TextFormField(
//                           decoration: textInputDecoration.copyWith(hintText: 'email'),
//                           validator: (val) => val.isEmpty ? 'Enter an email' : null,
//                           onChanged: (val) {
//                             setState(() => email = val);
//                           },
//                         ),
//                         SizedBox(height: 20.0),
//                         TextFormField(
//                           decoration: textInputDecoration.copyWith(hintText: 'password'),
//                           obscureText: true,
//                           validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
//                           onChanged: (val) {
//                             setState(() => password = val);
//                           },
//                         ),
//                         SizedBox(height: 40.0),
//                         RaisedButton(
//                             color: Colors.pink[400],
//                             child:Text("Sign in",style: TextStyle( color: Colors.white),),
//                             onPressed: () async {
//                               if(_formKey.currentState.validate()){
//                                 setState(() => loading = true);
//                                 dynamic result = await _auth.signInWithEmailAndPassword(email, password);

//                                 if(result == null) {
//                                   setState(() {
//                                     loading = false;
//                                     error = 'Could not sign in with those credentials';
//                                   });
//                                 }
//                               }
//                             }
//                         ),
//                         SizedBox(height: 40.0),
//                         RaisedButton(
//                             color: Colors.pink[400],
//                             child:Text("Reset Password",style: TextStyle( color: Colors.white),),
//                             onPressed: () async {
//                                 _auth.sendPasswordReset(email);
//                                 print("sending mail");

//                             }
//                         ),
//                         SizedBox(height: 12.0),
//                         Text(
//                           error,
//                           style: TextStyle(color: Colors.red, fontSize: 14.0),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
  }
}
