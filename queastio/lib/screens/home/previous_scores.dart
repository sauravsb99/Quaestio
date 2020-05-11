import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/models/score.dart';
import 'package:date_format/date_format.dart';

class PreviousScores extends StatefulWidget {
  final Widget child;

  PreviousScores({Key key, this.child}) : super(key: key);
@override
  _PreviousScoresState createState() => _PreviousScoresState();
}

class _PreviousScoresState extends State<PreviousScores> {


  List<charts.Series<Score, DateTime>> _seriesLineData;
  List<Score> mydata;

  _generateData (
      mydata
      ){
    _seriesLineData = List<charts.Series<Score, DateTime>>(
    );

    User user;
    _seriesLineData.add(
        charts.Series(
          domainFn: ( Score score, _ )=> gettime(score.time),
//                                        user.timestamp.seconds,

          measureFn: (
              Score score, _
              )=>
          (
              score.score
          ) / score.total * 100,
//          colorFn: (
//              Score score, _
//              )=>
//              getcolor(
//                  score.qTopic
//              ),
//        colorFn:
//        id:
          data: mydata,

          labelAccessorFn: (
              Score row, _
              )=> "${row.qTopic}",
          id: "Growth Chart",
        )
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Tasks')),
//      body: _buildBody(context),
//    );
//  }

  @override
  Widget build (
      BuildContext context
      ){
    final User user = Provider.of<User>(
        context, listen: false
    );
    return StreamBuilder<List<Score>>(
        stream: DatabaseService(
            uid: user.uid
        ).getScores(
        ),
        // ignore: missing_return
        builder: (
            context, snapshot
            ){
          if ( snapshot.hasData ) {
            List<Score> data = snapshot.data;
            List<Score> score = snapshot.data;
//      var i=0;
//      for(i=0; i<=score.length;i++){
//      _generateData(score[i]);}

//            void initState() {
            // TODO: implement initState
//              super.initState();
            _seriesLineData = List<charts.Series<Score, DateTime>>(
            );
//              List.generate(score, index){
            _generateData(
                score
            );
////            }
            return Scaffold(
              backgroundColor: Colors.indigo,
              appBar: AppBar(
                title: Text(
                    'My Scores'
                ),
                backgroundColor: Colors.black,
              ),
              body: data.length == 0
                  ? Center(
                  child: Text(
                    'You have not attempted any tests yet',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              )
                  : MaterialApp(
                home: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color(
                          0xff1976d2
                      ),
                      bottom: TabBar(
                        indicatorColor: Color(
                            0xff9962D0
                        ),
                        tabs: [
                          Tab(
                              icon: Icon(
                                  Icons.table_chart
                              )
                          ),
                          Tab(
                              icon: Icon(
                                  Icons.line_style
                              )
                          ),
                        ],
                      ),

                    ),
                    body: TabBarView(
                      children: [Container(
                        color: Colors.black,
                        child: ConstrainedBox(

                          constraints: BoxConstraints(
                              minWidth: MediaQuery
                                  .of(
                                  context
                              )
                                  .size
                                  .width
                          ),
                          child: DataTable(
                            columns: [
                              DataColumn(
                                label: Container(
                                  child: Text(
                                      'Quiz Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )
                                  ),
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
                            rows: List.generate(
                                data.length, (
                                index
                                ){
                              return DataRow(
                                cells: [
                                  DataCell(
                                      Container(
                                        child: Text(
                                          data[index].quiz,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                  ),
                                  DataCell(
                                      Container(
                                          child: Text(
                                            data[index].score.toString(
                                            ),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                      )
                                  ),
                                  DataCell(
                                      Container(
                                          child: Text(
                                            data[index].total.toString(
                                            ),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              );
                            }
                            ),
                          ),
                        ),
                      ),
//                  ),
                        Padding(
                          padding: EdgeInsets.all(
                              8.0
                          ),
                          child: Container(
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Score for the first 5 years',
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Expanded(
                                    child:charts.TimeSeriesChart(
                                        _seriesLineData,
                                        defaultRenderer: new charts
                                            .LineRendererConfig(
                                            includeArea: true, stacked: true
                                        ),
                                        animate: true,
                                        animationDuration: Duration(
                                            seconds: 5
                                        ),
                                        behaviors: [
                                          new charts.ChartTitle(
                                              'Score',
                                              behaviorPosition: charts
                                                  .BehaviorPosition.start,
                                              titleOutsideJustification: charts
                                                  .OutsideJustification
                                                  .middleDrawArea
                                          ),
                                        ]
                                    ),
//                                  )



//                                    charts.LineChart(
//                                        _seriesLineData,
//                                        defaultRenderer: new charts
//                                            .LineRendererConfig(
//                                            includeArea: true, stacked: true
//                                        ),
//                                        animate: true,
//                                        animationDuration: Duration(
//                                            seconds: 5
//                                        ),
//                                        behaviors: [
//                                          new charts.ChartTitle(
//                                              'Score',
//                                              behaviorPosition: charts
//                                                  .BehaviorPosition.start,
//                                              titleOutsideJustification: charts
//                                                  .OutsideJustification
//                                                  .middleDrawArea
//                                          ),
//                                        ]
//                                    ),
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
        }
    );
  }

//  getcolor (qTopic){
//    switch (qTopic) {
//      case 'Aptitude':return charts.Color().rgbaHexString.'96566';
//        break;
//      default:return charts.Color().rgbaHexString;
//        break;
//    }
//  }

  gettime(Timestamp time) {
    return time.toDate() ;
  }
}