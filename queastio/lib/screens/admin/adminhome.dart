import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:queastio/screens/admin/topic_name.dart';
import 'package:queastio/screens/admin/topiclistadmin.dart';
import 'package:queastio/screens/admin/admindrawer.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
          body: TopicListAdmin(),
          
        ),
      ),
      // floatingactionbutton: 
      SpeedDial(
        animatedIcon: AnimatedIcons.play_pause,
        
        
        marginRight: 50,
        marginBottom: 50,
        closeManually: false,
        children: [
          SpeedDialChild(
            
            child: Icon(Icons.ac_unit),
            label:"Domain Specific",
            labelStyle: TextStyle(fontSize: 18.0,fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,),
            onTap: () {
              _InsertTopicName("Domain Specific");
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.accessibility_new),
            label:"General Aptitude",
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              _InsertTopicName("General Aptitude");
            },
          )
        ],
      )
    //   Align(
    //   alignment: Alignment(0.90,0.80),
    //   child: FloatingActionButton(
    //     heroTag: "btn1",
    //     child: Text('+DS'),onPressed: (){
    //     _InsertTopicName("Domain Specific");
    //   },),
    // ),
    // Align(
    //   alignment: Alignment(-0.90,0.80),
    //   child: FloatingActionButton(
    //     heroTag: "btn2",
    //     child: Text('+GA'),onPressed: (){
    //     _InsertTopicName("General Aptitude");
    //   },),
    // ),
      ],
      )
    );
  }
}
