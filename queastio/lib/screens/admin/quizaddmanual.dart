import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/constants.dart';

class QuizAddManual extends StatefulWidget {
  final String qTopic;

  QuizAddManual({this.qTopic});
  @override
  _QuizAddManualState createState() => _QuizAddManualState(qTopic: qTopic);
}

class _QuizAddManualState extends State<QuizAddManual> {
  final _formKey = GlobalKey<FormState>();
  final String qTopic;
  String _qtype = 'timed';
  Set<String> items;

  String _stype = 'pdf';
  Set<String> itemstype;
  _QuizAddManualState({this.qTopic});
  String _quizName;
  String _quizDesc;
  String _quizTime;
  @override
  Widget build(BuildContext context) {
    _qtype = _qtype == null ? 'timed' : _qtype;
    items = Set.from(['timed']);
    items.add('submission');

    _stype = _stype == null ? 'pdf' : _stype;
    itemstype = Set.from(['pdf']);
    itemstype.add('video');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 80.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(qTopic,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontWeight: FontWeight.bold)),
              // ),
              SizedBox(height: 30.0),
              Text(
                "Enter the Quiz Name",
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'Please enter a Quiz Name' : null,
                onChanged: (val) => setState(() => _quizName = val),
              ),
              SizedBox(height: 30.0),
              Text(
                "Enter the Type",
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),

              DropdownButton<String>(
                isExpanded: true,
                value: _qtype,
                underline: Container(
                  color: Color(0xff43b77d),
                  height: 2.0,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    _qtype = newValue;
                  });
                  print(_qtype);
                },
                items: items.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
              ),
              SizedBox(height: 30.0),
              Text(
                "Enter the Quiz Description",
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: textInputDecoration,
                validator: (val) =>
                    val.isEmpty ? 'Please enter a Description' : null,
                onChanged: (val) => setState(() => _quizDesc = val),
              ),
              SizedBox(height: 30.0),

              _qtype == 'timed'
                  ? Text(
                      "Enter the Time Limit",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "Enter the Submission type",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
              _qtype == 'timed'
                  ? TextFormField(
                      // decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a Time Limit' : null,
                      onChanged: (val) => setState(() => _quizTime = val),
                    )
                  : DropdownButton<String>(
                      isExpanded: true,
                      value: _stype,
                      underline: Container(
                        color: Color(0xff43b77d),
                        height: 2.0,
                      ),
                      onChanged: (String newVal) {
                        setState(() {
                          _stype = newVal;
                        });
                        print(_stype);
                      },
                      items: itemstype.map((itemsty) {
                        return DropdownMenuItem(
                            value: itemsty, child: Text(itemsty));
                      }).toList(),
                    ),
              SizedBox(height: 20.0),
              _qtype == 'timed'
                  ? RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, QuestionsAddRoute,
                            arguments: {
                              'qTopic': qTopic,
                              'qDescr': _quizDesc,
                              'qName': _quizName,
                              // 'qCount': _quizCount,
                              'qTime': _quizTime,
                            });
                      })
                  : FlatButton(
                      onPressed: () async {
                        User user = Provider.of<User>(context, listen: false);
                        await DatabaseService(uid: user.uid).updateQuiz(
                            _quizName,
                            qTopic,
                            _qtype,
                            _stype,
                            _quizDesc,
                            0,
                            0,
                            null);
                        Navigator.pop(context);
                      },
                      child: Text("Submit"),
                      color: Color(0xff43b77d)),
            ],
          ),
        ),
      ),
    );
  }
}
