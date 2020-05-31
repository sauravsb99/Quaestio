import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queastio/models/documents.dart';
import 'package:queastio/models/user.dart';
// import 'package:queastio/screens/home/submission.dart';
import 'package:queastio/models/submission.dart';
import 'package:queastio/services/database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
class VideoSub extends StatefulWidget {
final Submission data;
//  final String url;
  VideoSub(this.data);
  @override
  VideoSubState createState() => VideoSubState(this.data);
}

class VideoSubState extends State<VideoSub> {
  VideoPlayerController playerController;
  VoidCallback listener;
//  final String url;
  final Submission data;
  VideoSubState(this.data);
   @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
    createVideo();
  }

  void createVideo() {
//    print(playerController.value.isPlaying);
    if (playerController == null) {
      playerController = VideoPlayerController.network(data.url
//          'https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/videos%2Fvlc-record-2020-04-20-14h54m10s-5_10953317656036796.mp4-.mp4?alt=media&token=5b5cb9f4-1495-4319-87c6-4de1f19ec6a2'
          )
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
//    print("What we got is ${url}");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // title: Text(data..toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white70,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      width: 15.0,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: playerController == null ? 16 / 9 : playerController.value.aspectRatio ,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: (playerController != null
                            ? VideoPlayer(
                                playerController,
                              )
                            : Container()),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            playerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: () {
                            setState(() {
                              playerController.value.isPlaying
                                  ? playerController.pause()
                                  : playerController.play();
                            });
                          },
                        ),
                        Spacer(),
                        IconButton(
                          tooltip: 'Go Back 10s',
                          icon: Icon(Icons.replay_10),
                          onPressed: () async {
                            Duration pos = await playerController.position -
                                Duration(seconds: 10);
                            setState(() {
                              playerController.seekTo(pos);
                              playerController.play();
                            });
                          },
                        ),
                        IconButton(
                          tooltip: 'Restart',
                          icon: Icon(Icons.replay),
                          onPressed: playerController.value.isPlaying
                              ? null
                              : () {
                                  setState(() {
                                    playerController.seekTo(Duration(seconds: 0));
                                    playerController.play();
                                  });
                                },
                        ),
                        IconButton(
                          tooltip: 'Download',
                          icon: Icon(Icons.file_download),
                          onPressed: () async {
                            await launch(data.url);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height:40),
              StreamBuilder<UserData>(
                  stream: DatabaseService(uid:data.uid).userData,
                  builder: (context, snapshot) {
                    UserData userData = snapshot.data;
                    return userData==null? Container() :
//                  Align(
//                    alignment: Alignment.centerLeft,
//                    child:
                    Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
//                            Align(
//                                alignment: Alignment.bottomLeft,
//                                child:

                                  Row(
                                children: [SizedBox(width: 20),
                                  Text('User :  ${userData.name}',style: TextStyle(color: Colors.white70),
                                    textAlign: TextAlign.left,),
                                ],
                              ),
                              Row(
                                children: [SizedBox(width: 20),
                                  Text(playerController.value.duration==null? ' ' : 'Duration :  ${playerController.value.duration.inSeconds.toString()}  Seconds',style: TextStyle(color: Colors.white70),
                                    textAlign: TextAlign.left,),
                                ],
                              )

//                            ),
                            ],
                          ),
                          Spacer(),


//                        Container(
//                          child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  radius: 57,

                                  backgroundColor:Color(0xff43b77d),
                                  child: ClipOval(
                                    child: SizedBox(
                                        width: 110.0,
                                        height: 110.0,
//                                  clipBehavior: Clip(heigh),
                                        child:Image.network(userData.image,fit: BoxFit.cover,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(width: 20)
//                        ),

                        ],
//                    ),
//        Align(
//              alignment: Alignment.centerLeft,
//              child: Row(
//                children: [SizedBox(width: 20),
//                  Text(playerController.value.duration==null? ' ' : 'Duration :  ${playerController.value.duration.inSeconds.toString()}  Seconds',style: TextStyle(color: Colors.white70),
//                    textAlign: TextAlign.left,),
//                ],
//              )
//          ),
//        Column(
//                    children: [
//                      Column(
//                        children: [
//                          Row(
//                            children: [SizedBox(width: 20),
//                              Text('User :  ${userData.name}',style: TextStyle(color: Colors.white70),
//                                textAlign: TextAlign.left,),
//                            ],
//                          ),
//                          Row(
//                            children: [SizedBox(width: 20),
//                              Text('User :  ${userData.batch}',style: TextStyle(color: Colors.white70),
//                                textAlign: TextAlign.left,),
//                            ],
//                          ),
//                          Row(
//                            children: [SizedBox(width: 20),
//                              CircleAvatar(
//                                radius: 77,
//
//                                backgroundColor:Color(0xff43b77d),
//                                child: ClipOval(
//                                  child: SizedBox(
//                                    width: 140.0,
//                                    height: 140.0,
////                                  clipBehavior: Clip(heigh),
//                                    child:Image.network(userData.image,fit: BoxFit.cover,)
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//
//                        ],
//                      ),
//                    ],
//                  )
                );
              }
            ),
//            Spacer(),
          ],
        ),
      ),
    );
  }
}