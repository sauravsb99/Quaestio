import 'package:flutter/material.dart';
import 'package:queastio/shared/constants.dart';

class BatchTile extends StatelessWidget {
  final String topic;
  BatchTile({this.topic});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        print("hi");
        Navigator.pushNamed(context,QuizListAdminRoute, arguments: topic);
      },
      child: Card(
        child: ListTile(
          title: Text(
            topic,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          
        ),
      ),
    );
  }
}