import 'package:flutter/material.dart';
import 'package:queastio/screens/home/drawer.dart';
import 'package:queastio/screens/home/landing.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // Navigator.pop(context);
    return StreamProvider<List<Topic>>.value(
      initialData: List(),
      value: DatabaseService().topics,
      child: Container(
        child: Scaffold(
          backgroundColor: Color(0xff1b1b1b),
          drawer: Drawer(
            child: MyDrawer(),
          ),
          appBar: AppBar(
//            title: Text('Quaestia'),
//            backgroundColor: Color(0xff1b1b1b),
//            backgroundColor: Color(0xff4e6c47),
            elevation: 0.0,
//            actions:<Widget>[
//            Row(children:<Widget>[Image.network("https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/logo_EEE.png?alt=media&token=a3186033-a2f8-411b-8335-eabdf6a05c80"),],)
//          ],
          ),
          body: Landing()

        ),
      ),
    );
  }
}
