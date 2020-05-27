import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/screens/home/about_us.dart';
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
      (MediaQuery.of(context).size.height - AppBar().preferredSize.height) *
      0.1,
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
                heights2[2] = (MediaQuery.of(context).size.height -
                               AppBar().preferredSize.height) *
                              0.1;
                clickedCard = null;
              } else {
                heights[1] = 0;
                heights[0] =
                    (MediaQuery.of(context).size.height) * 0.3 * dTopic.length+(dTopic.length*16);
                heights2[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.1;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.1;
                heights2[2] = (MediaQuery.of(context).size.height -
                               AppBar().preferredSize.height) *
                              0.0;
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
                                "https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/pharma.jpg?alt=media&token=8ba8c44c-1a31-4389-8d87-a0f6d6b01866"),
                          )),
                    ),
                    Center(
                        child: Container(
//                          color: Colors.black54,
                          decoration: BoxDecoration(color:Colors.black54,borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8,4,8,4),
                            child: Text(
                      'Domain Specific Quiz',
                      style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                            letterSpacing: 3.0,
                            fontWeight: FontWeight.bold,
                      ),
                              textAlign: TextAlign.center,
                    ),
                          ),
                        )),
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
                heights2[2] = (MediaQuery.of(context).size.height -
                               AppBar().preferredSize.height) *
                              0.1;
                clickedCard = null;
              } else {
                heights[1] =
                    ((MediaQuery.of(context).size.height) * 0.3 * aTopic.length)+(aTopic.length*16);
                heights[0] = 0;
                heights2[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.1;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.1;
                heights2[2] = (MediaQuery.of(context).size.height -
                               AppBar().preferredSize.height) *
                              0.0;
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
                        child: Container(
//                          color: Colors.black54,
                          decoration: BoxDecoration(color:Colors.black54,borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8,4,8,4),
                            child: Text(
                      'General Aptitude Quiz',
                      style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                            letterSpacing: 3.0,
                            fontWeight: FontWeight.bold,
                      ),
                    ),
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
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: aTopic.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    TopicTile(
                      topic: aTopic[index],
                    ),
                  ],
                );
              }),
        ),

        AnimatedContainer(
            duration: Duration(milliseconds: 10),
            height: heights2[2],
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//                child: Stack(
//                  children: <Widget>[
                    // Positioned.fill(
                    //   child: Image.asset(
                    //     'assets/aptitude.jpg',
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                   child:
//                   Column(
//                     children: <Widget>[
                       Container(
                          height: 80.0,
                          width: 80.0,
                          child: FittedBox(
                            alignment: Alignment.centerRight,

                            child: FloatingActionButton(elevation:10,backgroundColor: Color(0xff1b1b1b),onPressed: () {

                              Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: AboutUs(),duration: Duration(milliseconds: 500)));
//                              Navigator.pushNamed(context, AboutUsRoute);
                            },
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Image.asset("assets/logo_ok.png"),
                              ),
                            ),
                          ),
                        ),
//                       SizedBox(width: 20,)
//                     ],
//                   ),
                    //                    ],
                    //                  ),
//                  ],
////                ),
////              ),
//            ),
//          ),
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
