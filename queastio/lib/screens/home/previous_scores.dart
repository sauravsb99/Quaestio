import 'package:flutter/material.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/models/score.dart';
import 'package:queastio/shared/loading.dart';

class PreviousScores extends StatefulWidget {
  @override
  _PreviousScoresState createState() => _PreviousScoresState();
}

class _PreviousScoresState extends State<PreviousScores> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context, listen: false);
    return StreamBuilder<List<Score>>(
      stream: DatabaseService(uid: user.uid).getScores(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Score> data = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.indigo,
            appBar: AppBar(
              title: Text('My Scores'),
              backgroundColor: Colors.black26,
            ),
            body: data.length == 0
                ? Center(
                    child: Text(
                    'You have not attempted any tests yet',
                    style: TextStyle(color: Colors.white),
                  ))
                : ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width),
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Container(
                            child: Text('Quiz Name',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            child: Text(
                              'Score',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            child: Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(data.length, (index) {
                        return DataRow(
                          cells: [
                            DataCell(Container(
                              child: Text(
                                data[index].quiz,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            DataCell(Container(
                                child: Text(
                              data[index].score.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))),
                            DataCell(Container(
                                child: Text(
                              data[index].total.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))),
                          ],
                        );
                      }),
                    ),
                  ),
          );
        }
        return Loading();
      },
    );
  }
}
