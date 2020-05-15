import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/quiz.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/constants.dart';

class MyQuizTileAdmin extends StatelessWidget {
  final Quiz quiz;
  MyQuizTileAdmin({this.quiz});

  DatabaseService data= new DatabaseService();

  @override
  Widget build(BuildContext context) {
    Future<void> _showNoScoreDialog(List<String> answers) async {
      return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Column(
                  children: <Widget>[
                    Text(
                        'You have already attempted this test once. You will not be scored for any attempts that follow.')
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.pushNamed(context, QuestionRoute, arguments: {
                        'questions': quiz.questions,
                        'answers': answers,
                        'qname': quiz.qName,
                        'qTopic': quiz.qTopic,
                        'firstTime': false
                      });
                    },
                  ),
                ]);
          });
    }

    void _showQuizDetails() {
      List<String> answers = quiz.questions.map((q) {
        return q['answer'].toString();
      }).toList();
      print(answers);
      showModalBottomSheet(
          context: context,
          builder: (context) {
            User user = Provider.of<User>(context, listen: false);
            return Wrap(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                  color: Colors.white70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                quiz.qName.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  letterSpacing: 2.0,
                                  wordSpacing: 5.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  quiz.qTopic,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Tooltip(
                            message:
                            'Note: This is a time bound test. Your answers will be submitted automatically when the time runs out',
                            padding: EdgeInsets.all(15.0),
                            preferBelow: false,
                            child: Icon(
                              (Icons.help),
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 30.0,
                        thickness: 5.0,
                        color: Colors.black54,
                        indent: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          quiz.qDesc,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No of questions: ' + quiz.qCount.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Duration: ' + quiz.duration.toString() + ' minutes',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     'Note: This is a time bound test. Your answers will be submitted automatically when the time runs out',
                      //     style: TextStyle(
                      //       fontSize: 18.0,
                      //       color: Colors.black87,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 45.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MaterialButton(
//                          child: ClipRRect(
//                            borderRadius: BorderRadius.all(Radius.circular(50.0)),

                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              onPressed: () {
                                print(answers);
                                Navigator.pushNamed(context, LeaderRoute,
                                    arguments: quiz.qName);
                              },
                              child: Text(
                                'Leaderboard',
                                style: buttonText,
                              ),
                              color: Colors.black87,
                            ),
                            onPressed: () {},
                          ),
                          MaterialButton(
//                          child: ClipRRect(
//                            borderRadius: BorderRadius.all(Radius.circular(50.0)),

                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              onPressed: () {
                                print(answers);
                                DatabaseService(uid: user.uid)
                                    .testAlreadyTaken(quiz.qName)
                                    .then((value) {
                                  if (value.documents.isEmpty) {
                                    Navigator.pushNamed(context, QuestionRoute,
                                        arguments: {
                                          'questions': quiz.questions,
                                          'answers': answers,
                                          'qname': quiz.qName,
                                          'qTopic': quiz.qTopic,
                                          'firstTime': true,
                                          'duration': quiz.duration
                                        });
                                  } else {
                                    _showNoScoreDialog(answers);
                                  }
                                });
                              },
                              child: Text(
                                'Start Quiz',
                                style: buttonText,
                              ),
                              color: Colors.black87,
                            ),
                            onPressed: () {},
                          ),

//                        ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),

              ],
            );
          }
          );
    }
    return  Padding(

      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.white70,
        splashFactory: InkSplash.splashFactory,
        onTap: () {
          print(quiz.questions);
          _showQuizDetails();
        },
        child: Row(
          children: <Widget>[
            Expanded(

              child: Card(
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(
                            quiz.qName.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            FlatButton(
              child: Icon( Icons.delete, color: Colors.white,),
              onPressed: (){
                User user = Provider.of<User>(context, listen: false);
                DatabaseService(uid: user.uid)
                    .deleteQuiz(quiz.qName,quiz.qTopic);
//                if(b){
//                  print(b);
//                }
              print(user.uid);
              },
            ),
          ],
        ),
      ),
    );

  }

}
