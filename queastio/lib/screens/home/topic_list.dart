import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/screens/home/topic_tile.dart';

class TopicList extends StatefulWidget {
  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  @override
  Widget build(BuildContext context) {
    final topics = Provider.of<List<Topic>>(context);
    topics.forEach((topic) {
      print(topic.name);
      print(topic.image);
    });
    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (context, index) {
        return TopicTile(topic: topics[index]);
      },
    );
  }
}
