import 'package:flutter/material.dart';
import 'package:queastio/models/topic.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;
  TopicTile({this.topic});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           CircleAvatar(
//             radius: 40.0,
//             backgroundImage: NetworkImage(topic.image),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Text(
//               topic.name,
//               style: TextStyle(
//                 fontSize: 20.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            // backgroundColor: Colors.brown[topic.],
          ),
          title: Text(topic.name),
          // subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}