import 'package:flutter/material.dart';
import 'package:queastio/models/score.dart';
import 'package:queastio/screens/home/leader_tile.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/loading.dart';

class LeaderBoard extends StatefulWidget {
  final String qname;
  LeaderBoard({this.qname});
  @override
  _LeaderBoardState createState() => _LeaderBoardState(qname: qname);
}

class _LeaderBoardState extends State<LeaderBoard> {
  final String qname;
  _LeaderBoardState({this.qname});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Score>>(
        stream: DatabaseService().getQuizScores(qname),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Score> scores = snapshot.data;
            return Scaffold(
              appBar: AppBar(title: Text('LeaderBoard')),
              body: ListView.builder(
                  itemCount: scores.length,
                  itemBuilder: (context, index) {
                    double perc =
                        (scores[index].score / scores[index].total) * 100;
                    return LeaderTile(
                        uid: scores[index].uid,
                        score: perc.toString(),
                        index: (index + 1).toString());
                  }),
            );
          } else {
            return Loading();
          }
        });
  }
}
