import 'package:flutter/material.dart';
import 'package:queastio/models/quiz.dart';
import 'package:cached_network_image/cached_network_image.dart';

class QuizTile extends StatelessWidget {
  final Quiz quiz;

  QuizTile({this.quiz});

  @override
  Widget build(BuildContext context) {
    void _showQuizDetails() {
      print('dsfsdf');
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Divider(height: 20.0),
                  Text(
                    quiz.qName.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      letterSpacing: 2.0,
                      wordSpacing: 5.0,
                    ),
                  ),
                  Divider(
                    height: 30.0,
                    thickness: 5.0,
                    color: Colors.indigo,
                    indent: 0,
                  ),
                  Text(
                    'lorem idasfs sdsad fwr dfs asda wewe fdgv sdas dg asd dsvfds sfedet gddhrd sdfdsgs',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'No of questions: 10',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Topic',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        onPressed: () {},
                        child: Text(
                          'Start Quiz',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey[50],
                          ),
                        ),
                        color: Colors.limeAccent[700],
                      ),
                    ],
                  )
                ],
              ),
            );
          });
    }

    return InkWell(
      splashColor: Colors.indigo[100],
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        print(quiz.questions);
        _showQuizDetails();
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                quiz.qName.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
