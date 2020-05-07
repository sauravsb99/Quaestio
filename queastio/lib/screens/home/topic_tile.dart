import 'package:flutter/material.dart';
import 'package:queastio/models/topic.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;
  TopicTile({this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(topic.image),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              topic.name,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
