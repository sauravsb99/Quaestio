import 'package:flutter/material.dart';
import 'package:queastio/models/topic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:queastio/shared/constants.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;

  TopicTile({this.topic});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.indigo,
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        print(topic.name);
        Navigator.pushNamed(context, QuizListRoute, arguments: topic.name);
      },
      child: Card(
          color: Colors.indigo,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: topic.image,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    topic.name,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
