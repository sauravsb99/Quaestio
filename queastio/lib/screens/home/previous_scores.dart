//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:queastio/services/database.dart';
import 'package:queastio/models/score.dart';

class PreviousScores extends StatefulWidget {
  final Widget child;
  final String uid;
  PreviousScores({Key key, this.child, this.uid}) : super(key: key);
  @override
  _PreviousScoresState createState() => _PreviousScoresState(uid: uid);
}

class _PreviousScoresState extends State<PreviousScores> {
  List<charts.Series<Score, DateTime>> _seriesLineData;
  final String uid;
  String topic = 'All';
  _PreviousScoresState({this.uid, this.topic});
//  List<Score> mydata;

  _generateData(data) {
    _seriesLineData = List<charts.Series<Score, DateTime>>();

//    User user;
    _seriesLineData.add(charts.Series(
      domainFn: (Score data, _) => data.time.toDate(),
//                                        user.timestamp.seconds,

      measureFn: (Score data, _) => (data.score) / data.total * 100,
      colorFn: (Score data, _) => getcolor(data.qTopic),
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
        stream: DatabaseService(uid: uid).getScores(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Score> data = snapshot.data;

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
                      backgroundColor: Colors.indigoAccent,
                      bottom: TabBar(
                        indicatorColor: Color(0xff9962D0),
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
//                                        Flexible(
//                                          child: ListView.builder(
//                                              itemCount: question['options'].length,
//                                              itemBuilder: (context, ind) {
//                                                return RadioListTile<String>(
//                                                  title: Text(question['options'][ind]),
//                                                  value: question['options'][ind],
//                                                  groupValue: selectedOptions[index],
//                                                  activeColor: Colors.indigo,
//                                                  onChanged: (value) {
//                                                    setState(() {
//                                                      selectedOptions[index] = value;
//                                                      print(selectedOptions[index]);
//                                                    });
//                                                  },
//                                                );
//                                              }),
//                                        ),
                                  Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      spacing: 20.0,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text('All'),
                                            Radio(
                                                value: 'All',
                                                groupValue: topic,
                                                onChanged: (value) {
                                                  setState(() {
                                                    topic = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Maths'),
                                            Radio(
                                                value: 'Maths',
                                                groupValue: topic,
                                                onChanged: (value) {
                                                  setState(() {
                                                    topic = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Aptitude'),
                                            Radio(
                                                value: 'Aptitude',
                                                groupValue: topic,
                                                onChanged: (value) {
                                                  setState(() {
                                                    topic = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Chemistry'),
                                            Radio(
                                                value: 'Chemistry',
                                                groupValue: topic,
                                                onChanged: (value) {
                                                  setState(() {
                                                    topic = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Computer'),
                                            Radio(
                                                value: 'Computer',
                                                groupValue: topic,
                                                onChanged: (value) {
                                                  setState(() {
                                                    topic = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Physics'),
                                            Radio(
                                                value: 'Physics',
                                                groupValue: topic,
                                                onChanged: (value) {
                                                  setState(() {
                                                    topic = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('English'),
                                            Radio(
                                                value: 'English',
                                                groupValue: topic,
                                                onChanged: (value) {
                                                  setState(() {
                                                    topic = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Biology'),
                                            Radio(
                                                value: 'Biology',
                                                groupValue: topic,
                                                onChanged: (value) {
                                                  setState(() {
                                                    topic = value;
                                                  });
                                                }),
                                          ],
                                        ),
                                      ]),
                                  StreamBuilder<List<Score>>(
                                      stream: DatabaseService(uid: uid)
                                          .getTopicScores(topic),
                                      // ignore: missing_return
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<Score> datas = snapshot.data;

//                                            _generateData(datas);
                                          datagen(topic, data, datas);
                                          return Expanded(
//                                              height: MediaQuery.of(context).size.height*0.60,
//                                              width: MediaQuery.of(context).size.width*0.50,
                                            child: charts.TimeSeriesChart(
                                                _seriesLineData,
                                                defaultRenderer: new charts
                                                        .LineRendererConfig(
                                                    includeArea: true,
                                                    stacked: true),
                                                animate: true,
                                                animationDuration:
                                                    Duration(seconds: 5),
                                                behaviors: [
                                                  new charts.ChartTitle('Score',
                                                      behaviorPosition: charts
                                                          .BehaviorPosition
                                                          .start,
                                                      titleOutsideJustification:
                                                          charts
                                                              .OutsideJustification
                                                              .middleDrawArea),
                                                ]),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                  SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
              backgroundColor: Colors.indigo,
              appBar: AppBar(
                title: Text('My Scores'),
                backgroundColor: Colors.black,
              ),
              body: Center(
                child: Text(
                  'You have not attempted any tests yet',
                  style: TextStyle(color: Colors.white),
                ),
              ));
        });
  }

  datagen(topic, data, datas) {
    switch (topic) {
      case 'All':
        return _generateData(data);
        break;
      default:
        return _generateData(datas);
        break;
    }
  }

  getcolor(qTopic) {
    switch (qTopic) {
      case 'Aptitude':
        return charts.Color.fromHex(code: '#438786');
        break;
      case 'Maths':
        return charts.Color.fromHex(code: '#532234');
        break;
      case 'Biology':
        return charts.Color.fromHex(code: '#937219');
        break;
      case 'Computer':
        return charts.Color.fromHex(code: '#374182');
        break;
      case 'Physics':
        return charts.Color.fromHex(code: '#437264');
        break;
      case 'Chemistry':
        return charts.Color.fromHex(code: '#725373');
        break;
      default:
        return charts.Color.fromHex(code: '#261262');
        break;
    }
  }
}
