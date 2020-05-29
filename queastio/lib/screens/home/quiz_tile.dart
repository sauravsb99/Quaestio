import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/quiz.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/constants.dart';

class QuizTile extends StatelessWidget {
  final Quiz quiz;

  QuizTile({this.quiz});

  _showUploadDialog(File file, User user, BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.all(15.0),
            title: Column(
              children: <Widget>[
                Text('Upload File'),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.grey[300],
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.picture_as_pdf, color: Colors.red),
                        Flexible(
                          child: Text(
                            Path.basename(file.path),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  print(Path.extension(file.path));
                  String type =
                      Path.extension(file.path) == '.pdf' ? 'pdf' : 'video';
                  StorageReference storageReference = FirebaseStorage.instance
                      .ref()
                      .child('fileSubmissions/${Path.basename(file.path)}');
                  StorageUploadTask uploadTask = storageReference.putFile(file);
                  try {
                    await uploadTask.onComplete;
                    String myUrl = await storageReference.getDownloadURL();
                    await DatabaseService(uid: user.uid)
                        .addDocument(quiz.qId, type, myUrl);
                  } catch (err) {
                    print(err.toString());
                  }
                },
                child: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              )
            ],
          );
        });
  }

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
                    textColor: Color(0xff0fc77e),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    textColor: Color(0xff0fc77e),
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.pushNamed(context, QuestionRoute, arguments: {
                        'questions': quiz.questions,
                        'answers': answers,
                        'qname': quiz.qName,
                        'qTopic': quiz.qTopic,
                        'firstTime': false,
                        'duration': quiz.duration
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
          isScrollControlled: true,
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
                      Wrap(children: <Widget>[
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
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Color(0xff0fc77e),
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
                          quiz.qName != 'submission'
                              ? Tooltip(
                                  message:
                                      'Note: This is a time bound test. Your answers will be submitted automatically when the time runs out',
                                  padding: EdgeInsets.all(15.0),
                                  preferBelow: false,
                                  child: Icon(
                                    (Icons.help),
                                    color: Colors.grey,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Divider(
                        height: 30.0,
                        thickness: 5.0,
                        color: Colors.black54,
                        indent: 0,
                      ),
                      Text(
                        quiz.qDesc,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      quiz.qName != 'submission'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'No of questions: ' + quiz.qCount.toString(),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'Duration: ' +
                                      quiz.duration.toString() +
                                      ' minutes',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 45.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MaterialButton(
//                          child: ClipRRect(
//                            borderRadius: BorderRadius.all(Radius.circular(50.0)),

                                      child: RaisedButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 5.0),
                                        onPressed: () {
                                          print(answers);
                                          Navigator.pushNamed(
                                              context, LeaderRoute,
                                              arguments: {'qId': quiz.qId});
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
                                              Navigator.pushNamed(
                                                  context, QuestionRoute,
                                                  arguments: {
                                                    'questions': quiz.questions,
                                                    'answers': answers,
                                                    'qname': quiz.qName,
                                                    'qId': quiz.qId,
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
                                  ],
                                ),
                              ],
                            )
                          : MaterialButton(
//                          child: ClipRRect(
//                            borderRadius: BorderRadius.all(Radius.circular(50.0)),

                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                onPressed: () async {
                                  File file = await FilePicker.getFile(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf', 'mp4'],
                                  );
                                  if (file != null) {
                                    _showUploadDialog(file, user, context);
                                  }
                                },
                                child: Text(
                                  'Choose File',
                                  style: buttonText,
                                ),
                                color: Colors.black87,
                              ),
                              onPressed: () {},
                            ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            );
          });
    }

    return InkWell(
      splashColor: Colors.white70,
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        print(quiz.questions);
        _showQuizDetails();
      },
      child: Container(
        height: 100.0,
        child: Card(
            color: Colors.black54,
            child: Center(
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 2.0),
                    child: Text(
                      quiz.qName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
