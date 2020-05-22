import 'package:charts_flutter/flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  final String title = 'About Enable Employability Excellence PVT. LTD';
  final string1 =['Channelize the energy of our youth towards a purposeful career. Help them make an informedchoice in sync with their interest & ability\n','• Provide a quantifiable measure of Employability Readiness\n','• Provide a platform for practicing professionals to contribute towards Employability Excellence,without having to compromise on their work commitments'];

  @override
  Widget build(BuildContext context) {
        final _markDownData = string1.map((x) => "- $x\n").reduce((x, y) => "$x$y");

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
        padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,48.0),
        child: RichText(
              text: TextSpan(
                  text:
                      'Enable Employee Excellence \(Enable\) is a platform for bridging the employability gaps prevalent among career-oriented population. Our programs are rooted in a deep understanding of the employability problem by considering multiple perspectives such as those of the employers, academia, students and policy makers. Our PURPOSE is “ Employability for All ”'),
        ),
      ),
              Padding(
                padding: const EdgeInsets.all(8.0),
//                child: RichText(
//                  textAlign: TextAlign.left,
//                  text: TextSpan(
////                      style: TextStyle(fontSize: 23),
//                      text:
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('OBJECTIVES',style: TextStyle(color: Colors.white),),
                        ],
                      )
//                ),
              ),
              Divider(
                height: 30.0,
                thickness: 2.0,
                color: Colors.white,
                indent: 6,
                endIndent: 300,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
//                  Wrap(
//                    children: <Widget>[
                      Column(
                        children: <Widget>[SizedBox(height: 20,),
                          Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("• ",style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Expanded(
                              child:Text("Channelize the energy of our youth towards a purposeful career. Help them make an informedchoice in sync with their interest & ability",style: TextStyle(color: Colors.white),)
//                                 Markdown(data: _markDownData,)
                            )

                    ],
                  ),
                          SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("• ",style: TextStyle(color: Colors.white),textAlign: TextAlign.start,),
                                ],
                              ),
                              Expanded(
                                  child:Text("Provide a quantifiable measure of Employability Readiness",style: TextStyle(color: Colors.white),)
//                                 Markdown(data: _markDownData,)
                              )

                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("• ",style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Expanded(
                                  child:Text("Provide a platform for practicing professionals to contribute towards Employability Excellence,without having to compromise on their work commitments",style: TextStyle(color: Colors.white),)
//                                 Markdown(data: _markDownData,)
                              )

                            ],
                          ),
                        ],
                      ),
//            ],
//          )

                ),
              )
            ]
              )
// OBJECTIVES

// • Channelize the energy of our youth towards a purposeful career. Help them make an informed
// choice in sync with their interest &amp; ability
// • Provide a quantifiable measure of Employability Readiness
// • Provide a platform for practicing professionals to contribute towards Employability Excellence,
// without having to compromise on their work commitments

// OUR APPROACH
// Our objectives are derived from our purpose of “ Employability for All ”
// We aim to:
// • Continually refine our understanding of the Employability Problem through structured
// engagement with all stakeholders
// • Play back the ‘Industry Expectations’ to the Academia and Students. Incorporate these
// expectations in all our programs
// • Influence the policymaking bodies to incorporate the ‘Industry Expectations’ into academic
// curriculum

// CONTACT US:
// WEBSITE: www.enable-careers.com
// E-MAIL:jobs@enable-careers.com`),
          ),
    );
  }
}
