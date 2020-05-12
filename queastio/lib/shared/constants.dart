import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

const String HomeViewRoute = '/';
const String QuizListRoute = '/quizzes';
const String QuestionRoute = '/quiz';
const String PrevScoresRoute = '/prevscores';
const String ProfileRoute = '/profile';
const String FaQRoute = '/faq';
const String LeaderRoute = '/leader';
