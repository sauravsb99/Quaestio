import 'package:flutter/material.dart';
import 'package:queastio/models/user.dart';
import 'user_tileAdmin.dart';
import 'package:queastio/services/database.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserData>>(
        stream: DatabaseService().allUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserData> userList = snapshot.data;
            return Scaffold(
                appBar: AppBar(title: Text('Users')),
                body: userList.length == 0
                    ? Center(child: Text('No users yet.'))
                    : ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return UserTile(user: userList[index]);
                        },
                      ));
          }
        });
  }
}
