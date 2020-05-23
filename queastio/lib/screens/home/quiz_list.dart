import 'package:flutter/material.dart';
import 'package:queastio/models/quiz.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/shared/loading.dart';
import 'package:queastio/screens/home/quiz_tile.dart';
import 'package:queastio/services/database.dart';

class QuizList extends StatefulWidget {
  final String topic;
  QuizList({this.topic});
  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Quiz>>(
      stream: DatabaseService().getQuizzes(widget.topic),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Quiz> data = snapshot.data;
          return Scaffold(
            backgroundColor: Color(0xff0fc77e),
            appBar: AppBar(
//              backgroundColor: Color(0xff0fc77e),
              title: Text(
                widget.topic,
                style: TextStyle(
                  letterSpacing: 2.0,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () {
                    Navigator.pushNamed(context, TopicLeaderRoute,
                        arguments: widget.topic);
                  },
                )
              ],
            ),
            body: data.length == 0
                ? Center(
                    child: Text(
                      'No tests here yet.Check back later.',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(
                    color: Colors.white,
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
