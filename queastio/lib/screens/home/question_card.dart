import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final List questions = ModalRoute.of(context).settings.arguments;
    Map question = Map.from(questions[index]);
    List<String> selectedOptions = new List(questions.length);
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
                      fontSize: 20.0,
                    ),
                  )
                : Wrap(
                    children: <Widget>[
                      Text(
                        (index + 1).toString() + '. ',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Image.network(question['qImage']),
                    ],
                  ),
            Divider(
              height: 30.0,
              color: Colors.grey,
            ),
            Row(
              children: <Widget>[
                Text(
                  'A. ',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Radio(
                  value: question['options'][0],
                  groupValue: selectedOptions[index],
                  onChanged: (value) {
                    setState(() {
                      selectedOptions[index] = value;
                      print(selectedOptions[index]);
                    });
                  },
                ),
                Text(
                  question['options'][0],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'B. ',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Radio(
                  value: question['options'][1],
                  groupValue: selectedOptions[index],
                  onChanged: (value) {
                    setState(() {
                      selectedOptions[index] = value;
                      print(selectedOptions[index]);
                    });
                  },
                ),
                Text(
                  question['options'][1],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'C. ',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Radio(
                  value: question['options'][2],
                  groupValue: selectedOptions[index],
                  onChanged: (value) {
                    setState(() {
                      selectedOptions[index] = value;
                      print(selectedOptions[index]);
                    });
                  },
                ),
                Text(
                  question['options'][2],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'D. ',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Radio(
                  value: question['options'][3],
                  groupValue: selectedOptions[index],
                  onChanged: (value) {
                    setState(() {
                      selectedOptions[index] = value;
                      print(selectedOptions[index]);
                    });
                  },
                ),
                Text(
                  question['options'][3],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    size: 50.0,
                    color: Colors.grey,
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
                  alignment: Alignment.bottomRight,
                  icon: Icon(
                    Icons.arrow_right,
                    size: 50.0,
                    color: Colors.grey,
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
