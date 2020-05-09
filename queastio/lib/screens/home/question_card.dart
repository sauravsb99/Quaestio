import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/scoring.dart';

class QuestionCard extends StatefulWidget {
  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int index = 0;
  bool _isPrevButtonDisabled;
  bool _isNextButtonDisabled;

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
              activeColor: Colors.green,
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
              activeColor: Colors.green,
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
              activeColor: Colors.green,
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
              activeColor: Colors.green,
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
                  color: Colors.green,
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
                      : () {
                          Scoring instance = Scoring(
                              answers: answers, selected: selectedOptions);
                          int score = instance.getScore();
                          print('Score:' + score.toString());
                        },
                  child: Text('Submit Test'),
                  color: Colors.green,
                ),
                IconButton(
                  color: Colors.green,
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
