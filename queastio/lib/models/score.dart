import 'package:cloud_firestore/cloud_firestore.dart';

class Score {
  final String quiz;
  final String uid;
  final int score;
  final int total;
  final Timestamp time;

  Score({this.quiz, this.uid, this.score, this.total,this.time});
}

