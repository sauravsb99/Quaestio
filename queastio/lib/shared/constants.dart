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

const buttonText = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w200,
  color: Color(0xFFFAFAFA),
);
const String HomeViewRoute = '/';
const String QuizListRoute = '/quizzes';
const String QuestionRoute = '/quiz';
const String PrevScoresRoute = '/prevscores';
const String ProfileRoute = '/profile';
const String FaQRoute = '/faq';
const String NewAdminHomeRoute = '/newadmin';
const String Signin = '/signin';
const String QuizListAdminRoute = '/quizzesadmin';
const String HomeRoute = '/home';
const String MyQuizzesRoute = '/myquizzes';
const String AddQuizRoute = '/addquiz';
const String UserListRoute = '/userlist';
const String LeaderRoute = '/leader';
const String TopicLeaderRoute = '/topicleader';
const String AnswerSheetRoute = '/answers';
const String AboutUsRoute = '/about-us';
const String BatchesRoute = '/batches';
const String BatchTopicsRoute = '/batchtopics';
const String SetBatchTopicsRoute = '/setbatchtopics';
