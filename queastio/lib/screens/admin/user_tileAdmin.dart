import 'package:flutter/material.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/shared/constants.dart';

class UserTile extends StatelessWidget {
  final UserData user;
  UserTile({this.user});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PrevScoresRoute, arguments: user.uid);
      },
      child: Card(
        child: ListTile(
          title: Text(
            user.name,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
        ),
      ),
    );
  }
}
