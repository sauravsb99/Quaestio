import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:queastio/models/documents.dart';
import 'package:queastio/screens/video/Video.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/loading.dart';

class VideoList extends StatefulWidget {

  final String uid;
//  String qid='tanananana';
  VideoList(this.uid);
  @override
  _VideoListState createState() => _VideoListState(this.uid);
}

class _VideoListState extends State<VideoList> {
  final String uid;
//  String qid='bleh';
  _VideoListState(this.uid);
  @override
  Widget build(BuildContext context){
    print('success');
    return StreamBuilder<List<Documents>>(
        stream: DatabaseService().geturl(uid,
//            qid
        ),
        builder: (context, snapshot){
//          print(.toString());
          if ( snapshot.hasData ) {
            List<Documents> docList = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    'Video Submissions'
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
//                      print(docList[index].url);
                      Navigator.push(context,
                          PageTransition(
                              type: PageTransitionType.downToUp,
                              child: VideoAdmin(docList[index].url),
                              duration: Duration(
                                  milliseconds: 500
                              )
                          )
                      );
                    },
                    title: Text(
                        docList[index].qid
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