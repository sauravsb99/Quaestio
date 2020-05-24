import 'package:flutter/material.dart';
import 'package:queastio/services/database.dart';

class QuestionAdd extends StatefulWidget {
  final String qTopic;
  final String qDescr;
  final String qName;
  // final String qCount;
  final String qTime;
  QuestionAdd({this.qTopic,this.qDescr,this.qName,this.qTime});
  @override
  _QuestionAddState createState() => _QuestionAddState(qTopic: qTopic,qDescr: qDescr,qName:qName,qTime: qTime);
}

class _QuestionAddState extends State<QuestionAdd> {
final String qTopic;
  final String qDescr;
  final String qName;
  // final String qCount;
  final String qTime;
_QuestionAddState({this.qTopic,this.qDescr,this.qName,this.qTime});
int time = 0;
  int qno=1;
    int groupValue = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();
  var orderLines = <Map>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: titleController,
                    ),
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 0,
                    title: TextField(
                      controller: oneController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 0;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 1,
                    title: TextField(
                      controller: twoController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 1;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 2,
                    title: TextField(
                      controller: threeController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 2;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 3,
                    title: TextField(
                      controller: fourController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 3;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      var map = {};
                      List<String> all = [];
                      map['qno'] = qno;
                      map['qType'] = "Text";
                      map['qText'] = titleController.text;
                      all.add(oneController.text);
                      all.add(twoController.text);
                      all.add(threeController.text);
                      all.add(fourController.text);
                      var correct = all[groupValue];
                      print(correct);
                      List<String> ll = [];
                      ll.add(correct);
                      ll.add(oneController.text);
                      ll.add(twoController.text);
                      ll.add(threeController.text);
                      ll.add(fourController.text);
                      map['options'] = ll;
                      orderLines.add(map);
                      // all.removeAt(groupValue);
                      // QuizModel quizModel = QuizModel(
                      //   name: titleController.text,
                      //   correct: correct,
                      //   incorrect: all,
                      // );
                      // print(orderLines);
                      time = int.parse(qTime);
                      // widget.categoryModel.quizList.add(quizModel);
                      setState((){
                        qno = qno+1;
                      });
                      oneController.clear();
                      twoController.clear();
                      threeController.clear();
                      fourController.clear();
                      titleController.clear();
                    },
                    child: Text("ADD"),
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  FlatButton(
                      onPressed: () async{
                        await DatabaseService()
                            .updateQuiz(qName, qTopic, qDescr, qno, time, orderLines);
                      },
                      child: Text("START"),
                      color: Colors.red.withOpacity(0.2)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}