import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/screens/home/topic_tile.dart';
import 'package:queastio/shared/constants.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String clickedCard;
  List<double> heights;
  List<double> heights2;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    heights = [0, 0];
    heights2 = [
      (MediaQuery.of(context).size.height - AppBar().preferredSize.height) *
          0.4,
      (MediaQuery.of(context).size.height - AppBar().preferredSize.height) *
          0.4,
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Topic> topics = Provider.of<List<Topic>>(context);
    List<Topic> dTopic =
        topics.where((topic) => topic.category == 'Domain Specific').toList();
    List<Topic> aTopic =
        topics.where((topic) => topic.category == 'General Aptitude').toList();
    return ListView(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (clickedCard == 'domain') {
                heights[0] = 0;
                heights[1] = 0;
                heights2[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.4;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.4;
                clickedCard = null;
              } else {
                heights[1] = 0;
                heights[0] = (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height);
                heights2[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.1;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.1;
                clickedCard = 'domain';
              }
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: heights2[0],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Stack(
                  children: <Widget>[
                    // Positioned.fill(
                    //   child: Image.asset(
                    //     'assets/aptitude.jpg',
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.all(18),
                      //                 color: Colors.white,
                      decoration: BoxDecoration(
                          //                     borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black87,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.topCenter,
                            image: CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/pharma.jpg?alt=media&token=8ba8c44c-1a31-4389-8d87-a0f6d6b01866"
                            ),
                          )),
                    ),
                    Center(
                        child: Text(
                      'Domain Specific',
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        letterSpacing: 3.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    //                    ],
                    //                  ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
          color: Color(0xff1b1b1b),
          height: heights[0],
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: dTopic.length,
              itemBuilder: (context, index) {
                return
                    // children: <Widget>[
                    TopicTile(
                  topic: dTopic[index],
                );
                // ListTile(
                //   onTap: () {
                //     Navigator.pushNamed(context, QuizListRoute,
                //         arguments: dTopic[index].name);
                //   },
                //   title: Text(
                //     dTopic[index].name,
                //     style: TextStyle(fontSize: 20.0, color: Colors.white),
                //   ),
                // ),
                // Divider(
                //   height: (MediaQuery.of(context).size.height -
                //           AppBar().preferredSize.height) *
                //       0.0001,
                //   color: Color(0xfffaece6),
                // ),
                // ],
                // );
              }),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (clickedCard == 'aptitude') {
                heights[0] = 0;
                heights[1] = 0;
                heights2[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.4;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.4;
                clickedCard = null;
              } else {
                heights[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        50) *
                    0.7;
                heights[0] = 0;
                heights2[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.1;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.1;
                clickedCard = 'aptitude';
              }
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: heights2[1],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Stack(
                  children: <Widget>[
                    // Positioned.fill(
                    //   child: Image.asset(
                    //     'assets/aptitude.jpg',
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.all(18),
//                 color: Colors.white,
                      decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black87,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.topCenter,
                            image: CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/quanti.jpg?alt=media&token=d6243484-1d09-49e2-861a-ab56d66d873d",
                            ),
                          )),
                    ),
                    Center(
                        child: Text(
                      'General Aptitude',
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        letterSpacing: 3.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
//                    ],
//                  ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          height: heights[1],
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
          color: Color(0xff1b1b1b),
          child: ListView.builder(
              itemCount: aTopic.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    TopicTile(
                      topic: aTopic[index],
                    ),
//                     ListTile(
//                       onTap: () {
//                         Navigator.pushNamed(context, QuizListRoute,
//                             arguments: aTopic[index].name);
//                       },
//                       title: Text(
//                         aTopic[index].name,
//                         style: TextStyle(fontSize: 20.0, color: Colors.white),
//                       ),
//                     ),
//                     Divider(
//                       height: (MediaQuery.of(context).size.height -
//                               AppBar().preferredSize.height) *
//                           0.0001,
// //                      color: Color(0xfffaece6),
//                     ),
                  ],
                );
              }),
        ),
//            SizedBox(
//              height: MediaQuery.of(context).size.height*0.05,
//              child:Image.network("https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/logo_EEE.png?alt=media&token=a3186033-a2f8-411b-8335-eabdf6a05c80"),
//        ),
      ],
    );
  }
}

//a9b6b8
//091919
//62abb9
//b0b185- 2 ennathil kand
//dac6bf
//b2b7a5
