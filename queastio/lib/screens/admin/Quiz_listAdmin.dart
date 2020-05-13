import 'package:flutter/material.dart';
import 'package:queastio/models/quiz.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/shared/loading.dart';
import 'package:queastio/screens/admin/Quiz_tileAdmin.dart';
import 'package:queastio/services/database.dart';

class QuizListAdmin extends StatefulWidget {
  final String topic;
  QuizListAdmin({this.topic});
  @override
  _QuizListAdminState createState() => _QuizListAdminState(topic: topic);
}

class _QuizListAdminState extends State<QuizListAdmin> {
  final String topic;
  _QuizListAdminState({this.topic});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Quiz>>(
      stream: DatabaseService().getQuizzes(topic),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Quiz> data = snapshot.data;
          return Scaffold(

            backgroundColor: Colors.indigo,
            appBar: AppBar(
              backgroundColor: Colors.indigo,
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){
              print("kali thudangatte");
              Navigator.pushNamed(context, AddQuizRoute);
            },
              child: Icon(Icons.plus_one),
            ),
            body: data.length == 0
                ? Center(
              child: Text(
                'No tests here yet.Check back later.',
                style: TextStyle(color: Colors.white),
              ),
            )
                :Container(

              color: Colors.indigo,
              child: ListView.builder(

                itemCount: data.length,
                itemBuilder: (context, index) {
                  return QuizTileAdmin(quiz: data[index]);
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
