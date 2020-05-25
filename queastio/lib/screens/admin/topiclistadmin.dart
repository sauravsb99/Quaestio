import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/screens/admin/topictileadmin.dart';

class TopicListAdmin extends StatefulWidget {
  @override
  _TopicListAdminState createState() => _TopicListAdminState();
}

class _TopicListAdminState extends State<TopicListAdmin> {
  @override
  Widget build(BuildContext context) {
    final topics = Provider.of<List<Topic>>(context);
    // topics.
    // print(topics[0].tid);
    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (context, index) {
        return TopicTileAdmin(topic: topics[index]);
      },
    );
  }
}
