import 'package:flutter/material.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/loading.dart';

class LeaderTile extends StatelessWidget {
  final String uid;
  final String score;
  final String index;
  LeaderTile({this.uid, this.score, this.index});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData user = snapshot.data;
            return Card(
              child: ListTile(
                title: Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                leading: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        index,
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ),
                    CircleAvatar(backgroundImage: NetworkImage(user.image),backgroundColor: Color(0xff43b77d),),
                  ],
                ),
                trailing: Text(
                  score.toString() + '%',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
