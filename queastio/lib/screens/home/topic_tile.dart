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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(topic.image,width: 100.0,
            height: 100.0,),
          CircleAvatar(
            radius: 30,
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
