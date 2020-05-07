import 'package:flutter/material.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'topic_list.dart';
import 'package:queastio/models/topic.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Topic>>.value(
      initialData: List(),
      value: DatabaseService().topics,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Card(
            color: Colors.teal[600],
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TopicList(),
          ),
        ],
      ),
    );
  }
}
