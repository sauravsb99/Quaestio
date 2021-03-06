import 'package:queastio/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:queastio/screens/admin/adminhome.dart';
import 'package:queastio/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/constants.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              color: Colors.black87,
              child: Flex(
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  InkWell(
                    // child:Image.network(userData.image),
                    splashColor: Colors.white,
                    splashFactory: InkSplash.splashFactory,
                    onTap: () {
//                      Navigator.pop(context,PageTransition(duration: Duration(milliseconds: 1000)));
                      Navigator.pushNamed(context, ProfileRoute);
//
//                      Navigator.pushNamed(context,QuizListRoute,arguments: topic.name );
//                      Navigator.pushNamed(context, ProfileRoute
//                      arguments: userData.name
//                          );
                    },
                    child: DrawerHeader(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Color(0xff43b77d),
                            radius: MediaQuery.of(context).size.width * 0.10,
                            backgroundImage: NetworkImage(userData.image),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Expanded(
                            child: Text(
                              userData.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 21.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    indent: 20.0,
                    endIndent: 20.0,
                    color: Color(0xff3b3b3b),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            30,
                            MediaQuery.of(context).size.width * 0.05,
                            10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(0),
                          borderOnForeground: true,
                          color: Color(0xff3b3b3b),
                          child: FlatButton(
                            color: Color(0xff3b3b3b),
                            onPressed: () {
                              Navigator.pushNamed(context, UserListRoute);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                          color: Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    'Users',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            10,
                            MediaQuery.of(context).size.width * 0.05,
                            10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(0),
                          borderOnForeground: true,
                          color: Color(0xff3b3b3b),
                          child: FlatButton(
                            color: Color(0xff3b3b3b),
                            onPressed: () {
                              Navigator.pushNamed(context, BatchesRoute);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                          color: Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    'Batches',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            10,
                            MediaQuery.of(context).size.width * 0.05,
                            10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(0),
                          borderOnForeground: true,
                          color: Color(0xff3b3b3b),
                          child: FlatButton(
                            color: Color(0xff3b3b3b),
                            onPressed: () {
                              Navigator.pushNamed(context, MyQuizzesRoute,
                                  arguments: {
                                    'topic': 'Aptitude',
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                          color: Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    'My Quizzes',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
//                            shape: RoundedRectangleBorder(
//                                side: BorderSide(
//                                  color: Colors.black,
//                                  width: 3,
//                                  style: BorderStyle.solid,
//                                ),
//                                borderRadius: BorderRadius.circular(11)),
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
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            10,
                            MediaQuery.of(context).size.width * 0.05,
                            10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(0),
                          borderOnForeground: true,
                          color: Color(0xff3b3b3b),
                          child: FlatButton(
                            color: Color(0xff3b3b3b),
                            onPressed: () {
                              Navigator.pushNamed(context, ListSubmissionRoute);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                          color: Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    'Submission',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
//                            shape: RoundedRectangleBorder(
//                                side: BorderSide(
//                                  color: Colors.black,
//                                  width: 3,
//                                  style: BorderStyle.solid,
//                                ),
//                                borderRadius: BorderRadius.circular(11)),
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
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            10,
                            MediaQuery.of(context).size.width * 0.05,
                            10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(0),
                          borderOnForeground: true,
                          color: Color(0xff3b3b3b),
                          child: FlatButton(
                            color: Color(0xff3b3b3b),
                            onPressed: () {
                              Navigator.pushNamed(context, NewAdminHomeRoute);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                          color: Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    'New Admin',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
//                            shape: RoundedRectangleBorder(
//                                side: BorderSide(
//                                  color: Colors.black,
//                                  width: 3,
//                                  style: BorderStyle.solid,
//                                ),
//                                borderRadius: BorderRadius.circular(11)),
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
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            10,
                            MediaQuery.of(context).size.width * 0.05,
                            10),
//
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(0),
                          borderOnForeground: true,
                          color: Color(0xff3b3b3b),
                          child: FlatButton(
                            color: Color(0xff3b3b3b),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, FaQRoute);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Center(
                                  child: Text(
                                    'FAQ',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
//                            shape: RoundedRectangleBorder(
//                              side: BorderSide(
//                                color: Colors.black,
//                                width: 3,
//                                style: BorderStyle.solid,
//                              ),
//                              borderRadius: BorderRadius.circular(11),
//                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
//                  SizedBox(
//                    width: MediaQuery.of(context).size.width*0.6,
//                    child: Container(
//                      child:
//                    ),
//                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            MediaQuery.of(context).size.height * 0.025,
                            MediaQuery.of(context).size.width * 0.05,
                            0),
                        child: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(0),
                          borderOnForeground: true,
                          color: Color(0xff3b3b3b),
                          child: FlatButton(
                            color: Color(0xff3b3b3b),
                            onPressed: () async {
                              await _auth.signOut();
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Center(
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
//                            shape: RoundedRectangleBorder(
//                                side: BorderSide(
//                                  color: Colors.grey,
//                                  width: 5,
//                                  style: BorderStyle.solid,
//                                ),
//                                borderRadius: BorderRadius.circular(11)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 20,)
                ],
              ),
            );
          } else {
            return AdminHome();
          }
        });
  }
}
