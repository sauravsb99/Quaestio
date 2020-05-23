//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:queastio/models/topic.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/models/score.dart';
import 'package:queastio/shared/loading.dart';

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
//  List<Score> mydata;

  _generateData(data) {
    _seriesLineData = List<charts.Series<Score, DateTime>>();

//    User user;
    _seriesLineData.add(charts.Series(
      domainFn: (Score data, _) => data.time.toDate(),
//                                        user.timestamp.seconds,

      measureFn: (Score data, _) => (data.score) / data.total * 100,
      colorFn: (Score data, _) => charts.Color.fromHex(code: '#43b77d'),
//        colorFn:
//        id:
      data: data,

      labelAccessorFn: (Score row, _) => "${row.time}",
      id: "Growth Chart",
//          fillPatternFn:
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Score>>(
        stream: DatabaseService(uid: widget.uid).getScores(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Score> scores = snapshot.data;

//            List<Score> score = snapshot.data;
//      var i=0;
//      for(i=0; i<=score.length;i++){
//      _generateData(score[i]);}

//            void initState() {
            // TODO: implement initState
//              super.initState();
            _seriesLineData = List<charts.Series<Score, DateTime>>();
//              List.generate(score, index){
////            }
            topic = topic == null ? 'All' : topic;
            items = Set.from(['All']);
            scores.forEach((element) {
              items.add(element.qTopic);
            });
            List<Score> topicScores = scores;
            if (topic != 'All') {
              topicScores =
                  scores.where((score) => score.qTopic == topic).toList();
            }
            _generateData(topicScores);
            return Scaffold(
//              backgroundColor: Colors.indigo,
//              appBar: AppBar(
//                title: Text(
//                    'My Scores'
//                ),
//                backgroundColor: Colors.black,
//              ),
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
                          Tab(icon: Icon(Icons.line_style)),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        Container(
                          color: Colors.black,
                          child: ConstrainedBox(
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
                                // DataColumn(
                                //   label: Container(
                                //     child: Text(
                                //       'Total',
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                              rows: List.generate(scores.length, (index) {
                                return DataRow(
                                  cells: [
                                    DataCell(Container(
                                      child: Text(
                                        scores[index].quiz,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                                    DataCell(Container(
                                        child: Text(
                                      (100 *
                                                  (scores[index].score /
                                                      scores[index].total))
                                              .toStringAsFixed(2) +
                                          '%',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ))),
                                    // DataCell(Container(
                                    //     child: Text(
                                    //   data[index].total.toString(),
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //   ),
                                    // ))),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
//                  ),
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
                                              fontWeight: FontWeight.bold),
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
//                                              height: MediaQuery.of(context).size.height*0.60,
//                                              width: MediaQuery.of(context).size.width*0.50,
                                    child: charts.TimeSeriesChart(
                                        _seriesLineData,
                                        defaultRenderer:
                                            new charts.LineRendererConfig(
                                                includeArea: true,
                                                stacked: true),
                                        animate: true,
                                        animationDuration: Duration(seconds: 2),
                                        behaviors: [
                                          new charts.ChartTitle('Score',
                                              behaviorPosition:
                                                  charts.BehaviorPosition.start,
                                              titleOutsideJustification: charts
                                                  .OutsideJustification
                                                  .middleDrawArea),
                                        ]),
                                  ),
//                                           StreamBuilder<List<Score>>(
//                                               stream: DatabaseService(uid: uid)
//                                                   .getTopicScores(topic),
//                                               // ignore: missing_return
//                                               builder: (context, snapshot) {
//                                                 if (snapshot.hasData) {
//                                                   List<Score> datas =
//                                                       snapshot.data;

// //                                            _generateData(datas);

//                                                 } else {
//                                                   return Container();
//                                                 }
//                                               }),
                                  SizedBox(
                                    height: 50,
                                  )
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
            );
          }
          return Scaffold(
              backgroundColor: Color(0xff43bfdd),
              appBar: AppBar(
                title: Text('My Scores'),
                backgroundColor: Colors.black,
              ),
              body: Center(
                child: Text(
                  'No tests attempted yet',
                  style: TextStyle(color: Colors.white),
                ),
              ));
        });
  }
}
