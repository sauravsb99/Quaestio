import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';
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
          0.3,
      (MediaQuery.of(context).size.height - AppBar().preferredSize.height) *
          0.3,
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
                    0.3;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.3;
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
            child: Card(
              child: Stack(
                children: <Widget>[
                  // Positioned.fill(
                  //   child: Image.asset(
                  //     'assets/domain.jpg',
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xff1b1b1b),
                        image: new DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.topCenter,
                          image:  CachedNetworkImageProvider("https://guardian.ng/wp-content/uploads/2016/09/PHARMACY.jpg",),
    )
    ),


                  child: Center(
                      child: Text(
                    'Domain Specifics',
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                    ),
                      )           )),
                ],
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
              itemCount: dTopic.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, QuizListRoute,
                            arguments: dTopic[index].name);
                      },
                      title: Text(
                        dTopic[index].name,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    Divider(
                      height: (MediaQuery.of(context).size.height -
                              AppBar().preferredSize.height) *
                          0.0001,
                      color: Color(0xfffaece6),
                    ),
                  ],
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
                    0.3;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.3;
                clickedCard = null;
              } else {
                heights[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
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
//                 color: Colors.white,
                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
                     color: Color(0xffa9b6b8),
                     image: DecorationImage(
                       fit: BoxFit.fitWidth,
                       alignment: FractionalOffset.topCenter,
                       image:  CachedNetworkImageProvider("https://guardian.ng/wp-content/uploads/2016/09/PHARMACY.jpg",),
                     )
                 ),
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
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          height: heights[1],
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
          color: Color(0xffa9b6b8),
          child: ListView.builder(
              itemCount: aTopic.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    // TopicTile(
                    //   topic: aTopic[index],
                    // )
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, QuizListRoute,
                            arguments: aTopic[index].name);
                      },
                      title: Text(
                        aTopic[index].name,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    Divider(
                      height: (MediaQuery.of(context).size.height -
                              AppBar().preferredSize.height) *
                          0.0001,
                      color: Color(0xfffaece6),
                    ),
                  ],
                );
              }),
        )
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