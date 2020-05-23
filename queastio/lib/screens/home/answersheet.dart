import 'package:flutter/material.dart';

class AnswerSheet extends StatelessWidget {
  final List questions;
  final List selected;
  AnswerSheet({this.questions, this.selected});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Answers'),
//          backgroundColor: Colors.indigo,
        ),
        body: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    questions[index]['qType'] == 'Text'
                        ? Text(
                            (index + 1).toString() +
                                '. ' +
                                questions[index]['qText'],
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.justify,
                          )
                        : Wrap(
                            children: <Widget>[
                              Text(
                                (index + 1).toString() + '. ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Image.network(questions[index]['qImage']),
                            ],
                          ),
                    SizedBox(
                      height: 60.0 * questions[index]['options'].length,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questions[index]['options'].length,
                          itemBuilder: (context, ind) {
                            return RadioListTile<String>(
                              onChanged: (value) {},
                              title: Text(questions[index]['options'][ind]),
                              groupValue: questions[index]['answer'],
                              value: questions[index]['options'][ind],
                              activeColor: Colors.green,
                            );
                          }),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text('Your Answer: ' +
                            (selected[index] != null ? selected[index] : '')),
                        questions[index]['answer'] == selected[index]
                            ? Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : Icon(Icons.close, color: Colors.red)
                      ],
                    ),
                    Divider(),
                  ],
                ),
              );
            }));
  }
}
