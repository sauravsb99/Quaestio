import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/video/VideoList.dart';
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
          trailing:
          SizedBox(
            width: MediaQuery.of(context).size.width*0.4,
            child: Row(
              children: [Expanded(child: SizedBox(),),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        PageTransition(
                            type: PageTransitionType.downToUp,
                            child: VideoList(user.uid),
                            duration: Duration(milliseconds: 500)));
                  },
//                                          },
                  splashColor: Colors.white,
                  textColor: Colors.white,
                  color: Color(0xff43b77d),
                  child: Text(
                    "Doc",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[700],
                  ),
                  onPressed: () async {
                    // User user = Provider.of<User>(context, listen: false);
                    await DatabaseService().deleteUser(user.uid);
                  },
                ),
              ],
            ),
          ),
          leading: CircleAvatar(backgroundImage: NetworkImage(user.image),backgroundColor: Color(0xff43b77d),),
        ),
      ),
    
    );
  }
}
