import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:queastio/models/documents.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/video/Video.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmissionList extends StatefulWidget {
  final String qid;
//  String qid='tanananana';
  SubmissionList(this.qid);
  @override
  _SubmissionListState createState() => _SubmissionListState(this.qid);
}

class _SubmissionListState extends State<SubmissionList> {
  final String qid;
//  String qid='bleh';
  _SubmissionListState(this.qid);
  @override
  Widget build(BuildContext context){
    print('success');
    return StreamBuilder<List<Documents>>(
        stream: DatabaseService().allDocs(
//            uid,
            qid),
        builder: (context, snapshot){
//          print(.toString());
          if ( snapshot.hasData ) {
            List<Documents> docList = snapshot.data;
            print('blaaaah ${qid}');
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    'Submissions'
                ),
//                backgroundColor: Colors.indigo,
              ),
              body: docList.length == 0
                  ? Center(
                  child: Text(
                      'No submissions yet.'
                  )
              )
                  : ListView.builder(
                itemCount: docList.length,
                itemBuilder: (
                    context, index
                    ){
                  return ListTile(
                    onTap: (){
                      if(docList[index].type=='video'){
//                      print(docList[index].url);
                        Navigator.push(context,
                            PageTransition(
                                type: PageTransitionType.downToUp,
                                child: VideoAdmin(docList[index]),
                                duration: Duration(
                                    milliseconds: 500
                                )
                            )
                        );}
                      else{
                        launch(docList[index].url);
                      }
                    },
                    title: StreamBuilder<UserData>(
                        stream: DatabaseService(uid: docList[index].uid).userData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            UserData user = snapshot.data;
                            return Card(
                              child: ListTile(
                                title: Text(
                                  user.name,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                leading: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
//                                    Container(
//                                      padding: EdgeInsets.all(8.0),
//                                      child: Text(
//                                        user.name,
//                                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
//                                      ),
//                                    ),
                                    CircleAvatar(backgroundImage: NetworkImage(user.image),backgroundColor: Color(0xff43b77d),),
                                  ],
                                ),
                                trailing: Text(docList[index].type.toUpperCase()
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
//                    trailing: Text(docList[index].type.toUpperCase()
//                    ),
                  );
                },
              ),
            );
          }
          else {
            return Loading(
            );
          }
        }
    );
  }
}