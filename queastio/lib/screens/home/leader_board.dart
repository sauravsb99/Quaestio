import 'package:flutter/material.dart';
import 'package:queastio/models/score.dart';
import 'package:queastio/screens/home/leader_tile.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/loading.dart';
import 'package:queastio/shared/nothing_here.dart';

class LeaderBoard extends StatefulWidget {
  final String qId;
  LeaderBoard({this.qId});
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Score>>(
        stream: DatabaseService().getQuizScores(widget.qId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Score> scores = snapshot.data;
            return scores.length == 0
                ? NothingHere(
                    title: 'LeaderBoard',
                    text: 'The quiz hasn\'t been attempted yet',
                  )
                : Scaffold(
                    appBar: AppBar(title: Text('LeaderBoard')),
                    body: ListView.builder(
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          double perc =
                              (scores[index].score / scores[index].total) * 100;
                          return LeaderTile(
                              uid: scores[index].uid,
                              score: perc.toStringAsFixed(2),
                              index: (index + 1).toString());
                        }),
                  );
          } else {
            return Loading();
          }
        });
  }
}
