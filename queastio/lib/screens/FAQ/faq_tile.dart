import 'package:flutter/material.dart';
import 'package:queastio/models/faq.dart';
import 'package:queastio/services/database.dart';

class FaqTile extends StatelessWidget {
  final Faq faq;

  FaqTile({this.faq});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.indigo,
      splashFactory: InkSplash.splashFactory,
      onTap: () {
//        print(faq.faqQuestion);
//        Navigator.pushNamed(context, '/faqanswer', arguments: faq.faqAnswer);
      },
      child: Card(

          color: Colors.indigo,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(faq.faqQuestion==null?"hi":faq.faqQuestion,
                    style: TextStyle(

                        fontSize: 20.0, color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
