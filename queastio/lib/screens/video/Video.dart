import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAdmin extends StatefulWidget {
  final String url;
  VideoAdmin(this.url);

  @override
  VideoState createState() => VideoState(this.url);
}

class VideoState extends State<VideoAdmin> {
  VideoPlayerController playerController;
  VoidCallback listener;
  final String url;

  VideoState(this.url);

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
      playerController = VideoPlayerController.network(url
//          'assets/video.mp4'
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
      appBar: AppBar(
        title: Text('Video Example'),
      ),
      body: Container(
        color: Colors.white,
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
                aspectRatio: 16 / 9,
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
