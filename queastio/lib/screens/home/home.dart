import 'package:flutter/material.dart';
import 'package:queastio/screens/home/drawer.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'topic_list.dart';
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
          backgroundColor: Colors.brown[50],
          drawer: Drawer(
            child: MyDrawer(),
          ),
          appBar: AppBar(
            title: Text('Quaestia'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
          ),
          body: TopicList(),
        ),
      ),
      );
  }
}