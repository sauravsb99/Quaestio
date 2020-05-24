import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  final String title = 'About Enable Employability Excellence PVT. LTD';
  final string1 =['Channelize the energy of our youth towards a purposeful career. Help them make an informedchoice in sync with their interest & ability\n','• Provide a quantifiable measure of Employability Readiness\n','• Provide a platform for practicing professionals to contribute towards Employability Excellence,without having to compromise on their work commitments'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
//      floatingActionButton:
//      Container(
//        height: 80.0,
//        width: 80.0,
//        child: FittedBox(
//          child: FloatingActionButton(backgroundColor: Colors.transparent,splashColor:Colors.transparent,onPressed: () {},
//            child: Padding(
//
//              padding: const EdgeInsets.all(4),
//              child:
//
//            ),
//          ),
//        ),
//      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
        padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,48.0),
        child: Text(
//              text: TextSpan(
//                  text:
                      'Enable Employee Excellence \(Enable\) is a platform for bridging the employability gaps prevalent among career-oriented population. Our programs are rooted in a deep understanding of the employability problem by considering multiple perspectives such as those of the employers, academia, students and policy makers. Our PURPOSE is “ Employability for All ”'),),
//              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
//                child: RichText(
//                  textAlign: TextAlign.left,
//                  text: TextSpan(
////                      style: TextStyle(fontSize: 23),
//                      text:
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('OBJECTIVES',style: TextStyle(color: Colors.black),),
                        ],
                      )
//                ),
              ),
              Divider(
                height: 30.0,
                thickness: 2.0,
                color: Color(0xffe7af51),
                indent: MediaQuery.of(context).size.width*0.3,
                endIndent: MediaQuery.of(context).size.width*0.3,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
//                  Wrap(
//                    children: <Widget>[
                      Column(

                        children: <Widget>[
                        SizedBox(height: 20,),
                          Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("• ",style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            Expanded(
                              child:Text("Channelize the energy of our youth towards a purposeful career. Help them make an informedchoice in sync with their interest & ability",style: TextStyle(color: Colors.black),)
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
                                  Text("• ",style: TextStyle(color: Colors.black),textAlign: TextAlign.start,),
                                ],
                              ),
                              Expanded(
                                  child:Text("Provide a quantifiable measure of Employability Readiness",style: TextStyle(color: Colors.black),)
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
                                  Text("• ",style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              Expanded(
                                  child:Text("Provide a platform for practicing professionals to contribute towards Employability Excellence,without having to compromise on their work commitments",style: TextStyle(color: Colors.black),)
//                                 Markdown(data: _markDownData,)
                              )

                            ],
                          ),
                        ],
                      ),
//            ],
//          )

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[SizedBox(height:MediaQuery.of(context).size.height*0.05),
                      Text('OUR APPROACH',style: TextStyle(color: Colors.black),),
                    ],
                  )
//                ),
              ),
              Divider(
                height: 30.0,
                thickness: 2.0,
                color: Color(0xff7f975f),
                indent: MediaQuery.of(context).size.width*0.3,
                endIndent: MediaQuery.of(context).size.width*0.3,
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
                              Text("• ",style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          Expanded(
                              child:Text("Our objectives are derived from our purpose of “ Employability for All ”We aim to:",style: TextStyle(color: Colors.black),)
//                                 Markdown(data: _markDownData,)
                          )

                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("• ",style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          Expanded(
                              child:Text("Continually refine our understanding of the Employability Problem through structuredengagement with all stakeholders",style: TextStyle(color: Colors.black),)
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
                              Text("• ",style: TextStyle(color: Colors.black),textAlign: TextAlign.start,),
                            ],
                          ),
                          Expanded(
                              child:Text("Play back the ‘Industry Expectations’ to the Academia and Students. Incorporate these expectations in all our programs",style: TextStyle(color: Colors.black),)
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
                              Text("• ",style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          Expanded(
                              child:Text("Influence the policymaking bodies to incorporate the ‘Industry Expectations’ into academiccurriculum",style: TextStyle(color: Colors.black),)
//                                 Markdown(data: _markDownData,)
                          )

                        ],
                      ),
                    ],
                  ),
//            ],
//          )

                ),


              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              Padding(
                  padding: const EdgeInsets.all(8.0),
//                child: RichText(
//                  textAlign: TextAlign.left,
//                  text: TextSpan(
////                      style: TextStyle(fontSize: 23),
//                      text:
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('CONTACT US :',style: TextStyle(color: Colors.black),),
                    ],
                  )
//                ),
              ),
//              Divider(
//                height: 30.0,
//                thickness: 2.0,
//                color: Color(0xff7f975f),
//                indent: MediaQuery.of(context).size.width*0.3,
//                endIndent: MediaQuery.of(context).size.width*0.3,
//              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
//                  Wrap(
//                    children: <Widget>[
                  Row(

                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: 20,),
                        Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[Row(
                              children: <Widget>[
                                Text("Website:\t  "),
                              InkWell(
                                splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child:Text("www.enable-careers.com",style: TextStyle(decoration: TextDecoration.underline, color: Color(0xff519cb7))),
                              onTap: () => launch('http://www.enable-careers.com/')
//                              async {
//                                print("ooo");
//                                final url = 'www.enable-careers.com';
//                                if (await canLaunch(url)) {
//                                  print("noo");
//                                  await launch(url);
//                                } else {
//                                  print( 'Could not launch $url');
//                                }
//                              },
                            )
    ],
    )],
                          ),
//                          Expanded(
//                              child:Text("Channelize the energy of our youth towards a purposeful career. Help them make an informedchoice in sync with their interest & ability",style: TextStyle(color: Colors.black),)
////                                 Markdown(data: _markDownData,)
//                          )

                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          Column(
////                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                        crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text("• ",style: TextStyle(color: Colors.black),textAlign: TextAlign.start,),
//                            ],
//                          ),
                          Text("E-Mail:\t  ",style: TextStyle(color: Colors.black),
//                                 Markdown(data: _markDownData,)
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child:Text("jobs@enable-careers.com",style: TextStyle(decoration: TextDecoration.underline, color: Color(0xff519cb7))),
                              onTap: () => launch('mailto:http://jobs@enable-careers.com')
//                              async {
//                                print("ooo");
//                                final url = 'www.enable-careers.com';
//                                if (await canLaunch(url)) {
//                                  print("noo");
//                                  await launch(url);
//                                } else {
//                                  print( 'Could not launch $url');
//                                }
//                              },
                          )

                        ],
                      ),
                      SizedBox(height: 20,),
                      ],

                  ),
                    Expanded(child: SizedBox(width: MediaQuery.of(context).size.width*0.1,)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:<Widget>[
                        SizedBox(width:MediaQuery.of(context).size.width*0.2,
                          child: Image.asset("assets/logo_ok.png"))
                    ],),Expanded(child: SizedBox(width: MediaQuery.of(context).size.width*0.01,)),],
                  ),
//            ],
//          )

                ),

              ),
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
