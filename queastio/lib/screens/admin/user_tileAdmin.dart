import 'package:flutter/material.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/services/database.dart';

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
          trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                    onPressed: () async {
                      // User user = Provider.of<User>(context, listen: false);
                      await DatabaseService().deleteUser(user.uid);
                    },
          ),
          leading: CircleAvatar(backgroundImage: NetworkImage(user.image),backgroundColor: Color(0xff43b77d),),
        ),
      ),
    
    );
  }
}
