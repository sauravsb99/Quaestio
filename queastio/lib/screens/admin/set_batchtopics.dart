import 'package:flutter/material.dart';
import '../../models/batch.dart';
import '../../services/database.dart';
import '../../shared/constants.dart';

class SetBatchTopics extends StatefulWidget {
  final Batch batch;
  final List topics;
  SetBatchTopics({this.batch, this.topics});
  @override
  _SetBatchTopicsState createState() => _SetBatchTopicsState();
}

class _SetBatchTopicsState extends State<SetBatchTopics> {
  List<bool> checkboxes = [];

  @override
  void initState() {
    super.initState();
    widget.topics.forEach((topic) {
      if (widget.batch.topics.contains(topic.name))
        checkboxes.add(true);
      else
        checkboxes.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Topics'), actions: <Widget>[
          FlatButton(
            onPressed: () async {
              List<String> newTopics = [];
              for (var i = 0; i < widget.topics.length; ++i) {
                if (checkboxes[i] == true) {
                  newTopics.add(widget.topics[i].name);
                  await DatabaseService().updateTopicBatches(
                      widget.topics[i].tid, widget.batch.name, "add");
                } else {
                  await DatabaseService().updateTopicBatches(
                      widget.topics[i].tid, widget.batch.name, "remove");
                }
              }
              Batch newBatch = Batch(
                  bid: widget.batch.bid,
                  name: widget.batch.name,
                  topics: newTopics);

              await DatabaseService().updateBatchTopics(newBatch);
              Navigator.pop(context, {'batch': newBatch});
            },
            child: Text('Save', style: buttonText),
          )
        ]),
        body: ListView.builder(
            itemCount: widget.topics.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                  value: checkboxes[index],
                  onChanged: (value) {
                    setState(() {
                      checkboxes[index] = value;
                    });
                  },
                  title: Text(widget.topics[index].name));
            }));
  }
}
