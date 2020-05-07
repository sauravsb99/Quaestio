import 'package:queastio/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:queastio/screens/home/landing.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        drawer: Drawer(
          child: ListView(
            children:<Widget>[
              Padding(padding: const EdgeInsets.all(13.0),
                child: Container(
                  child:Material(
                    color: Colors.deepOrangeAccent,
                    elevation: 15.0,
                    borderRadius: BorderRadius.circular(15.0),
                    borderOnForeground: true,
                    child: Row(
                      children: <Widget>[
                        Text("hi"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Quaestia'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Landing(),
      ),
    );
  }
}
