import 'package:queastio/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/screens/profileScreen/Userput.dart';
import 'package:queastio/services/database.dart';



class UserGet extends StatefulWidget {
  @override
  _UserGetState createState() => _UserGetState();
}

class _UserGetState extends State<UserGet> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    // topics.forEach((topic) {
    //   print(topic.name);
    //   print(topic.image);
    // });

    return StreamBuilder<UserData>(
      stream: DatabaseService().userData,
//      itemB
      builder: (context, user) {
        return Userput(user: userData);
      },
    );

  }
}

//
//User user = Provider.of<User>(context);
//return
//// ignore: missing_return
//builder: (context, snapshot)