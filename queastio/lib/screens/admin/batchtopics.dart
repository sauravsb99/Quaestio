import 'package:flutter/material.dart';

import '../../models/batch.dart';
import '../../models/topic.dart';
import '../../services/database.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';
import 'topictileadmin.dart';

class BatchTopics extends StatefulWidget {
  Batch batch;
  BatchTopics({this.batch});
  @override
  _BatchTopicsState createState() => _BatchTopicsState();
}

class _BatchTopicsState extends State<BatchTopics> {
  bool reload = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Topic>>(
      stream: DatabaseService().topics,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Topic> topics = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Topics'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    dynamic data = await Navigator.pushNamed(
                        context, SetBatchTopicsRoute,
                        arguments: {
                          'batch': widget.batch,
                          'topics': topics,
                        });
                    setState(() {
                      if(data['batch']!=Null)
                      widget.batch = data['batch'];
                    });
                  },
                )
              ],
            ),
            body: widget.batch.topics.length == 0
                ? Center(
                    child: Text('No topics yet'),
                  )
                : ListView.builder(
                    itemCount: widget.batch.topics.length,
                    itemBuilder: (context, index) {
                      return TopicTileAdmin(topic: widget.batch.topics[index]);
                    },
                  ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
