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
  _PreviousScoresState({this.uid});
//  List<Score> mydata;

  _generateData(data) {
    _seriesLineData = List<charts.Series<Score, DateTime>>();

//    User user;
    _seriesLineData.add(charts.Series(
      domainFn: (Score data, _) => data.time.toDate(),
//                                        user.timestamp.seconds,

      measureFn: (Score data, _) => (data.score) / data.total * 100,
      colorFn: (Score data, _) => getcolor(data.quiz),
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
        // ignore: missing_return
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
            _generateData(data);
////            }
            return Scaffold(
//              backgroundColor: Colors.indigo,
//              appBar: AppBar(
//                title: Text(
//                    'My Scores'
//                ),
//                backgroundColor: Colors.black,
//              ),
              body: data.length == 0
                  ? Center(
                      child: Text(
                      'You have not attempted any tests yet',
                      style: TextStyle(color: Colors.white),
                    ))
                  : MaterialApp(
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
                                        Text(
                                          'Your Past Performance',
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold),
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
                                                  Duration(seconds: 5),
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
        });
  }

  getcolor(quiz) {
    switch (quiz) {
      case 'quiz1':
        return charts.Color.fromHex(code: '#438786');
        break;
      case 'Permutation and Combination I':
        return charts.Color.fromHex(code: '#000000');
        break;
      default:
        return charts.Color.fromHex(code: '#261262');
        break;
    }
  }
}
