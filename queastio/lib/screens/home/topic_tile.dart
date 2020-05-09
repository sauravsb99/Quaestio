import 'package:flutter/material.dart';
import 'package:queastio/models/topic.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;

  TopicTile({this.topic});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.indigo[100],
        splashFactory: InkSplash.splashFactory,
        onTap: () {
      print(topic.name);
      Navigator.pushNamed(context, '/quizzes', arguments: topic.name);
    },
    child: Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(topic.image,width: 100.0,
            height: 100.0,),
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
    )),
    );
  }
}
