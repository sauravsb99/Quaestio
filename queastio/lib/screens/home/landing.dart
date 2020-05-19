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
          0.5,
      (MediaQuery.of(context).size.height - AppBar().preferredSize.height) *
          0.5,
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
                    0.5;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.5;
                clickedCard = null;
              } else {
                heights[1] = 0;
                heights[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.7;
                heights2[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.3;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0;
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
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.indigo[900]),
                  ),
                  Center(
                      child: Text(
                    'Domain Specifics',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
          color: Colors.indigo[900],
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
                      color: Colors.indigo,
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
                    0.5;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.5;
                clickedCard = null;
              } else {
                heights[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.7;
                heights[0] = 0;
                heights2[0] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0;
                heights2[1] = (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height) *
                    0.3;
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.indigo[900],
                    ),
                  ),
                  Center(
                      child: Text(
                    'General Aptitude',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          height: heights[1],
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
          color: Colors.white,
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
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                    Divider(
                      height: (MediaQuery.of(context).size.height -
                              AppBar().preferredSize.height) *
                          0.0001,
                      color: Colors.indigo,
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }
}
