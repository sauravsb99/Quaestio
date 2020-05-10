import 'package:flutter/material.dart';
import 'package:queastio/models/quiz.dart';
import 'quiz_tile.dart';
import 'package:queastio/services/database.dart';

class QuizList extends StatefulWidget {
  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  @override
  Widget build(BuildContext context) {
    final String topic = ModalRoute.of(context).settings.arguments;
    return StreamBuilder<List<Quiz>>(
      stream: DatabaseService().getQuizzes(topic),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Quiz> data = snapshot.data;
          return Scaffold(
            appBar: AppBar(),
            body: data.length == 0
                ? Center(child: Text('No tests here yet.Check back later.'))
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return QuizTile(quiz: data[index]);
                    },
                  ),
          );
        }
        return Text('Boring');
      },
    );
  }
}
