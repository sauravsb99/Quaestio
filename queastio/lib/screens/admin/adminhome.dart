import 'package:flutter/material.dart';
import 'package:queastio/screens/admin/topiclistadmin.dart';
import 'package:queastio/screens/admin/admindrawer.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';

class AdminHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // Navigator.pop(context);
    return StreamProvider<List<Topic>>.value(
      initialData: List(),
      value: DatabaseService().topics,
      child: Container(
        child: Scaffold(
//          backgroundColor: Colors.black26,
          drawer: Drawer(
            child: AdminDrawer(),
          ),
          appBar: AppBar(
            title: Text('Quaestia'),
            backgroundColor: Colors.indigo,
            elevation: 0.0,
          ),
          body: TopicListAdmin(),
        ),
      ),
    );
  }
}
