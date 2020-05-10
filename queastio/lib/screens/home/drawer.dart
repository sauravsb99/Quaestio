import 'package:queastio/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:queastio/screens/home/home.dart';
import 'package:queastio/screens/profileScreen/profile.dart';
import 'package:queastio/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/database.dart';
class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Container(
              color: Colors.black26,
              child: ListView(

                children:<Widget>[
              InkWell(
              splashColor: Colors.indigo[100],
                splashFactory: InkSplash.splashFactory,
                onTap: () {
                  print(userData.name);
                  Navigator.pushNamed(context, '/profile', arguments: userData.name);
                },
                child:DrawerHeader(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
//                          CircleAvatar (
//                            radius:35.0,
//                            backgroundColor: Colors.grey[800],
//                            backgroundImage: userData.image==null?NetworkImage("https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg"):NetworkImage(userData.image),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Text(userData.name,textAlign: TextAlign.center,
//=======
//                          CircleAvatar (
//                            radius:35.0,
//                            backgroundColor: Colors.grey[800],
//                            backgroundImage: NetworkImage(userData.image),
//                          ),
//
//                          SizedBox(width: MediaQuery.of(context).size.width*0.05,),
//                          Text(userData.name,textAlign: TextAlign.center,
//>>>>>>> 61c9d171b3ca8300c0b01336e26c804036a235de
                            style: TextStyle(fontSize: 17.0,color: Colors.white),
                          ),

                        ],
                      ),
                    ),
                  ),

                  Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,30,MediaQuery.of(context).size.width*0.05,10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(15.0),
                          borderOnForeground: true,
                          child: FlatButton(
                            color: Colors.grey,
                            onPressed: (){},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                              color: Colors.black,
                              width: 3,
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
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,10,MediaQuery.of(context).size.width*0.05,10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(15.0),
                          borderOnForeground: true,
                          child: FlatButton(
                            color: Colors.grey,
                            onPressed: (){},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                              color: Colors.black,
                              width: 3,
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
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,10,MediaQuery.of(context).size.width*0.05,10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(15.0),
                          borderOnForeground: true,
                          child: FlatButton(
                            color: Colors.grey,
                            onPressed: (){},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(

                                width: MediaQuery.of(context).size.width*0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                          color: Colors.blueGrey,
                                child:Center(
                                  child: Text('FAQ', style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                  ),
                                ),
                              ),
                            ),

                            shape: RoundedRectangleBorder(side: BorderSide(
                              color: Colors.black,
                              width: 3,
                              style: BorderStyle.solid,
                            ), borderRadius: BorderRadius.circular(11),

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  Container(

                    // This align moves the children to the bottom
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          // This container holds all the children that will be aligned
                          // on the bottom and should not scroll with the above ListView
                          child: Container(
                              child: Column(
//                        children: <Widget>[
//                          Divider(),
//                          ListTile(
//                              leading: Icon(Icons.settings),
//                              title: Text('Settings')),
//                          ListTile(
//                              leading: Icon(Icons.help),
//                              title: Text('Help and Feedback'))
//                        ],
                              )
                          )
                      )
                  ),


                  Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Padding(
                        //padding: EdgeInsetsGeometry(WrapAlignment.center),
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.height*0.30,MediaQuery.of(context).size.width*0.05,0),
                        //
                        child: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(15.0),
                          borderOnForeground: true,
                          child: FlatButton(
                            onPressed: () async {
                              await _auth.signOut();
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                              color: Colors.grey,
                              width: 5,
                              style: BorderStyle.solid,
                            ), borderRadius: BorderRadius.circular(11)),
                          ),
                        ),
                      ),
                    ],
                  ),



//              TEST






                ],
              ),
            );
          }
          else {
            return Home();
          }
        });

  }
}
