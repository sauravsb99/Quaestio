import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:queastio/screens/home/Drawer.dart';

import 'landing.dart';

class Home extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        drawer: Drawer(
          child: MyDrawer(),
        ),
          appBar: AppBar(
            title: Text('Quaestia'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
//          actions: <Widget>[
//            FlatButton.icon(
//              icon: Icon(Icons.person),
//              label: Text('logout'),
//
//            ),
//          ],
        ),
        body: Landing(),
      ),
      );
  }
}