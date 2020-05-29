import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/services/scoring.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/shared/constants.dart';
import 'package:queastio/shared/loading.dart';
import 'package:quiver/async.dart';
import 'package:http/http.dart' as http;
// import 'package:auto_size_text/auto_size_text.dart';

class QuestionCard extends StatefulWidget {
  final Map quiz;
  QuestionCard({this.quiz});
  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard>
    with SingleTickerProviderStateMixin {
  int index = 0;
  bool _isPrevButtonDisabled;
  bool _isNextButtonDisabled;
  Duration d;
  String time = '';
  User user;
  UserData userData;
  CountdownTimer c;
  List questions;
  var sub;
  _convertToTwoDigit(int n) {
    if (n < 10) return '0' + n.toString();
    return n.toString();
  }

  Future<bool> checkConnectivity() async {
    try {
      var response = await http.get('https://www.google.com');
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<void> calcScore() async {
    sub.cancel();
    Scoring instance = Scoring(questions: questions, selected: selectedOptions);
    int score = instance.getScore();
    print('Score:' + score.toString());
    if (userData.role == "user" && widget.quiz['firstTime']) {
      DateTime time = DateTime.now();
      bool isNetConnected = await checkConnectivity();
      if (isNetConnected)
        print('Hi');
      else
        print('NO');
      await DatabaseService(uid: user.uid).insertScore(
          userData.name,
          widget.quiz['qname'],
          widget.quiz['qId'],
          widget.quiz['qTopic'],
          score,
          widget.quiz['answers'].length,
          time);
    }
    _showMyDialog(score, widget.quiz['answers'].length);
  }

  void startTimer() {
    c = CountdownTimer(
      Duration(minutes: widget.quiz['duration']),
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
                (100 * (score / total)).toInt().toString() + '%',
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
            ]),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, AnswerSheetRoute, arguments: {
                    'questions': questions,
                    'selected': selectedOptions
                  });
                },
                textColor: Colors.indigo,
                child: Text(
                  'Answers',
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeViewRoute, (route) => false);
                },
                textColor: Colors.indigo,
                child: Text(
                  'Home',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    index = 0;
    _isPrevButtonDisabled = true;
    _isNextButtonDisabled = false;
    buttonPressed = false;
    questions = widget.quiz['questions'];
    questions.forEach((element) {
      element['options'].shuffle();
    });
    questions.shuffle();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    d = new Duration(minutes: widget.quiz['duration']);
    startTimer();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleClick() {
    buttonPressed = !buttonPressed;
    if (buttonPressed)
      _animationController.forward();
    else
      _animationController.reverse();
  }

  AnimationController _animationController;
  Animation shapeAnimation;
  bool buttonPressed;
  List<String> selectedOptions;
  @override
  Widget build(BuildContext context) {
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
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Center(
                            //   child: Container(
                            //     padding: EdgeInsets.all(8.0),
                            //     decoration: BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.black,
                            //     ),
                            //     child: Text(
                            //       (index + 1).toString(),
                            //       style: buttonText,
                            //     ),
                            //   ),
                            // ),
                            Flexible(
                              flex: 2,
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  child: question['qType'] == 'Text'
                                      ? Text(
                                          (index + 1).toString() +
                                              '. ' +
                                              question['qText'],
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
                                            Image.network(question['qText']),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 5.0,
                              color: Colors.grey,
                            ),
                            Flexible(
                              flex: 2,
                              child: Scrollbar(
                                child: ListView.builder(
                                    itemCount: question['options'].length,
                                    itemBuilder: (context, ind) {
                                      return RadioListTile<String>(
                                        title: Text(question['options'][ind]),
                                        value: question['options'][ind],
                                        groupValue: selectedOptions[index],
                                        activeColor: Color(0xff43b77d),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedOptions[index] = value;
                                            print(selectedOptions[index]);
                                          });
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                color: Color(0xff43b77d),
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
                                        if (buttonPressed) _handleClick();
                                      },
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  _handleClick();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                // child: buttonPressed == false
                                //     ? Icon(Icons.query_builder)
                                //     : Icon(Icons.close),
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.menu_close,
                                  progress: _animationController,
                                ),
                                backgroundColor: Color(0xff43b77d),
                              ),
                              _isNextButtonDisabled
                                  ? IconButton(
                                      // padding: EdgeInsets.all(8.0),
                                      icon: Icon(
                                        Icons.done,
                                        size: 40.0,
                                      ),
                                      // shape: RoundedRectangleBorder(
                                      //   side: BorderSide(color: Colors.white),
                                      // ),
                                      onPressed: selectedOptions == null
                                          ? null
                                          : calcScore,
                                      // child: Text('Submit', style: buttonText),
                                      color: Color(0xff43b77d),
                                    )
                                  : IconButton(
                                      color: Color(0xff43b77d),
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
                                              if (buttonPressed) _handleClick();
                                            },
                                    )
                            ],
                          ),
                          alignment: Alignment.bottomCenter,
                        ),
                        Column(
                          children: <Widget>[
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: buttonPressed == true ? 1 : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  color: Color(0xff43b77d),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xff43b77d),
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Text(
                                          'Time Left: ' + time,
                                          style: buttonText,
                                        )),
                                    FlatButton(
                                      padding: EdgeInsets.all(8.0),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.white),
                                      ),
                                      onPressed: selectedOptions == null
                                          ? null
                                          : calcScore,
                                      child: Text('Submit Test',
                                          style: buttonText),
                                      color: Color(0xff43b77d),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
