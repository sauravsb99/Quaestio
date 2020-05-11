import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:queastio/models/faq.dart';

class FaqTile extends StatelessWidget {
  final Faq faq;

  FaqTile({this.faq});

  @override

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ Card(color: Colors.white12,
        child : FlatButton(
            onPressed: () {
//        print(faq.faqQuestion);
//        Navigator.pushNamed(context, '/faqanswer', arguments: faq.faqAnswer);
            },
                color: Colors.white12,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[ Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(faq.faqQuestion==null?"Some Answer":faq.faqQuestion,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
            ),
      ),

              Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0,0,10.0,10.0),
                  child: Wrap(
                    children: <Widget>[ Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[ Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(faq.faqAnswer==null?"Some Question":faq.faqAnswer,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ]
    );
  }
}
