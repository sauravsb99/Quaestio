import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/constants.dart';

class Uploader extends StatefulWidget {
  final String qid;
  final String qname;
  final String stype;
  Uploader({this.qid,this.qname,this.stype});
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  File uploadFile;
  StorageUploadTask uploadTask;
  String type;

  showAlertDialog(String message, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Color(0xff43b77d),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeViewRoute, (route) => false);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload File"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                uploadFile != null
                    ? (uploadTask == null?
      Container(
      decoration: BoxDecoration(
      color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          type == 'pdf'
              ? Icon(Icons.picture_as_pdf, color: Colors.red)
              : Icon(Icons.video_library,
              color: Colors.orange[800]),
          Text(
            Path.basename(uploadFile.path),
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 20.0,
            ),
            onPressed: () {
              setState(() {
                uploadFile = null;
              });
            },
          )
        ],
      ),
    ):
    StreamBuilder<StorageTaskEvent>(
    stream: uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progress = event != null
              ? event.bytesTransferred / event.totalByteCount
              : 0;
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        type == 'pdf'
                            ? Icon(Icons.picture_as_pdf,
                            color: Colors.red)
                            : SizedBox(
                          child: Row(
                            children: [
                              Icon(Icons.video_library,
                                  color: Colors.orange),
                            ],
                          ),
                        ),
                        Text(
                          Path.basename(uploadFile.path),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 20.0,
                          ),
                          onPressed: () {
                            setState(() {
                              uploadFile = null;
                            });
                          },
                        ),
                        event != null
                            ? LinearProgressIndicator(
                          value: progress,
                        )
                            : Container(),
                      ],
                    ),
                  )
                  ]
              )
          );
        }
    )
                ):Container(),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Color(0xff43b77d),
                      disabledColor: Colors.grey,
                      onPressed: uploadFile == null
                          ? null
                          : () async {
                        StorageReference storageReference =
                        FirebaseStorage.instance.ref().child(
                            'fileSubmissions/${Path.basename(uploadFile.path)}');
                        setState(() {
                          uploadTask =
                              storageReference.putFile(uploadFile);
                        });
                        try {
                          await uploadTask.onComplete;
                          String myUrl =
                          await storageReference.getDownloadURL();
                          await DatabaseService(uid: user.uid)
                              .addDocument(widget.qid, type, myUrl,widget.qname,uploadFile.path);
                        showAlertDialog('Your file has been uploaded!',context);
                        } catch (err) {
                        setState(() {
                          uploadTask = null;
                          uploadFile = null;
                        });
                        showAlertDialog(err.toString(), context);
                        print(err.toString());
                        }


                        },
                      child: Text(
                        'Upload',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    widget.stype=='pdf'?IconButton(
                        color: Color(0xff43b77d),
                        onPressed: () async {
                          File file = await FilePicker.getFile(
                              type: FileType.custom,
                              allowedExtensions: ['pdf']);
                          if (file != null)
                            setState(() {
                              uploadFile = file;
                              type = '.pdf';
                            });
                        },
                        icon: Icon(Icons.attach_file)
                    ):
                    IconButton(
                        color: Color(0xff43b77d),
                        onPressed: () async {
                          File file = await FilePicker.getFile(
                              type: FileType.custom,
                              allowedExtensions: ['mp4']);
                          if (file != null)
                            setState(() {
                              uploadFile = file;
                              type = 'video';
                            });
                        },
                        icon: Icon(Icons.attach_file)
                    ),
                  ],
                ),
    ]
      )

    );
  }
}
