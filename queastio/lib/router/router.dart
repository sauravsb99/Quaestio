import 'package:flutter/material.dart';
import 'package:queastio/screens/home/previous_scores.dart';
import 'package:queastio/screens/home/question_card.dart';
import 'package:queastio/screens/home/quiz_list.dart';
import 'package:queastio/screens/profileScreen/profile.dart';
import 'package:queastio/screens/wrapper.dart';
import 'package:queastio/shared/constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => Wrapper());
    case QuizListRoute:
      return MaterialPageRoute(
          builder: (context) => QuizList(topic: settings.arguments));
    case QuestionRoute:
      return MaterialPageRoute(
          builder: (context) => QuestionCard(quiz: settings.arguments));
    case PrevScoresRoute:
      return MaterialPageRoute(builder: (context) => PreviousScores());
    case ProfileRoute:
      return MaterialPageRoute(builder: (context) => ProfileScreen());
  }
}
