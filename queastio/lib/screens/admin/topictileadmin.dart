import 'package:flutter/material.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopicTileAdmin extends StatelessWidget {
  final String topic;

  TopicTileAdmin({this.topic});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        print("hi");
        Navigator.pushNamed(context, QuizListAdminRoute, arguments: topic);
      },
      child: Card(
        child: ListTile(
          title: Text(
            topic,
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
    //                   await Firestore.instance.runTransaction((Transaction myTransaction) async {
    // await myTransaction.delete(snapshot.data.documents[index].reference);
// });
                    }
          ),
          // leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
        ),
      ),
//       child: Material(
// //          color: Colors.indigo,
//           child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 topic,
// //                    style: TextStyle(fontSize: 20.0, color: Colors.white),
//               ),
              
//             ),
//           ],
//         ),
//       )),
    );
  }
}
