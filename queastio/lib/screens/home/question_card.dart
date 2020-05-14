import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/services/scoring.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/shared/loading.dart';
import 'package:quiver/async.dart';

class QuestionCard extends StatefulWidget {
  final Map quiz;
  QuestionCard({this.quiz});
  @override
  _QuestionCardState createState() => _QuestionCardState(quiz: quiz);
}

class _QuestionCardState extends State<QuestionCard> {
  final Map quiz;
  _QuestionCardState({this.quiz});
  int index = 0;
  bool _isPrevButtonDisabled;
  bool _isNextButtonDisabled;
  Duration d;
  String time = '';
  User user;
  UserData userData;
  CountdownTimer c;
  var sub;
  _convertToTwoDigit(int n) {
    if (n < 10) return '0' + n.toString();
    return n.toString();
  }

  Future<void> calcScore() async {
    sub.cancel();
    Scoring instance =
        Scoring(answers: quiz['answers'], selected: selectedOptions);
    int score = instance.getScore();
    print('Score:' + score.toString());
    if (quiz['firstTime']) {
      DateTime time = DateTime.now();
      await DatabaseService(uid: user.uid).insertScore(userData.name,
          quiz['qname'], quiz['qTopic'], score, quiz['answers'].length, time);
    }
    _showMyDialog(score, quiz['answers'].length);
  }

  void startTimer() {
    c = CountdownTimer(
      Duration(minutes: quiz['duration']),
      Duration(seconds: 1),
    );
    sub = c.listen(null);
    sub.onData((duration) {
      setState(() {
        d = d - Duration(seconds: 1);
        time = _convertToTwoDigit(d.inMinutes.remainder(60)) +
            ':' +
            _convertToTwoDigit(d.inSeconds.remainder(60));
      });
    });
    sub.onDone(() {
      calcScore();
    });
  }

  Future<void> _showMyDialog(int score, int total) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Column(children: <Widget>[
              Text(
                'You have scored',
              ),
              SizedBox(height: 20.0),
              Text(
                score.toString(),
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
              Divider(
                thickness: 5.0,
                indent: 75.0,
                endIndent: 75.0,
                color: Colors.indigo[900],
              ),
              Text(
                total.toString(),
                style: TextStyle(
                  fontSize: 50.0,
                ),
              )
            ]),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                color: Colors.indigo,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomeViewRoute);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void initState() {
    index = 0;
    _isPrevButtonDisabled = true;
    _isNextButtonDisabled = false;
    d = new Duration(minutes: quiz['duration']);
    startTimer();
  }

  List<String> selectedOptions;
  @override
  Widget build(BuildContext context) {
    final List questions = quiz['questions'];
    Map question = Map.from(questions[index]);

    selectedOptions =
        selectedOptions == null ? new List(questions.length) : selectedOptions;
    setState(() {
      _isPrevButtonDisabled = index == 0;
    });
    setState(() {
      _isNextButtonDisabled = index == questions.length - 1;
    });
    user = Provider.of<User>(context, listen: false);

    return WillPopScope(
      onWillPop: () async => false,
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              userData = snapshot.data;
              return Material(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(8.0),
                              color: Colors.indigo,
                              child: Text(
                                'Time Left: ' + time,
                                style: buttonText,
                              )),
                          FlatButton(
                            padding: EdgeInsets.all(8.0),
                            onPressed:
                                selectedOptions == null ? null : calcScore,
                            child: Text('Submit Test', style: buttonText),
                            color: Colors.indigo,
                          ),
                        ],
                      ),
                      question['qType'] == 'Text'
                          ? Text(
                              (index + 1).toString() + '. ' + question['qText'],
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            )
                          : Wrap(
                              children: <Widget>[
                                Text(
                                  (index + 1).toString() + '. ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                Image.network(question['qImage']),
                              ],
                            ),
                      Divider(
                        height: 30.0,
                        color: Colors.grey,
                      ),
                      RadioListTile<String>(
                        title: Text(question['options'][0]),
                        value: question['options'][0],
                        groupValue: selectedOptions[index],
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value;
                            print(selectedOptions[index]);
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(question['options'][1]),
                        value: question['options'][1],
                        groupValue: selectedOptions[index],
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value;
                            print(selectedOptions[index]);
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(question['options'][2]),
                        value: question['options'][2],
                        groupValue: selectedOptions[index],
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value;
                            print(selectedOptions[index]);
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(question['options'][3]),
                        value: question['options'][3],
                        groupValue: selectedOptions[index],
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            selectedOptions[index] = value;
                            print(selectedOptions[index]);
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            color: Colors.indigo,
                            disabledColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_left,
                              size: 50.0,
                            ),
                            onPressed: _isPrevButtonDisabled
                                ? null
                                : () {
                                    setState(() {
                                      index -= 1;
                                      print(index);
                                    });
                                  },
                          ),
                          IconButton(
                            color: Colors.indigo,
                            disabledColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_right,
                              size: 50.0,
                            ),
                            onPressed: _isNextButtonDisabled
                                ? null
                                : () {
                                    setState(() {
                                      index += 1;
                                      print(index);
                                    });
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
