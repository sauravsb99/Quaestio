import 'package:flutter/material.dart';
import 'package:queastio/models/topic.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            minRadius: 10.0,
            maxRadius: 40.0,
            child: CachedNetworkImage(
                              placeholder: (context, url) => CircularProgressIndicator(),
                              imageUrl: topic.image,
                            ),
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
