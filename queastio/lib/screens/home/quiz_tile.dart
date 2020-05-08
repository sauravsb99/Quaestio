import 'package:flutter/material.dart';
import 'package:queastio/models/quiz.dart';
import 'package:cached_network_image/cached_network_image.dart';

class QuizTile extends StatelessWidget {
  final Quiz quiz;

  QuizTile({this.quiz});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.indigo[100],
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        print(quiz.questions);
        // Navigator.pushNamed(context, '/quizzes', arguments: quiz.qName);
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                quiz.qName,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
