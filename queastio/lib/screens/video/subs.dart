import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:queastio/models/documents.dart';
import 'package:queastio/screens/video/Video.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'vid_sub.dart';
import 'package:queastio/models/submission.dart';

class SubList extends StatefulWidget {
  final String uid;
  SubList(this.uid);
  @override
  _SubListState createState() => _SubListState(uid: uid);
}

class _SubListState extends State<SubList> {
  final String uid;
  _SubListState({this.uid});
  @override
  Widget build(BuildContext context){
    print('success');
    return StreamBuilder<List<Submission>>(
        stream: DatabaseService().getsubs(uid,
//            qid
        ),
        builder: (context, snapshot){
//          print(.toString());
          if ( snapshot.hasData ) {
            List<Submission> docList = snapshot.data;
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
                      if(docList[index].type=='Video'){
                     print(docList[index].url);
                      Navigator.push(context,
                          PageTransition(
                              type: PageTransitionType.downToUp,
                              child: VideoSub(docList[index]),
                              duration: Duration(
                                  milliseconds: 500
                              )
                          )
                      );
                      }
                      else{
                        launch(docList[index].url);
                      }
                    },
                    title: SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Row(
                        children: [
                          Text(
                              docList[index].type.toUpperCase()
                          ),Expanded(child: SizedBox(width:10,),),
                          Text(docList[index].type.toUpperCase()
                          )

                        ],
                      ),
                    ),
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

