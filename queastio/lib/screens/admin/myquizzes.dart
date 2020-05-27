import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/quiz.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/admin/myquizzes_tile.dart';
import 'package:queastio/shared/loading.dart';
import 'package:queastio/services/database.dart';

class MyQuizListAdmin extends StatefulWidget {
  MyQuizListAdmin();
  @override
  _MyQuizListAdminState createState() => _MyQuizListAdminState();
}

class _MyQuizListAdminState extends State<MyQuizListAdmin> {
  _MyQuizListAdminState();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return StreamBuilder<List<Quiz>>(
      stream: DatabaseService().getQuizzesadmin(user.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Quiz> data = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.indigo,
            appBar: AppBar(
//              backgroundColor: Colors.indigo,
              title: Text('MyQuizzes'),
            ),
            body: data.length == 0
                ? Center(
                    child: Text(
                      'No tests here yet.Check back later.',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            MyQuizTileAdmin(quiz: data[index]),
                            Divider(height: 1.0),
                          ],
                        );
                      },
                    ),
                  ),
          );
        }
        return Loading();
      },
    );
  }
}
