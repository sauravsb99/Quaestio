import 'package:flutter/material.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/loading.dart';
import 'user_tileAdmin.dart';
import 'sub_tile.dart';

class ListSubmission extends StatefulWidget {
  @override
  _ListSubmissionState createState() => _ListSubmissionState();
}

class _ListSubmissionState extends State<ListSubmission> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserData>>(
        stream: DatabaseService().allUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserData> userList = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('Submissions'),
//                backgroundColor: Colors.indigo,
              ),
              body: userList.length == 0
                  ? Center(child: Text('No users yet.'))
                  : ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return SubTile(user: userList[index]);
                      },
                    ),
            );
          } else {
            return Loading();
          }
        });
  }
}

