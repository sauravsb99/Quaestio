import 'package:flutter/material.dart';
import 'package:queastio/screens/admin/topic_name.dart';
import 'package:queastio/screens/admin/topiclistadmin.dart';
import 'package:queastio/screens/admin/admindrawer.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';

class AdminHome extends StatelessWidget {
  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    void _InsertTopicName(String category) {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: TopicAdd(category: category,),
        );
      });
    }
    // Navigator.pop(context);
    return StreamProvider<List<Topic>>.value(
      initialData: List(),
      value: DatabaseService().topics,
      child: Stack(
      children: <Widget>[Container(
        
        child: Scaffold(
//          backgroundColor: Colors.black26,
          drawer: Drawer(
            child: AdminDrawer(),
          ),
          appBar: AppBar(
            title: Text('Quaestia'),
//            backgroundColor: Colors.indigo,
            elevation: 0.0,
          ),
          floatingActionButton:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
            Container(
              height: 70.0,
              width: 70.0,
              child: FittedBox(
                child: FloatingActionButton(elevation:0.5,backgroundColor: Color(0xff43b77d),onPressed: (){
                  _InsertTopicName("Domain Specific");
                },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text('+DS'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 70.0,
              width: 70.0,
              child: FittedBox(
                child: FloatingActionButton(elevation:0.5,backgroundColor: Color(0xff43b77d),onPressed: (){
                  _InsertTopicName("General Aptitude");
                },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text('+GA'),
                  ),
                ),
              ),
            ),
//      MaterialButton(
//    color: Color(0xff43b77d),
//        elevation: 10,
//    disabledElevation: 0,
////        heroTag: "btn1",
//    child: Text('+DS'),onPressed: (){
//    _InsertTopicName("Domain Specific");
//    },),
////    Align(
////    alignment: Alignment(0.90,0.60),
////    child:
//    MaterialButton(
//    color: Color(0xff43b77d),
//    elevation: 1,
//    disabledElevation: 0,
////    heroTag: "btn2",
//    child: Text('+GA'),onPressed: (){
//    _InsertTopicName("General Aptitude");
//    },
//    ),
//    ),
    ]
    ),
          body: TopicListAdmin(),
          
        ),
      ),
      ],
      )
    );
  }
}
