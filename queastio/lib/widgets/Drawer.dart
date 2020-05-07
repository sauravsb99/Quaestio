import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:queastio/services/auth.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: ListView(

        children:<Widget>[

          Container(
            color: Colors.white,
            child: Padding(padding: const EdgeInsets.all(13.0),

              child:Material(
                color: Colors.deepOrangeAccent,
                elevation: 15.0,
                borderRadius: BorderRadius.circular(15.0),
                borderOnForeground: true,

                child: FlatButton(
                  onPressed: (){},


                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
//                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/4,8,8,8),
                        child: Container(

                          child: Text("Profile",textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22.0,color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Padding(
//padding: EdgeInsetsGeometry(WrapAlignment.center),
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,50,MediaQuery.of(context).size.width*0.05,8),
//
                child: Material(
                  elevation: 15.0,
                  borderRadius: BorderRadius.circular(15.0),
                  borderOnForeground: true,
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                          color: Colors.blueGrey,
                        child:Center(
                          child: Text('About Us', style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                          ),
                        ),
                      ),
                    ),

                    shape: RoundedRectangleBorder(side: BorderSide(
                      color: Colors.deepOrangeAccent,
                      width: 5,
                      style: BorderStyle.solid,
                    ), borderRadius: BorderRadius.circular(11)),
                  ),
                ),
              ),
            ],
          ),

          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Padding(
//padding: EdgeInsetsGeometry(WrapAlignment.center),
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,50,MediaQuery.of(context).size.width*0.05,8),
//
                child: Material(
                  elevation: 15.0,
                  borderRadius: BorderRadius.circular(15.0),
                  borderOnForeground: true,
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                          color: Colors.blueGrey,
                        child:Center(
                          child: Text('Contact Us', style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                          ),
                        ),
                      ),
                    ),

                    shape: RoundedRectangleBorder(side: BorderSide(
                      color: Colors.deepOrangeAccent,
                      width: 5,
                      style: BorderStyle.solid,
                    ), borderRadius: BorderRadius.circular(11)),
                  ),
                ),
              ),
            ],
          ),


                Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Padding(
                      //padding: EdgeInsetsGeometry(WrapAlignment.center),
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,50,MediaQuery.of(context).size.width*0.05,8),
                      //
                      child: Material(
                        elevation: 15.0,
                        borderRadius: BorderRadius.circular(15.0),
                        borderOnForeground: true,
                        child: FlatButton(
                          onPressed: () async {
                            await _auth.signOut();

                            },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.7,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                          color: Colors.blueGrey,
                              child:Center(
                                child: Text('Logout', style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                                ),
                              ),
                            ),
                          ),

                          shape: RoundedRectangleBorder(side: BorderSide(
                            color: Colors.deepOrangeAccent,
                            width: 5,
                            style: BorderStyle.solid,
                          ), borderRadius: BorderRadius.circular(11)),
                        ),
                      ),
                    ),
                  ],
                ),



//              TEST
//                Container(
//
//                  // This align moves the children to the bottom
//                    child: Align(
//                        alignment: FractionalOffset.bottomCenter,
//                        // This container holds all the children that will be aligned
//                        // on the bottom and should not scroll with the above ListView
//                        child: Container(
//                            child: Column(
//                              children: <Widget>[
//                                Divider(),
//                                ListTile(
//                                    leading: Icon(Icons.settings),
//                                    title: Text('Settings')),
//                                ListTile(
//                                    leading: Icon(Icons.help),
//                                    title: Text('Help and Feedback'))
//                              ],
//                            )
//                        )
//                    )
//                ),





        ],
      ),
    );
  }
}



