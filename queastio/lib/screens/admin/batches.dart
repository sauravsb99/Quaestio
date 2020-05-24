import 'package:flutter/material.dart';
import 'package:queastio/models/batch.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/loading.dart';

import '../../shared/constants.dart';

class Batches extends StatefulWidget {
  @override
  _BatchesState createState() => _BatchesState();
}

class _BatchesState extends State<Batches> {
  final _formKey = GlobalKey<FormState>();
  String _batchName;
  @override
  Widget build(BuildContext context) {
    void _addBatch() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Enter the batch name: '),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a Batch name' : null,
                      onChanged: (val) => setState(() => _batchName = val),
                    ),
                    RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await DatabaseService()
                            .addBatch(_batchName)
                            .then((result) {
                          Navigator.pop(context);
                        });
                      },
                    )
                  ],
                ),
              ),
            );
          });
    }

    return StreamBuilder<List<Batch>>(
        stream: DatabaseService().batches,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Batch> batchList = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('Batches'),
//                backgroundColor: Colors.indigo,
              ),
              body: batchList.length == 0
                  ? Center(child: Text('No users yet.'))
                  : ListView.builder(
                      itemCount: batchList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, BatchTopicsRoute,
                                arguments: batchList[index]);
                          },
                          title: Text(batchList[index].name),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[800]),
                            onPressed: () async {
                              await DatabaseService()
                                  .deleteBatch(batchList[index].bid);
                            },
                          ),
                        );
                      },
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: _addBatch,
                child: Icon(Icons.add),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
