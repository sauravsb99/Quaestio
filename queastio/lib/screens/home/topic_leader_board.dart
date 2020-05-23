import 'package:flutter/material.dart';
import 'package:queastio/models/score.dart';
import 'package:queastio/screens/home/leader_tile.dart';
import 'package:queastio/services/database.dart';

class TopicLeaderBoard extends StatefulWidget {
  final String topic;
  TopicLeaderBoard({this.topic});
  @override
  _TopicLeaderBoardState createState() => _TopicLeaderBoardState();
}

class UserScores {
  String uid;
  double total;
  int count;
}

class _TopicLeaderBoardState extends State<TopicLeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Score>>(
        stream: DatabaseService().getTopicScoresAll(widget.topic),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Score> scores = snapshot.data;
            List<UserScores> userScores = [];
            scores.forEach((element) {
              UserScores user = userScores.singleWhere(
                  (it) => it.uid == element.uid,
                  orElse: () => null);
              if (user == null) {
                UserScores newUser = UserScores();
                newUser.uid = element.uid;
                newUser.total = 100 * element.score / element.total;
                newUser.count = 1;
                userScores.add(newUser);
              } else {
                user.total += (100 * element.score / element.total);
                user.count++;
              }
            });
            userScores.forEach((element) {
              element.total /= element.count;
            });
            userScores.sort((b, a) => a.total.compareTo(b.total));
            return Scaffold(
              appBar: AppBar(title: Text('LeaderBoard')),
              body: scores.length == 0
                  ? Center(child: Text('The quiz hasn\'t been attempted yet'))
                  : ListView.builder(
                      itemCount: userScores.length,
                      itemBuilder: (context, index) {
                        return LeaderTile(
                            uid: userScores[index].uid,
                            score: userScores[index].total.toStringAsFixed(2),
                            index: (index + 1).toString());
                      }),
            );
          } else {
            return Scaffold(
              appBar: AppBar(title: Text('LeaderBoard')),
              body: Center(
                child: Text('The quiz hasn\'t been attempted yet'),
              ),
            );
          }
        });
  }
}
