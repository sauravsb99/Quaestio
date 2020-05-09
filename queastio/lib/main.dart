import 'package:flutter/material.dart';
import 'package:queastio/screens/home/question_card.dart';
import 'package:queastio/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/auth.dart';
import 'models/user.dart';
import 'package:queastio/screens/home/quiz_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes: <String, WidgetBuilder>{
          '/quizzes': (context) => QuizList(),
          '/quiz': (context) => QuestionCard(),
        },
      ),
    );
  }
}
