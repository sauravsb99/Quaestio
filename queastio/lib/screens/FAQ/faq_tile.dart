import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:queastio/models/faq.dart';

class FaqTile extends StatelessWidget {
  final Faq faq;

  FaqTile({this.faq});

  @override

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ Padding(
                  padding: EdgeInsets.fromLTRB(0,10.0,10.0,10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[ Padding(
                        padding: const EdgeInsets.fromLTRB(8,8,8,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text("?  "),
                            Expanded(
//                              padding: const EdgeInsets.all(8.0),
                                child: Text(faq.faqQuestion==null?"Questions not available":faq.faqQuestion,
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
              Card(
                color: Color(0x4f43b77d),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,0,10.0,10.0),
                  child: Wrap(
                    children: <Widget>[ Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[ Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(faq.faqAnswer==null?"Answer not available":'•  ${faq.faqAnswer}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white
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
