import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/services/scoring.dart';
import 'package:queastio/models/user.dart';

class QuestionCard extends StatefulWidget {
  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int index = 0;
  bool _isPrevButtonDisabled;
  bool _isNextButtonDisabled;
  final AuthService _auth = AuthService();

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
                  Navigator.pushReplacementNamed(context, '/');
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
  }

  List<String> selectedOptions;
  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context).settings.arguments;
    final List questions = args['questions'];
    final List answers = args['answers'];
    final String qid = args['qid'];
    Map question = Map.from(questions[index]);
    selectedOptions =
        selectedOptions == null ? new List(questions.length) : selectedOptions;
    setState(() {
      _isPrevButtonDisabled = index == 0;
    });
    setState(() {
      _isNextButtonDisabled = index == questions.length - 1;
    });
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                FlatButton(
                  padding: EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  onPressed: selectedOptions == null
                      ? null
                      : () async {
                          Scoring instance = Scoring(
                              answers: answers, selected: selectedOptions);
                          int score = instance.getScore();
                          print('Score:' + score.toString());
                          User user = Provider.of<User>(context, listen: false);
                          await DatabaseService(uid: user.uid)
                              .insertScore(qid, score, answers.length);
                          _showMyDialog(score, answers.length);
                        },
                  child: Text('Submit Test'),
                  color: Colors.indigo,
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
            )
          ],
        ),
      ),
    );
  }
}
