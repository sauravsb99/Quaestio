import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:queastio/services/database.dart';
import 'package:queastio/models/score.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/shared/loading.dart';
import 'package:queastio/shared/nothing_here.dart';

class PreviousScores extends StatefulWidget {
  final Widget child;
  final String uid;
  PreviousScores({Key key, this.child, this.uid}) : super(key: key);
  @override
  _PreviousScoresState createState() => _PreviousScoresState();
}

class _PreviousScoresState extends State<PreviousScores> {
  List<charts.Series<Score, DateTime>> _seriesLineData;
  String topic = 'All';
  Set<String> items;
  _generateData(data) {
    _seriesLineData = List<charts.Series<Score, DateTime>>();
    _seriesLineData.add(charts.Series(
      domainFn: (Score data, _) => data.time.toDate(),
      measureFn: (Score data, _) => (data.score) / data.total * 100,
      colorFn: (Score data, _) => charts.Color.fromHex(code: '#43b77d'),
      data: data,
      labelAccessorFn: (Score row, _) => "${row.time}",
      id: "Growth Chart",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Score>>(
        stream: DatabaseService(uid: widget.uid).getScores(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Score> scores = snapshot.data;
            _seriesLineData = List<charts.Series<Score, DateTime>>();
            topic = topic == null ? 'All' : topic;
            items = Set.from(['All']);
            scores.forEach((element) {
              print(element.qTopic);
              items.add(element.qTopic);
            });
            List<Score> topicScores = scores;
            if (topic != 'All') {
              topicScores =
                  scores.where((score) => score.qTopic == topic).toList();
            }
            _generateData(topicScores);
            return scores.length != 0
                ? Scaffold(
                    body: MaterialApp(
                      home: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          appBar: AppBar(
                            title: Text("My Scores"),
                            backgroundColor: Color(0xff43b77d),
                            bottom: TabBar(
                              indicatorColor: Color(0xff43b77d),
                              tabs: [
                                Tab(icon: Icon(Icons.table_chart)),
                                Tab(icon: Icon(Icons.show_chart)),
                              ],
                            ),
                          ),
                          body: TabBarView(
                            children: [
                              Container(
                                color: Colors.black,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth:
                                          MediaQuery.of(context).size.width),
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
                                            'LeaderBoard',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(scores.length, (index) {
                                      return DataRow(
                                        cells: [
                                          DataCell(Container(
                                            child: Text(
                                              scores[index].quiz.toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
                                          DataCell(Container(
                                              child: Text(
                                            (100 *
                                                        (scores[index].score /
                                                            scores[index]
                                                                .total))
                                                    .toStringAsFixed(2) +
                                                '%',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ))),
                                          DataCell(Container(
                                              child: IconButton(
                                            icon:
                                                Image.asset('assets/lead.png'),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, LeaderRoute,
                                                  arguments: {
                                                    'qname': scores[index].quiz,
                                                    'qtopic':
                                                        scores[index].qTopic
                                                  });
                                            },
                                          )))
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
//                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Past Performance',
                                                style: TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        DropdownButton<String>(
                                          value: topic,
                                          underline: Container(
                                            color: Color(0xff43b77d),
                                            height: 2.0,
                                          ),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              topic = newValue;
                                            });
                                          },
                                          items: items.map((item) {
                                            return DropdownMenuItem(
                                                value: item, child: Text(item));
                                          }).toList(),
                                        ),
                                        Expanded(
                                          child: charts.TimeSeriesChart(
                                              _seriesLineData,
                                              defaultRenderer:
                                                  new charts.LineRendererConfig(
                                                      includeArea: true,
                                                      stacked: true),
                                              animate: true,
                                              animationDuration:
                                                  Duration(seconds: 2),
                                              behaviors: [
                                                new charts.ChartTitle('Score',
                                                    behaviorPosition: charts
                                                        .BehaviorPosition.start,
                                                    titleOutsideJustification:
                                                        charts
                                                            .OutsideJustification
                                                            .middleDrawArea),
                                              ]),
                                        ),
                                        SizedBox(
                                            height: 50,
                                            child: Text(
                                              "Time",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : NothingHere(
                    title: 'My Scores', text: 'No tests attempted yet');
          } else {
            return Loading();
          }
        });
  }
}
