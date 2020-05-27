import 'package:flutter/material.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/home/topic_tile.dart';
import 'package:queastio/services/database.dart';

class TopicList extends StatefulWidget {
  final UserData user;
  TopicList({this.user});

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  final UserData user;
  String batch ;
  _TopicListState({this.user});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Topic>>(
        stream: DatabaseService().getTopicsBatch(user.batch),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    List<Topic> topics = snapshot.data;
    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (context, index) {
        return TopicTile(topic: topics[index]);
      },
    );
  }
    else
      {
        return Container();
      }

});
  }
}

