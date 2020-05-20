import 'package:flutter/material.dart';
import 'package:queastio/models/quiz.dart';
import 'package:queastio/shared/loading.dart';
import 'package:queastio/screens/home/quiz_tile.dart';
import 'package:queastio/services/database.dart';

class QuizList extends StatefulWidget {
  final String topic;
  QuizList({this.topic});
  @override
  _QuizListState createState() => _QuizListState(topic: topic);
}

class _QuizListState extends State<QuizList> {
  final String topic;
  _QuizListState({this.topic});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Quiz>>(
      stream: DatabaseService().getQuizzes(topic),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Quiz> data = snapshot.data;
          return Scaffold(
            backgroundColor: Color(0xff0fc77e),
            appBar: AppBar(
              backgroundColor: Color(0xff0fc77e),
              title: Text(
                topic,
                style: TextStyle(
                  letterSpacing: 2.0,
                ),
              ),
            ),
            body: data.length == 0
                ? Center(
                    child: Text(
                      'No tests here yet.Check back later.',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(
                    color: Color(0xfff2c4c1),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return QuizTile(quiz: data[index]);
                      },
                    ),
                  ),
          );
        }
        return Loading();
      },
    );
  }
}
