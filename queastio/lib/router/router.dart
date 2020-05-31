
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:queastio/screens/FAQ/faqhome.dart';
import 'package:queastio/screens/admin/Quiz_listAdmin.dart';
import 'package:queastio/screens/admin/add_quiz.dart';
import 'package:queastio/screens/admin/admin_sub.dart';
import 'package:queastio/screens/admin/questionadd.dart';
import 'package:queastio/screens/admin/quizaddmanual.dart';
import 'package:queastio/screens/admin/user_listAdmin.dart';
import 'package:queastio/screens/authenticate/sign_in.dart';
import 'package:queastio/screens/home/about_us.dart';
import 'package:queastio/screens/home/home.dart';
import 'package:queastio/screens/home/answersheet.dart';
import 'package:queastio/screens/home/leader_board.dart';
import 'package:queastio/screens/home/previous_scores.dart';
import 'package:queastio/screens/home/question_card.dart';
import 'package:queastio/screens/home/quiz_list.dart';
import 'package:queastio/screens/home/submission.dart';
import 'package:queastio/screens/home/topic_leader_board.dart';
import 'package:queastio/screens/home/upload_document.dart';
import 'package:queastio/screens/profileScreen/profile.dart';
import 'package:queastio/screens/wrapper.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/screens/newadmin/New_adminHome.dart';
import 'package:queastio/screens/admin/myquizzes.dart';
import 'package:queastio/screens/admin/batchtopics.dart';
import 'package:queastio/screens/admin/set_batchtopics.dart';

import '../screens/admin/batches.dart';

//import '../screens/admin/batches.dart';

// ignore: missing_return
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case QuizListRoute:
      return PageTransition(
        child: QuizList(
          topic: settings.arguments,
        ),
        type: PageTransitionType.rightToLeft,
        settings: settings,
        duration: Duration(milliseconds: 250),
      );
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => Wrapper());

    case QuestionsAddRoute:
      dynamic data = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => QuestionAdd(
                qTopic: data["qTopic"],
                qDescr: data["qDescr"],
                qName: data["qName"],
                qTime: data["qTime"],
              ));
    case QuestionRoute:
      return MaterialPageRoute(
          builder: (context) => QuestionCard(quiz: settings.arguments));

    case PrevScoresRoute:
      return PageTransition(
        child: PreviousScores(uid: settings.arguments),
        type: PageTransitionType.rightToLeft,
        settings: settings,
        duration: Duration(milliseconds: 500),
      );
//          builder: (context) => PreviousScores(uid: settings.arguments));
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case ProfileRoute:
      return PageTransition(
        child: ProfileScreen(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      );
    case FaQRoute:
      return PageTransition(
        child: FaqHome(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      );
    case NewAdminHomeRoute:
      return MaterialPageRoute(builder: (context) => NewAdminHome());
    case QuizListAdminRoute:
      return MaterialPageRoute(
          builder: (context) => QuizListAdmin(topic: settings.arguments));
    case MyQuizzesRoute:
      return MaterialPageRoute(builder: (context) => MyQuizListAdmin());
    case AddQuizRoute:
      return MaterialPageRoute(builder: (context) => AddQuiz());
    case UserListRoute:
      return MaterialPageRoute(builder: (context) => UserList());
    case Signin:
      return MaterialPageRoute(builder: (context) => SignIn());
    case LeaderRoute:
      dynamic data = settings.arguments;

      return PageTransition(
          child: LeaderBoard(
            qId: data['qId'],
          ),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 500));

    case TopicLeaderRoute:
      return PageTransition(
          child: TopicLeaderBoard(topic: settings.arguments),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 500));

    case AnswerSheetRoute:
      dynamic data = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => AnswerSheet(
          questions: data['questions'],
          selected: data['selected'],
        ),
      );
    case SubmissionRoute:
      return MaterialPageRoute(builder: (context)=> Submission());
    case ListSubmissionRoute:
      return MaterialPageRoute(builder: (context)=> ListSubmission());
    case AboutUsRoute:
      return MaterialPageRoute(builder: (context) => AboutUs());
    case BatchesRoute:
      return MaterialPageRoute(builder: (context) => Batches());
    case BatchTopicsRoute:
      return MaterialPageRoute(
          builder: (context) => BatchTopics(batch: settings.arguments));
    case SetBatchTopicsRoute:
      dynamic data = settings.arguments;
      return MaterialPageRoute(
          builder: (context) =>
              SetBatchTopics(topics: data['topics'], batch: data['batch']));
    case QuizAddManualRoute:
      return MaterialPageRoute(
          builder: (context) => QuizAddManual(qTopic: settings.arguments));
    case UploaderRoute:
      dynamic data = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => Uploader(qid: data['qid'],qname: data['qname'],stype: data['stype']));
  }
}
