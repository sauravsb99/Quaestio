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
    return StreamBuilder<UserData>(
      stream: DatabaseService().userData,
      builder: (context, user) {
        return Userput(user: userData);
      },
    );

  }
}