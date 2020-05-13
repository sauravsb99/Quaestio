import 'package:flutter/material.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/shared/constants.dart';

class TopicTileAdmin extends StatelessWidget {
  final Topic topic;

  TopicTileAdmin({this.topic});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        print("hi");
        Navigator.pushNamed(context, QuizListAdminRoute, arguments: topic.name);
      },
      child: Material(
//          color: Colors.indigo,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    topic.name,
//                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
