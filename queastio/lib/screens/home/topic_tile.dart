import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:queastio/models/topic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:queastio/screens/home/quiz_list.dart';
import 'package:queastio/shared/constants.dart';

import 'about_us.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;

  TopicTile({this.topic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//      splashColor: Colors.indigo,
//      splashFactory: InkSplash.splashFactory,
//    final GestureDragDownCallback onPanDown
      onTap: () {
        print(topic.name);
        Navigator.pushNamed(context,QuizListRoute,arguments: topic.name );
//        QuizListRoute, arguments: topic.name);
      },
      child: Card(
          color: Color(0xff43b77d),
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
